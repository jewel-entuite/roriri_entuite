<cfcomponent>
<cffunction name="insert">
		<cfargument name="id" default="">
		<cfset productiveHours = diff= DateDiff("H",form.stime,form.etime)>
		<cfset Mins= DateDiff("n", form.stime,form.etime)>
		<cfset productiveMins = Mins-(productiveHours*60)>
		<cfquery name="insert" >
			INSERT INTO timesheet set 
				emp_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/>,
				project_id = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer"/>,
				modules = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_varchar"/>,
				requirement_id = <cfqueryparam value="#form.req#" cfsqltype="cf_sql_integer"/>,
				assignedby_id = <cfqueryparam value="#form.assgn#" cfsqltype="cf_sql_integer"/>,
				status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer"/>,
				start_time = <cfqueryparam value="#form.stime#" cfsqltype="cf_sql_timestamp"/>,
				end_time = <cfqueryparam value="#form.etime#" cfsqltype="cf_sql_timestamp"/>,
				description = <cfqueryparam value="#form.desc#" cfsqltype="cf_sql_varchar"/>,
				productive_hours = <cfqueryparam value="#productiveHours#" cfsqltype="cf_sql_varchar"/>,
				productive_mins=<cfqueryparam value="#productiveMins#" cfsqltype="cf_sql_varchar"/>,
				created_date = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd HH:nn:ss')#" cfsqltype="cf_sql_date"/>
		</cfquery>
		<cfreturn true>
		</cffunction>

