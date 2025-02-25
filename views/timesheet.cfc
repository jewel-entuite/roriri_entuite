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
		<!--- <cfargument name="year" default=""> --->
		<!--- <cfargument name="month" default=""> --->
		<cfargument name="module" default="">
		<cfargument name="status" default="">
		<cfargument name="req" default="">
		<cfargument name="assgn" default="">
		<cfargument name="FSdate" default="">
		<cfargument name="FEdate" default="">
		<cfargument name="today" default="">
		<!--- <cfdump var="#arguments#" abort> --->
		<cfquery name="list" >
			SELECT *,p.name AS Pro_name,D.designation AS des_name,s.status AS timesheetstatus,a.first_name AS assigned_by_first_name, a.last_name AS assigned_by_last_name FROM timesheet t
			LEFT JOIN project p ON p.id = t.project_id
			LEFT JOIN employee e ON e.id = t.emp_id
			LEFT JOIN requirement r ON r.id = t.requirement_id
			LEFT JOIN employee a ON a.id = t.assignedby_id
			LEFT JOIN status s ON s.id = t.status_id
			LEFT JOIN designation D ON e.designation=D.id
			WHERE 1=1
			<cfif arguments.emp_id NEQ "">
			AND emp_id IN (<cfqueryparam value="#arguments.emp_id#" list="true" cfsqltype="cf_sql_integer"/>)
				</cfif>
			<cfif structKeyExists(arguments, "id") AND arguments.id NEQ"" AND arguments.emp_id EQ "">
				AND emp_id IN (<cfqueryparam value="#arguments.id#" list="true" cfsqltype="cf_sql_integer"/>)
			</cfif>
			<cfif structKeyExists(arguments, "p1") AND arguments.p1 NEQ"">
				AND project_id=<cfqueryparam value="#arguments.p1#" cfsqltype="cf_sql_integer"/>
			</cfif>
			<cfif structKeyExists(arguments, "today") AND arguments.today EQ 1>
				AND CAST(created_date AS DATE) BETWEEN <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date"/> AND <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date"/>
			</cfif>
			<cfif structKeyExists(arguments, "FSdate") AND structKeyExists(arguments, "FEdate") AND arguments.FSdate NEQ"" AND arguments.FEdate NEQ"">
				AND CAST(start_time AS DATE) BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_date"/> AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_date"/>
			</cfif>

			<cfif structKeyExists(arguments, "module") AND arguments.module NEQ "">
				AND modules=<cfqueryparam value="#arguments.module#" cfsqltype="cf_sql_varchar"/>
			</cfif>
			<cfif structKeyExists(arguments, "status") AND arguments.status NEQ"">
				AND status_id = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_integer"/>
			</cfif>
			<cfif structKeyExists(arguments, "req") AND arguments.req NEQ"">
				AND requirement_id=<cfqueryparam value="#arguments.req#" cfsqltype="cf_sql_integer"/>
			</cfif>
			<cfif structKeyExists(arguments, "assgn") AND arguments.assgn NEQ"">
				AND assignedby_id=<cfqueryparam value="#arguments.assgn#" cfsqltype="cf_sql_integer"/>
			</cfif>
			ORDER BY t.start_time ASC
		</cfquery>
		<cfreturn list>
		<!--- <cfdump var="#list#" abort="true"> --->
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
			SELECT * FROM employee
			WHERE 1=1
			<cfif structKeyExists(arguments, "emp_id") AND arguments.emp_id>
				AND id NOT IN (<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">)
			</cfif>
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
								<cfset dataSturct.content = "Update Pending...">
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
				SELECT task_id FROM task
				ORDER BY id DESC
				LIMIT 1
			</cfquery>
			<cfif getLastCode.task_id EQ "">
			    <cfset newCodeNumber = 1>
			<cfelse>
			    <cfset lastCode = getLastCode.task_id>
			    <cfset codeNumber = ListLast(lastCode, "-")>
			    <cfset newCodeNumber = Val(codeNumber) + 1>
			</cfif>
			<cfset formattedNumber = NumberFormat(newCodeNumber, "0000")>
			<cfset uniqueCode = "#project_name#-#module_name#-#formattedNumber#">

		<cfif structKeyExists(form, "assignTo") AND len(form.assignTo)>
			<cfset assignTo = form.assignTo>
		<cfelse>
			<cfset assignTo = "null">
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
		<cfif structKeyExists(form, "assignTo") AND form.assignTo NEQ "">
			<cfquery name="insertTaskHistory" result="res">
					INSERT INTO task_history SET
					task_id = <cfqueryparam value="#uniqueCode#" cfsqltype="cf_sql_varchar">,
					assigned_to = <cfqueryparam value="#form.assignTo#" cfsqltype="cf_sql_integer">,
					assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
					assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
					task_status = <cfqueryparam value="8" cfsqltype="cf_sql_varchar">
			</cfquery>
		</cfif>
		<cfquery name="insertAssignedTask" >
			INSERT INTO task SET 
				assignTo = <cfif assignTo EQ "null">NULL<cfelse><cfqueryparam value="#assignTo#" cfsqltype="cf_sql_integer"></cfif>,
				project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
				module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
				taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
				priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
				status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">,
				task_id = <cfqueryparam value="#uniqueCode#" cfsqltype="cf_sql_varchar">,
				task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
				estimatedHours = <cfif estimatedHours EQ "null">NULL<cfelse><cfqueryparam value="#estimatedHours#" cfsqltype="cf_sql_integer"></cfif>,
				deliverBefore = <cfif deliverBefore EQ "null">NULL<cfelse><cfqueryparam value="#deliverBefore#" cfsqltype="cf_sql_varchar"></cfif>,
				assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" null="#assignTo EQ "null"#" cfsqltype="cf_sql_integer">
		</cfquery>

				<cfcatch>
					<cfdump var="#cfcatch#"><cfabort>
				</cfcatch>
			</cftry>
	</cffunction>

	<cffunction name="getTaskDetails" access="remote" returnformat="any">
		<cfquery name="getAllTaskDetails">
			SELECT t.*,p.name as project_name, m.name as module_name, e.first_name,e.last_name, s.status,ee.first_name AS assignor FROM task t
			LEFT JOIN employee e ON e.id = t.assignTo
			LEFT JOIN project p on p.id = t.project
			LEFT JOIN module m on m.id = t.module
			LEFT JOIN status s on s.id = t.status_id
			LEFT JOIN employee ee ON ee.id = t.assigned_by
			ORDER BY t.id DESC
		</cfquery>
		<cfreturn getAllTaskDetails>
	</cffunction>
	<cffunction name="getWorkedHours">
		<cfargument name="taskId" required="true">
		<cfquery name="workedHours">
			SELECT 
			    t.productive_hours AS total_hours , t.productive_mins AS total_mins
			FROM 
			    timesheet t
			INNER JOIN 
			    task_history th ON t.task_id = th.task_id
			WHERE 
			    th.task_id = <cfqueryparam value="#arguments.taskId#" cfsqltype="cf_sql_varchar">
			GROUP BY 
			    t.id
		</cfquery>
		<cfset hours = 0 />
		<cfset mins = 0 />
		<cfloop query="workedHours" >
			<cfset hours += total_hours />
			<cfset mins += total_mins />
		</cfloop>
		<cfif hours NEQ 0 >
			<cfreturn hours & " hours " & mins & " minutes " />
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>
	<cffunction name="assignNonAssignedTask">
		<cfquery name="updateAssignedTask">
			UPDATE task SET 
			assignTo = <cfqueryparam value="#form.Employee#" cfsqltype="cf_sql_integer">,
			status_id = <cfqueryparam value="9" cfsqltype="cf_sql_integer">
			WHERE id = <cfqueryparam value="#form.task_id#" cfsqltype="cf_sql_integer">
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
		<cfquery name="updateTask">
			UPDATE task SET 
			project = <cfqueryparam value="#form.project#" cfsqltype="cf_sql_integer">,
			module = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_integer">,
			taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
			assignTo = <cfqueryparam value="#form.assignTo#" cfsqltype="cf_sql_integer">,
			priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
			estimatedHours = <cfqueryparam value="#form.estimatedHours#" cfsqltype="cf_sql_integer">,
			deliverBefore = <cfqueryparam value="#form.deliverBefore#" cfsqltype="cf_sql_varchar">,
			task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
			status_id = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_integer">
			WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>
	
</cfcomponent>