<cffunction name="updateSheet">
	<!--- <cfdump var="#arguments#" abort> --->
		<cfargument name="id" default="">
		<cfset productiveHours = diff= DateDiff("H",arguments.stime,arguments.etime)>
		<cfset Mins= DateDiff("n", arguments.stime,arguments.etime)>
		<cfset productiveMins = Mins-(productiveHours*60)>
		<cfquery name="updateSheet" >
			UPDATE timesheet set
			project_id = <cfqueryparam value="#arguments.project#" cfsqltype="cf_sql_integer"/>,
				modules = <cfqueryparam value="#arguments.module#" cfsqltype="cf_sql_varchar"/>,
				requirement_id = <cfqueryparam value="#arguments.req#" cfsqltype="cf_sql_integer"/>,
				assignedby_id = <cfqueryparam value="#arguments.assgn#" cfsqltype="cf_sql_integer"/>,
				status_id = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_integer"/>,
				start_time = <cfqueryparam value="#arguments.stime#" cfsqltype="cf_sql_timestamp"/>,
				end_time = <cfqueryparam value="#arguments.etime#" cfsqltype="cf_sql_timestamp"/>,
				description = <cfqueryparam value="#arguments.desc#" cfsqltype="cf_sql_varchar"/>,
				productive_hours = <cfqueryparam value="#productiveHours#" cfsqltype="cf_sql_varchar"/>,
				productive_mins=<cfqueryparam value="#productiveMins#" cfsqltype="cf_sql_varchar"/>
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/>
		</cfquery>
		<cfreturn true>
	</cffunction>

	<cffunction name="getProject">
		<cfargument name="p1" default="" required="true">
		<cfargument name="id" default="">
		<!--- <cfdump var="#arguments.p1#" abort> --->
		<cfquery name="list" >
			SELECT * FROM timesheet t
			LEFT JOIN project p ON p.id = t.project_id
			LEFT JOIN requirement r ON r.id = t.requirement_id
			LEFT JOIN status s ON s.id = t.status_id
			WHERE 1=1 
			<cfif structKeyExists(arguments, "p1") AND arguments.p1 NEQ "">
				AND project_id=<cfqueryparam value="#arguments.p1#" cfsqltype="cf_sql_integer"/>
			</cfif>
			<cfif structKeyExists(arguments, "id") AND arguments.id NEQ "">
				AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/>
			</cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>

	<cffunction name="modulelist" access="remote" returnformat="JSON">
		<cfargument name="pro_id" default="" required="true">
		<cfquery name="m_list" >
		SELECT * FROM module
		WHERE project_id= <cfqueryparam value="#arguments.pro_id#" cfsqltype="cf_sql_integer"/>
		</cfquery>
		<cfreturn  m_list>
	</cffunction>



	<cffunction name="getdetails">
		<cfargument name="p1" default="">
		<cfargument name="id" default="">
		<cfargument name="emp_id" default="">
		<cfargument name="module" default="">
		<cfargument name="status" default="">
		<cfargument name="req" default="">
		<cfargument name="assgn" default="">
		<cfargument name="FSdate" default="">
		<cfargument name="FEdate" default="">
		<cfargument name="today" default="">
		<cfquery name="list" >
			SELECT *, 
				        p.name AS Pro_name, 
				        D.designation AS des_name, 
				        s.status AS timesheetstatus, 
				        a.first_name AS assigned_by_first_name, 
				        a.last_name AS assigned_by_last_name, 
				        tsk.taskDescription
				    FROM timesheet t
				    LEFT JOIN project p ON p.id = t.project_id
				    LEFT JOIN employee e ON e.id = t.emp_id
				    LEFT JOIN requirement r ON r.id = t.requirement_id
				    LEFT JOIN employee a ON a.id = t.assignedby_id
				    LEFT JOIN status s ON s.id = t.status_id
				    LEFT JOIN designation D ON e.designation = D.id
				    LEFT JOIN task tsk ON tsk.task_id = t.task_id
				    WHERE 1=1
				    <cfif arguments.emp_id NEQ "">
				        AND t.emp_id IN (<cfqueryparam value="#arguments.emp_id#" list="true" cfsqltype="cf_sql_integer"/>)
				    </cfif>
				    <cfif structKeyExists(arguments, "id") AND arguments.id NEQ"" AND arguments.emp_id EQ "">
				        AND t.emp_id IN (<cfqueryparam value="#arguments.id#" list="true" cfsqltype="cf_sql_integer"/>)
				    </cfif>
				    <cfif structKeyExists(arguments, "p1") AND arguments.p1 NEQ"">
				        AND t.project_id = <cfqueryparam value="#arguments.p1#" cfsqltype="cf_sql_integer"/>
				    </cfif>
				    <cfif structKeyExists(arguments, "today") AND arguments.today EQ 1>
				        AND CAST(t.created_date AS DATE) BETWEEN <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date"/> AND <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date"/>
				    </cfif>
				    <cfif structKeyExists(arguments, "FSdate") AND structKeyExists(arguments, "FEdate") AND arguments.FSdate NEQ"" AND arguments.FEdate NEQ"">
				        AND CAST(t.start_time AS DATE) BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_date"/> AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_date"/>
				    </cfif>
				    <cfif structKeyExists(arguments, "module") AND arguments.module NEQ "">
				        AND t.modules = <cfqueryparam value="#arguments.module#" cfsqltype="cf_sql_varchar"/>
				    </cfif>
				    <cfif structKeyExists(arguments, "status") AND arguments.status NEQ"">
				        AND t.status_id = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_integer"/>
				    </cfif>
				    <cfif structKeyExists(arguments, "req") AND arguments.req NEQ"">
				        AND t.requirement_id = <cfqueryparam value="#arguments.req#" cfsqltype="cf_sql_integer"/>
				    </cfif>
				    <cfif structKeyExists(arguments, "assgn") AND arguments.assgn NEQ"">
				        AND t.assignedby_id = <cfqueryparam value="#arguments.assgn#" cfsqltype="cf_sql_integer"/>
				    </cfif>
				    GROUP BY t.id
				    ORDER BY t.start_time ASC
				</cfquery>
		<cfreturn list>
	</cffunction>

	<cffunction name="getTotalWorkedHours">
        <cfargument name="taskId" type="string" required="true">
        <cfargument name="emp_id" type="numeric" required="true">
        <cfquery name="gethours">
            SELECT
               productive_hours, 
           		productive_mins, 
            	id,
            	start_time, 
            	task_id
	        	FROM timesheet
	        	WHERE task_id = <cfqueryparam value="#arguments.taskId#" cfsqltype="cf_sql_varchar">
	          AND emp_id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
	         ORDER BY 
    			start_time ASC;
	      </cfquery>
	    <cfreturn gethours>
	</cffunction>

	<cffunction name="getform">
		<cfargument name="id" default="">
		<cfquery name="get" >
			SELECT T.*,E.first_name,E.last_name FROM timesheet T
			LEFT JOIN employee E ON T.emp_id=E.id 
			WHERE T.id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/>
		</cfquery>
		<cfreturn get>
	</cffunction>

	<cffunction name="getAllProject">
		<cfquery name="get_all_project">
			SELECT * FROM project
		</cfquery>
		<cfreturn get_all_project>
	</cffunction>

	<cffunction name="getTimesheetEmployees">
		<cfquery name="getAllEmployees">
			SELECT * FROM employee e
			WHERE 1=1
			<cfif structKeyExists(arguments, "emp_id") AND arguments.emp_id>
				AND id NOT IN (<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">)
				AND e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			</cfif>
				AND e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
		      AND e.IsClient =<cfqueryparam value="0" cfsqltype="cf_sql_varchar"> 
		</cfquery>
		<cfreturn getAllEmployees>
	</cffunction>

	<cffunction name="getEmployeesDetails">
		<cfquery name="getEmployees">
			SELECT * FROM employee
			WHERE 1=1
			<cfif structKeyExists(arguments, "emp_id") AND arguments.emp_id>
				AND id =<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>
		</cfquery>
		<!--- <cfdump var="#getEmployees#" abort> --->
		<cfreturn getEmployees>
	</cffunction>

	<cffunction name="getAllAssignedBy">
		<cfquery name="getAllAssignedBy">
			SELECT id, role_id, first_name , last_name
            FROM employee e
            WHERE e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar"> 
            AND e.role_id IN(<cfqueryparam value="1" cfsqltype="cf_sql_integer" list="true"/>);
		</cfquery>
		<cfreturn getAllAssignedBy>
	</cffunction>
    
   <cffunction name="employeelist">
         <cfquery name="employeelist">
            SELECT id, role_id, first_name
            FROM employee e
            WHERE e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar"> 
            AND e.role_id=<cfqueryparam value="4" cfsqltype="cf_sql_integer">
         </cfquery>
        <!--- <cfdump var="#employeelist#" abort> --->
        <cfreturn employeelist>
   </cffunction>

	<cffunction name="filltering" access="public" returntype="any" output="true">
		<cfargument name="fillterByThisOrder" default=""/>
		<cfargument name="emp_id" type="numeric" required="true"/>
		<cfargument name="FSdate" type="any" required="true"/>
		<cfargument name="FEdate" type="any" required="true"/>
		<cftry>
			<cfquery name="getTimesheet">
				SELECT start_time
				, end_time
				FROM timesheet
				WHERE emp_id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer" />
				AND CAST(start_time AS DATE) 
					BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_date"/> 
					AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_date"/>
				ORDER BY start_time ASC
			</cfquery>
			<cfset returnArray = [] />
			<cfinvoke component="models.logsheet" method="admin_leave_history" id="#arguments.emp_id#" returnvariable="emp_leave"/>
			<cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
			<cfset calender  = deserializeJSON(calendar_list.company_leaves_JSON)>
			<cfset returnData = [] />
			<cfset dataUnique = [] />
			<cfset timesheetDate = queryColumnData(getTimesheet, "start_time").map(function (item){
								return dateFormat(item,"yyyy-mmm-dd");
							}) />
			<cfloop from="#parseDateTime(FSdate)#" to="#parseDateTime(FEdate)#" index="date" step="#createTimespan(1, 0, 0, 0)#">
				<cfloop collection="#arguments.fillterByThisOrder#" index="thisItem">
					<cfif NOT arrayFindNoCase(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>
						<cfif thisItem EQ "weekdays">
							<cfif NOT arrayFindNoCase(timesheetDate, dateFormat(date,"yyyy-mmm-dd"))>
								<cfif dayOfWeek(date) EQ 1>
									<cfset weeksunday ="#dateFormat(date,"dddd")#">
									<cfset dataSturct = structNew()>
									<cfset dataSturct.date = parseDateTime(dateFormat(date,"yyyy-mmm-dd"))>
									<cfset dataSturct.type = "weekday">
									<cfset dataSturct.content = weeksunday>
									<cfset arrayAppend(returnData, dataSturct)>
									<cfset arrayAppend(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>
								<cfelseif dayOfWeek(date) EQ 7>
									<cfset weeksaturday ="#dateFormat(date,"dddd")#">
									<cfset dataSturct = structNew()>
									<cfset dataSturct.date = parseDateTime(dateFormat(date,"yyyy-mmm-dd"))>
									<cfset dataSturct.type = "weekday">
									<cfset dataSturct.content = weeksaturday>
									<cfset arrayAppend(returnData, dataSturct)>
									<cfset arrayAppend(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>
								</cfif>
							</cfif>
						<cfelseif thisItem EQ "leaves">
							<cfif NOT arrayFindNoCase(timesheetDate, dateFormat(date,"yyyy-mmm-dd"))>
								<cfloop query="emp_leave">
									<cfloop from="#parseDateTime(dateformat(emp_leave.from_date,"yyyy-mmm-dd"))#" to="#parseDateTime(dateformat(emp_leave.to_date,"yyyy-mmm-dd"))#" index="b" step="#createTimespan(1, 0, 0, 0)#">
										<cfif dateformat(b,"yyyy-mmm-dd") EQ dateformat(date,"yyyy-mmm-dd")>

											<cfif dateFormat(emp_leave.from_date,"yyyy-mmm-dd") EQ dateFormat(b,"yyyy-mmm-dd") AND dateFormat(emp_leave.to_date,"yyyy-mmm-dd") EQ dateFormat(b,"yyyy-mmm-dd")>
												<cfif emp_leave.start_period EQ "FN" AND emp_leave.end_period EQ "FN">
													<cfset leave_day="HALFDAY LEAVE">
												<cfelseif emp_leave.start_period EQ "AN" AND emp_leave.end_period EQ "AN">
													<cfset leave_day="HALFDAY LEAVE">
												<cfelse>
													<cfset leave_day="LEAVE">
												</cfif>
											<cfelseif dateFormat(emp_leave.from_date,"yyyy-mmm-dd") EQ dateFormat(b,"yyyy-mmm-dd") AND dateFormat(emp_leave.to_date,"yyyy-mmm-dd") NEQ dateFormat(b,"yyyy-mmm-dd")>
												<cfif emp_leave.start_period EQ "FN">
													<cfset leave_day="LEAVE">
												<cfelse>
													<cfset leave_day="HALFDAY LEAVE ">
												</cfif>
											<cfelseif dateFormat(emp_leave.from_date,"yyyy-mmm-dd") NEQ dateFormat(b,"yyyy-mmm-dd") AND dateFormat(emp_leave.to_date,"yyyy-mmm-dd") EQ dateFormat(b,"yyyy-mmm-dd")>
												<cfif emp_leave.end_period EQ "FN">
													<cfset leave_day="HALFDAY LEAVE">
												<cfelse>
													<cfset leave_day="LEAVE">
												</cfif>
											<cfelseif dateFormat(emp_leave.from_date,"yyyy-mmm-dd") NEQ dateFormat(b,"yyyy-mmm-dd") AND dateFormat(emp_leave.to_date,"yyyy-mmm-dd") NEQ dateFormat(b,"yyyy-mmm-dd")>
												<cfset leave_day="LEAVE">
											</cfif>

											<cfset dataSturct = structNew()>
											<cfset dataSturct.date = parseDateTime(dateFormat(date,"yyyy-mmm-dd"))>
											<cfset dataSturct.type = "leave">
											<cfset dataSturct.content = leave_day>
											<cfset arrayAppend(returnData, dataSturct)>
											<cfset arrayAppend(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>

										</cfif>
									</cfloop>
								</cfloop>
							</cfif>
						<cfelseif thisItem EQ "company_leaves">
							<cfif NOT arrayFindNoCase(timesheetDate, dateFormat(date,"yyyy-mmm-dd"))>
								<cfloop query="calendar_list">
									<cfloop array="#deserializeJSON(calendar_list.company_leaves_JSON)#" index="cl">
										<cfif dateFormat(cl.DATE,"dd-mmm-yyyy") EQ dateFormat(date,"dd-mmm-yyyy")>
											<cfset dataSturct = structNew()>
											<cfset dataSturct.date = parseDateTime(dateFormat(date,"yyyy-mmm-dd"))>
											<cfset dataSturct.type = "company_leaves">
											<cfset dataSturct.content = cl.REASON>
											<cfif NOT arrayFindNoCase(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>
												<cfset arrayAppend(returnData, dataSturct)>
												<cfset arrayAppend(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>
											</cfif>
										</cfif>
									</cfloop>
								</cfloop>
							</cfif>
						<cfelseif thisItem EQ "pending_timesheet">
							<cfif NOT arrayFindNoCase(timesheetDate, dateFormat(date,"yyyy-mmm-dd"))>
								<cfset dataSturct = structNew()>
								<cfset dataSturct.date = parseDateTime(dateFormat(date,"yyyy-mmm-dd"))>
								<cfset dataSturct.type = "pending_timesheet">
								<cfset dataSturct.content = "Yet to Update.">
								<cfset arrayAppend(returnData, dataSturct)>
								<cfset arrayAppend(dataUnique, dateFormat(date,"yyyy-mmm-dd"))>
							</cfif>
						</cfif>
					</cfif>
				</cfloop>
			</cfloop>
			<cfset arraySort(returnData, function (e1, e2){
									    return compare(e1.DATE, e2.DATE);
									    }
									)>
			<cfreturn returnData />
			<cfcatch>
				<cfreturn cfcatch />
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="getStatus">
		<cfquery name="getStatus">
			SELECT * FROM status
		</cfquery>
		<cfreturn getStatus>
	</cffunction>
	<cffunction name="getrequirement">
		<cfquery name="getrequirement">
			SELECT * FROM requirement
		</cfquery>
		<cfreturn getrequirement>
	</cffunction>

<cffunction name="insertAssignedTask" access="remote" returnformat="any">
		<cftry>
			<!--- task id generation --->
			<cfset project_name = uCase(Left(#form.project_name#, 3))/>
			<cfset module_name = uCase(Left(#form.module_name#, 3))/>
			<cfquery name="getLastCode">
				SELECT id FROM task
				ORDER BY id DESC
				LIMIT 1
			</cfquery>
			<cfif getLastCode.id EQ "">
			    <cfset newCodeNumber = 1>
			<cfelse>
			    <cfset lastCode = getLastCode.id>
			    <cfset codeNumber = ListLast(lastCode, "-")>
			    <cfset newCodeNumber = Val(codeNumber) + 1>
			</cfif>
			<cfset formattedNumber = NumberFormat(newCodeNumber, "0000")>
			<cfset uniqueCode = "#project_name#-#module_name#-#formattedNumber#">
			<cfif structKeyExists(form, "assignTo") AND len(form.assignTo)>
            <cfset assignToList = form.assignTo>
			<cfelse>
            <cfset assignToList = []>
			</cfif>
			<cfif structKeyExists(form, "estimatedHours") AND len(form.estimatedHours)>
				<cfset estimatedHours = form.estimatedHours />
			<cfelse>
				<cfset estimatedHours = "null" />
			</cfif>
			<cfif structKeyExists(form, "deliverBefore") AND len(form.deliverBefore)>
				<cfset deliverBefore = form.deliverBefore />
			<cfelse>
				<cfset deliverBefore = "null" />
			</cfif>
			 <cfif arrayLen(assignToList) GT 0>
            <cfset assignToString = arrayToList(assignToList, ",")>
            <cfquery name="insertTaskHistory" result="res">
                INSERT INTO task_history SET
                    task_id = <cfqueryparam value="#uniqueCode#" cfsqltype="cf_sql_varchar">,
                    assigned_to = <cfqueryparam value="#assignToString#" cfsqltype="cf_sql_varchar">,
                    assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
                    assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
                    task_status = <cfqueryparam value="8" cfsqltype="cf_sql_varchar">
            </cfquery>
        </cfif>
        <cfquery name="insertAssignedTasks" result="testres">
            INSERT INTO task SET
                assignTo = <cfif arrayLen(assignToList) GT 0><cfqueryparam value="#assignToString#" cfsqltype="cf_sql_varchar"> <cfelse>NULL</cfif>,
                project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
                module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
                taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
                priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
                status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">,
                task_id = <cfqueryparam value="#uniqueCode#" cfsqltype="cf_sql_varchar">,
                task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
                estimatedHours = <cfif estimatedHours EQ "null">NULL<cfelse><cfqueryparam value="#estimatedHours#" cfsqltype="cf_sql_double"></cfif>,
                deliverBefore = <cfif deliverBefore EQ "null">NULL<cfelse><cfqueryparam value="#deliverBefore#" cfsqltype="cf_sql_varchar"></cfif>,
                assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
                assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">
        </cfquery>
    <cfcatch>
        <cfdump var="#cfcatch#">
        <cfabort>
    </cfcatch>
    </cftry>
</cffunction>

<cffunction name="getTaskDetails" access="remote" returnformat="any">
	<cfargument name="status" type="any" required="false" default="">
	<cfquery name="getAllTaskDetails">
		SELECT t.*, p.name AS project_name, m.name AS module_name, 
		       GROUP_CONCAT(e.first_name) AS first_name, 
		       GROUP_CONCAT(e.last_name) AS last_name, 
		       s.status, ee.first_name AS assignor 
		FROM task t
		LEFT JOIN employee e ON FIND_IN_SET(e.id, t.assignTo) > 0
		LEFT JOIN project p ON p.id = t.project
		LEFT JOIN module m ON m.id = t.module
		LEFT JOIN status s ON s.id = t.status_id
		LEFT JOIN employee ee ON ee.id = t.assigned_by
		LEFT JOIN timesheet ts ON ts.task_id = t.task_id
		WHERE 1=1
		<cfif arguments.status neq "">
		    AND t.status_id = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif structKeyExists(url, "filtertaskId") AND url.filtertaskId NEQ "">
		    AND t.task_id = <cfqueryparam value="#url.filtertaskId#" cfsqltype="cf_sql_varchar">
		</cfif>
		<cfif structKeyExists(url, "FSdate") AND structKeyExists(url, "FEdate") AND url.FSdate NEQ "" AND url.FEdate NEQ "">
		    AND t.assigned_on BETWEEN <cfqueryparam value="#url.FSdate#" cfsqltype="cf_sql_date"> 
		                         AND <cfqueryparam value="#url.FEdate#" cfsqltype="cf_sql_date">
		</cfif>
		<cfif structKeyExists(url, "prior") AND url.prior NEQ "">
		    AND t.priority = <cfqueryparam value="#url.prior#" cfsqltype="cf_sql_varchar">
		</cfif>
		<cfif structKeyExists(url, "employeeid") AND url.employeeid NEQ "">   
		    AND t.assignTo = <cfqueryparam value="#url.employeeid#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif structKeyExists(url, "assgn") AND url.assgn NEQ "">   
		    AND t.assigned_by = <cfqueryparam value="#url.assgn#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif structKeyExists(url, "status") AND url.status NEQ "">   
		    AND ts.task_id = <cfqueryparam value="#url.status#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif structKeyExists(url, "handler") AND url.handler NEQ "">
		    AND ts.status_id = <cfqueryparam value="#url.handler#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif structKeyExists(url, "project") AND url.project NEQ "">
		    AND t.project = <cfqueryparam value="#url.project#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif structKeyExists(url, "module") AND url.module NEQ "">
		    AND t.module = <cfqueryparam value="#url.module#" cfsqltype="cf_sql_integer">
		</cfif>         
		AND t.active_status = <cfqueryparam value="1" cfsqltype="cf_sql_bit">
		GROUP BY t.task_id, t.reassigned_id
		ORDER BY t.id DESC
	</cfquery>
	<cfreturn getAllTaskDetails>
</cffunction>

	<cffunction name="inactiveTaskDetails" access="remote" returnformat="any">
		<cfquery name="getinactiveTaskDetails">
			SELECT t.*,p.name as project_name, m.name as module_name, GROUP_CONCAT(e.first_name) AS first_name,GROUP_CONCAT(e.last_name) AS last_name, s.status,ee.first_name AS assignor FROM task t
			LEFT JOIN employee e ON e.id = t.assignTo
			LEFT JOIN project p on p.id = t.project
			LEFT JOIN module m on m.id = t.module
			LEFT JOIN status s on s.id = t.status_id
			LEFT JOIN employee ee ON ee.id = t.assigned_by
			WHERE t.active_status = <cfqueryparam value="0" cfsqltype="cf_sql_bit">
			GROUP BY t.task_id,t.reassigned_id
			ORDER BY t.id DESC
		</cfquery>
		<cfreturn getinactiveTaskDetails>
	</cffunction>

	<cffunction name="getWorkedHours" returntype="string">
    	<cfargument name="taskId" required="true">
    	<cfargument name="emp_id" required="true">

	   <cfquery name="workedHours">
	      SELECT 
			    t.emp_id,
			    SUM(t.productive_hours) AS total_hours,
			    SUM(t.productive_mins) AS total_mins
			FROM 
			    timesheet t
			WHERE 
			    t.task_id = <cfqueryparam value="#arguments.taskId#" cfsqltype="cf_sql_varchar"> 
			    AND t.emp_id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_varchar">
			GROUP BY 
			    t.emp_id
	    </cfquery>

	    <!-- Safely handle NULL results -->
	    <cfset hours = Val(workedHours.total_hours) />
	    <cfset mins = Val(workedHours.total_mins) />

	    <!-- Handle minutes overflow -->
	    <cfif mins GTE 60>
	        <cfset hours += mins \ 60 />
	        <cfset mins = mins MOD 60 />
	    </cfif>

	   <cfif hours LT 1>
        <cfreturn mins & " minutes">
   	</cfif>

	    <!-- Handle cases with no results -->
	    <cfif hours EQ 0 AND mins EQ 0>
	        <cfreturn 0>
	    </cfif>

	    <!-- Return formatted worked hours and minutes -->
	    <cfif mins EQ 0>
		    <cfreturn hours & " hours">
		<cfelse>
		    <cfreturn hours & " hours " & mins & " minutes">
		</cfif>
	</cffunction>


	<!--- <cffunction name="assignNonAssignedTask">
		<cfquery name="updateAssignedTask">
			UPDATE task SET 
			assignTo = <cfqueryparam value="#form.Employee#" cfsqltype="cf_sql_integer">,
			status_id = <cfqueryparam value="9" cfsqltype="cf_sql_integer">,
			assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" null="#assignTo EQ "null"#" cfsqltype="cf_sql_integer">
			WHERE id = <cfqueryparam value="#form.task_id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction> --->

	<cffunction name="assignTaskToMultipleEmployees" access="public" returntype="void">
   	<cfargument name="task_id" required="true" type="string">
   	<cfargument name="Employee" required="true" type="string"> <!-- Comma-separated list of employee IDs -->

	   <!-- Convert comma-separated employee IDs into an array -->
	   <cfset var employees = ListToArray(arguments.Employee, ",")>
    	<!-- Update the first record with the first employee -->
    	<cfdump var="#employees#">
    	<cfquery name="updateAssignedTask">
        	UPDATE task SET 
            assignTo = <cfqueryparam value="#employees[1]#" cfsqltype="cf_sql_integer">,
            status_id = <cfqueryparam value="9" cfsqltype="cf_sql_integer">,
            assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">
        	WHERE task_id = <cfqueryparam value="#arguments.task_id#" cfsqltype="cf_sql_varchar">
    	</cfquery>
    	<!-- Duplicate the task for remaining employees -->
    	<cfset updatehistory(task_id = '#arguments.task_id#',employee_id = "#employees[1]#")/>
    	<cfloop from="2" to="#ArrayLen(employees)#" index="i">
    		<cfquery name="dupetask">
    		 SELECT project, module, taskDescription, priority, task_type, estimatedHours, deliverBefore, task_id, 
                   created_on,assigned_by
            FROM task
            WHERE task_id = <cfqueryparam value="#arguments.task_id#" cfsqltype="cf_sql_varchar">
    	</cfquery>
    	<cfdump var="#dupetask#">
    		<cfdump var="#i#" label="i">
        	<cfquery name="duplicateTask">
            INSERT INTO task (project, module, taskDescription, priority, status_id, task_type, estimatedHours, deliverBefore, task_id, assignTo, assigned_on, created_on,assigned_by)
           VALUES (#dupetask.project#
           ,#dupetask.module#
           ,'#dupetask.taskDescription#'
           ,'#dupetask.priority#'         
           ,<cfqueryparam value="9" cfsqltype="cf_sql_integer">
           ,'#dupetask.task_type#'
           ,#dupetask.estimatedHours#
           ,<cfqueryparam value="#dupetask.deliverBefore#" cfsqltype="cf_sql_timestamp">
           ,'#dupetask.task_id#'
           ,<cfqueryparam value="#employees[i]#" cfsqltype="cf_sql_integer">
           ,NOW(), <cfqueryparam value="#dupetask.created_on#" cfsqltype="cf_sql_timestamp">,#dupetask.assigned_by#)
        	</cfquery>
        	<cfset updatehistory(task_id = '#dupetask.task_id#',employee_id = "#employees[i]#")/>
    	</cfloop>
	</cffunction>
	
	<cffunction name="updatehistory">
		<cfargument name="task_id" required="true" type="string">
   	<cfargument name="employee_id" required="true" type="numeric"> <!-- Comma-separated list of employee IDs -->
		<cfquery name="insertHistory">
     		INSERT INTO task_history SET
			task_id = <cfqueryparam value="#arguments.task_id#" cfsqltype="cf_sql_varchar">,
			assigned_to = <cfqueryparam value="#arguments.employee_id#" cfsqltype="cf_sql_integer">,
			assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
			assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
			task_status = <cfqueryparam value="8" cfsqltype="cf_sql_varchar">
     	</cfquery>
	</cffunction>



	<cffunction name="getTaskDetail">
		<cfset task_id = decrypt(arguments.task_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>
		<cfquery name="getTask"> 
			SELECT t.*, s.status FROM task t
			LEFT JOIN status s on s.id = t.status_id
			WHERE t.id = <cfqueryparam value="#task_id#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn getTask>
	</cffunction>

	<cffunction name="updateTask">
		<cfif form.first_assign EQ form.assignTo>
			<cfquery name="getCurrentTask">
            SELECT project, module, task_id 
            FROM task 
            WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
        	</cfquery>
        	<!-- Check if project or module has changed -->
        	<cfif getCurrentTask.recordCount>
            <cfset currentProject = getCurrentTask.project>
            <cfset currentModule = getCurrentTask.module>
            <cfset currentTaskID = getCurrentTask.task_id>
            
            <cfif currentProject NEQ form.project OR currentModule NEQ form.module>
                <!-- Regenerate task ID -->
                <cfset project_name = uCase(Left(#form.project_name#, 3)) />
                <cfset module_name = uCase(Left(#form.module_name#, 3)) />
                <cfset lastCode = currentTaskID>
                <cfset codeNumber = ListLast(lastCode, "-")>
                <cfset newCodeNumber = Val(codeNumber)>
                <cfset formattedNumber = NumberFormat(newCodeNumber, "0000")>
                <cfset uniqueCode = "#project_name#-#module_name#-#formattedNumber#">
            <cfelse>
                <cfset uniqueCode = currentTaskID>
            </cfif>
        	</cfif>
			<cfquery name="updateTask">
				UPDATE task SET 
				project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
				module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
				taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
				assignTo = <cfqueryparam value="#form.assignTo#" cfsqltype="cf_sql_integer">,
				priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
				estimatedHours = <cfqueryparam value="#form.estimatedHours#" cfsqltype="cf_sql_double">,
				deliverBefore = <cfqueryparam value="#form.deliverBefore#" cfsqltype="cf_sql_varchar">,
				task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
				status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">,
				assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" null="#assignTo EQ "null"#" cfsqltype="cf_sql_integer">,
				assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">
				WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
			</cfquery>
		<cfelse>
			<cfquery name="reAssignTask">
				INSERT INTO task SET
				project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
				module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
				taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
				assignTo = <cfqueryparam value="#form.assignTo#" cfsqltype="cf_sql_integer">,
				priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
				estimatedHours = <cfqueryparam value="#form.estimatedHours#" cfsqltype="cf_sql_double">,
				deliverBefore = <cfqueryparam value="#form.deliverBefore#" cfsqltype="cf_sql_varchar">,
				task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
				status_id = <cfqueryparam value="12" cfsqltype="cf_sql_integer">,
				task_id = <cfqueryparam value="#getReassignDetails.task_id#" cfsqltype="cf_sql_varchar">,
				reassigned_id =<cfqueryparam value="#reassigned_id#" cfsqltype="cf_sql_varchar">,
				assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
				assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">
			</cfquery>			
		</cfif>
		<cfquery name="getReassignDetails">
		 	SELECT t.task_id, t.reassigned_id  FROM task t
		 	WHERE t.task_id IN (
		 								SELECT task_id FROM task WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
		 								)
		 	ORDER BY t.reassigned_id DESC
		</cfquery>
		<cfif getReassignDetails.reassigned_id EQ "">
		    <cfset reassigned_id = 1 />
		<cfelse>
		    <cfset reassigned_id = getReassignDetails.reassigned_id + 1 />
		</cfif>
		<cfquery name="insertTaskHistory" result="res">
				INSERT INTO task_history SET
				task_id = <cfqueryparam value="#getReassignDetails.task_id#" cfsqltype="cf_sql_varchar">,
				assigned_to = <cfqueryparam value="#form.assignTo#" cfsqltype="cf_sql_integer">,
				assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
				assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
				task_status = <cfqueryparam value="8" cfsqltype="cf_sql_varchar">
		</cfquery>
	</cffunction>

<cffunction name="updateTask">
		<cftry>
			<cfif IsArray(form.assignTo)>
			      <cfset assignToList = ArrayToList(form.assignTo)>
				 <cfelse>
				   <cfset assignToList = form.assignTo>
		    	</cfif>
		    	 
		    	<cfif form.first_assign EQ assignToList>
				<cfquery name="getCurrentTask">
	            SELECT project, module, task_id 
	            FROM task 
	            WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
	        	</cfquery>
	        	<!-- Check if project or module has changed -->
	        	<cfif getCurrentTask.recordCount>
	            <cfset currentProject = getCurrentTask.project>
	            <cfset currentModule = getCurrentTask.module>
	            <cfset currentTaskID = getCurrentTask.task_id>
	            
	            <cfif currentProject NEQ form.project OR currentModule NEQ form.module>
	                <!-- Regenerate task ID -->
	                <cfset project_name = uCase(Left(#form.project_name#, 3)) />
	                <cfset module_name = uCase(Left(#form.module_name#, 3)) />
	                <cfset lastCode = currentTaskID>
	                <cfset codeNumber = ListLast(lastCode, "-")>
	                <cfset newCodeNumber = Val(codeNumber)>
	                <cfset formattedNumber = NumberFormat(newCodeNumber, "0000")>
	                <cfset uniqueCode = "#project_name#-#module_name#-#formattedNumber#">
	            <cfelse>
	                <cfset uniqueCode = currentTaskID>
	            </cfif>
	        	</cfif>
				<cfquery name="updateTask">
					UPDATE task SET 
					project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
					module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
					taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
					assignTo = <cfqueryparam value="#assignToList#" cfsqltype="cf_sql_varchar">,
					priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
					estimatedHours = <cfqueryparam value="#form.estimatedHours#" cfsqltype="cf_sql_double">,
					deliverBefore = <cfqueryparam value="#form.deliverBefore#" cfsqltype="cf_sql_varchar">,
					task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
					status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">,
					assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" null="#NOT Len(assignToList)#" cfsqltype="cf_sql_integer">,
					assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
					task_id = <cfqueryparam value="#uniqueCode#" cfsqltype="cf_sql_varchar">
					WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
				</cfquery>
			<cfelse>
				<cfquery name="updatePriorAssignedTask">
					UPDATE task SET 
					active_status = <cfqueryparam value="0" cfsqltype="cf_sql_bit">
					WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfquery name="getReassignDetails">
				 	SELECT t.task_id, t.reassigned_id  FROM task t
				 	WHERE t.task_id IN (
				 								SELECT task_id FROM task WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
				 								)
				 	ORDER BY t.reassigned_id DESC
				</cfquery>
				<cfif getReassignDetails.reassigned_id EQ "">
				    <cfset reassigned_id = 1 />
				<cfelse>
				    <cfset reassigned_id = getReassignDetails.reassigned_id + 1 />
				</cfif>

				<cfquery name="reAssignTask">
					INSERT INTO task SET
					project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
					module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
					taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
					assignTo = <cfqueryparam value="#assignToList#" cfsqltype="cf_sql_varchar">,
					priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
					estimatedHours = <cfqueryparam value="#form.estimatedHours#" cfsqltype="cf_sql_double">,
					deliverBefore = <cfqueryparam value="#form.deliverBefore#" cfsqltype="cf_sql_varchar">,
					task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
					status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">,
					task_id = <cfqueryparam value="#getReassignDetails.task_id#" cfsqltype="cf_sql_varchar">,
					reassigned_id =<cfqueryparam value="#reassigned_id#" cfsqltype="cf_sql_varchar">,
					assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
					assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">
				</cfquery>
				<cfquery name="insertTaskHistory" result="res">
					INSERT INTO task_history SET
					task_id = <cfqueryparam value="#getReassignDetails.task_id#" cfsqltype="cf_sql_varchar">,
					assigned_to = <cfqueryparam value="#assignToList#" cfsqltype="cf_sql_varchar">,
					assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
					assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
					task_status = <cfqueryparam value="8" cfsqltype="cf_sql_varchar">
				</cfquery>
			</cfif>
			<cfcatch>
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
		</cftry>
	</cffunction>


	<cffunction name="getAllDetails" access="remote" returnformat="any">
		<cfargument name="task_id" type="any" required="false" default="">
		<cfquery name="getDetails">
		    WITH TaskRanked AS (
        SELECT DISTINCT
            th.*, 
            e.first_name AS first_name,
            e.last_name AS last_name,
            ee.first_name AS assignorname,	
            t.taskDescription AS scope,
            t.deliverBefore,
            t.estimatedHours,
            CASE 
                WHEN ROW_NUMBER() OVER (PARTITION BY th.task_id ORDER BY th.id ASC) = 1 THEN 0 
                ELSE 1 
            END AS reassigned_id
        FROM 
            task_history th
        LEFT JOIN 
            task t ON t.task_id = th.task_id
        LEFT JOIN 
            employee e ON e.id = th.assigned_to
        LEFT JOIN 
            employee ee ON ee.id = th.assigned_by
        WHERE 
            1=1
            <cfif arguments.task_id neq "">
                AND th.task_id = <cfqueryparam value="#arguments.task_id#" cfsqltype="cf_sql_varchar">
            </cfif>
             GROUP BY 
		        th.assigned_to,th.task_id,t.estimatedHours,t.status_id
    )
    SELECT * FROM TaskRanked
    ORDER BY id DESC;
		</cfquery>
		<cfreturn getDetails>
	</cffunction>

	<cffunction name="Project">
		<cfargument name="p1" default="" required="true">
		<cfargument name="id" default="">
		<cfargument name="task_id" default="">
		<cfquery name="list" >
			SELECT * FROM timesheet t
			LEFT JOIN project p ON p.id = t.project_id
			LEFT JOIN requirement r ON r.id = t.requirement_id
			LEFT JOIN status s ON s.id = t.status_id
			WHERE 1=1 
			<cfif structKeyExists(arguments, "p1") AND arguments.p1 NEQ "">
				AND project_id=<cfqueryparam value="#arguments.p1#" cfsqltype="cf_sql_integer"/>
			</cfif>
			<cfif structKeyExists(arguments, "id") AND arguments.id NEQ "">
				AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/>
			</cfif>
			<cfif structKeyExists(arguments, "task_id") AND arguments.task_id NEQ "">
            AND t.task_id = <cfqueryparam value="#arguments.task_id#" cfsqltype="cf_sql_varchar"/>
        </cfif>
		</cfquery>
		<cfreturn list>
	</cffunction>
</cfcomponent>
