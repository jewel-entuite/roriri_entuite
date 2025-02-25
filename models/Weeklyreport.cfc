<cfcomponent>
	
	<cffunction name="getAllEmployeeDetails" access="public" returntype="struct">
		<cfargument name="emp_id" default="">
		<cfargument name="FSdate" default="">
		<cfargument name="FEdate" default="">
		<cfquery name="allEmployee" datasource="entuite_hrms_dsn">
			SELECT first_name,employee_joining_date FROM employee
			WHERE 1=1
			AND status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND id =<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>
			AND IsClient =<cfqueryparam value="0" cfsqltype="cf_sql_varchar">
			 ORDER BY id ASC
		 
		 </cfquery>
		 <cfquery name="employeeList" datasource="entuite_hrms_dsn">
			SELECT first_name,employee_joining_date FROM employee
			WHERE 1=1
			AND status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND id =<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>
			 ORDER BY id ASC
		 
		 </cfquery>
	   
	   <cfquery name="allEmployeeAttendanceDetails" datasource="entuite_hrms_dsn">
			SELECT E.first_name, DATE(A.created_date) AS created_date FROM employee E
			 INNER JOIN attendance A ON A.employee_id = E.id AND DATE(A.created_date) BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_timestamp">
								 AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_timestamp">
			 WHERE 1=1
			 AND E.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND E.id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>	
			GROUP BY E.first_name, DATE(A.created_date)	
	 
		</cfquery>
		 <cfquery name="allEmployeeLogDetails" datasource="entuite_hrms_dsn">
			SELECT E.first_name, DATE(A.created_date) AS created_date, A.total_hours FROM employee E
			 INNER JOIN attendance A ON A.employee_id = E.id AND DATE(A.created_date) BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_timestamp">
								 AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_timestamp">
			 WHERE 1=1
			 AND E.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND E.id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>	
			GROUP BY E.first_name, DATE(A.created_date)	, A.total_hours
		 
		 </cfquery>

		 <cfquery name="allEmployeeWFHDetails" datasource="entuite_hrms_dsn">
			SELECT E.first_name,WH.start_date,WH.end_date  FROM employee E
			 INNER JOIN wfh_history WH ON WH.employee_id = E.id AND WH.start_date BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_timestamp">
								 AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_timestamp">
			 WHERE 1=1
			 AND E.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">

			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND E.id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>										

			 ORDER BY E.id ASC
		 
		 </cfquery>
		 <cfquery name="allEmployeeLeaveDetails" datasource="entuite_hrms_dsn">
			SELECT E.first_name,LH.to_date,LH.from_date  FROM employee E
			 INNER JOIN leave_history LH ON LH.employee_id = E.id AND LH.from_date BETWEEN <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_timestamp">
								 AND <cfqueryparam value="#arguments.FEdate#" cfsqltype="cf_sql_timestamp"> 

			 WHERE 1=1
			 AND E.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND E.id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>					

			 ORDER BY E.id ASC
		 
		 </cfquery>
		 
		 <cfquery name="allEmployeeTimeSheetDetails" datasource="entuite_hrms_dsn">
			<cfset FEdate = DATEADD("d", 1, arguments.FEdate)>
			 SELECT E.first_name, T.start_time,T.productive_hours,T.productive_mins  
			 FROM employee E
			 INNER JOIN timesheet T ON T.emp_id = E.id 
			 AND T.start_time >= <cfqueryparam value="#arguments.FSdate#" cfsqltype="cf_sql_timestamp">
			   AND T.start_time < <cfqueryparam value="#FEdate#" cfsqltype="cf_sql_timestamp">
			   WHERE 1=1
			   AND E.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND len(arguments.emp_id)>
				AND E.id= <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
			</cfif>		  
			 ORDER BY E.id ASC
 
		  </cfquery>
		 <cfscript>
			allEmployeeDetails = {}
			allEmployeeDetails.employee = allEmployee
			allEmployeeDetails.attendance = allEmployeeAttendanceDetails
			allEmployeeDetails.wfh = allEmployeeWFHDetails
			allEmployeeDetails.leave = allEmployeeLeaveDetails
			allEmployeeDetails.timesheet = allEmployeeTimeSheetDetails
			allEmployeeDetails.logDetails = allEmployeeLogDetails
			// allEmployeeDetails.employeeList = employeeList
		 </cfscript>
		 <cfset employeeDetails = {}>
		<cfset weekendDays = {}> 


		<cfset currentDate = parseDateTime(url.FSdate)>
		

		<cfloop condition="#currentDate LTE parseDateTime(url.FEdate)#">
			<cfloop query="#allEmployeeDetails.employee#">
				<cfscript>
					employeeName = allEmployeeDetails.employee.first_name
					dateKey = dateFormat(currentDate, 'dd-mm-yyyy')
				</cfscript>
				<cfif !structKeyExists(employeeDetails, employeeName)>
					<cfset employeeDetails[employeeName] = {}>
				</cfif>

				<cfif structKeyExists(employeeDetails[employeeName], dateKey)>
					<cfset employeeDetails[employeeName][dateKey] = {}>
				</cfif>
				
				<cfif allEmployeeDetails.employee.employee_joining_date NEQ "" AND datecompare(#allEmployeeDetails.employee.employee_joining_date#, #currentDate#) EQ -1>
				
					<cfset employeeDetails[employeeName][dateKey]["produc_mins"]=0>
					<cfset employeeDetails[employeeName][dateKey]["log_hrs"]=0>
				
				<cfelseif allEmployeeDetails.employee.employee_joining_date EQ "">
					<cfset employeeDetails[employeeName][dateKey]["produc_mins"]=0>
					<cfset employeeDetails[employeeName][dateKey]["log_hrs"]=0>
				<cfelse>
					<cfset employeeDetails[employeeName][dateKey]["produc_mins"]="0">
					<cfset employeeDetails[employeeName][dateKey]["log_hrs"]=0>
					<cfset employeeDetails[employeeName][dateKey]["newJoinee"]="yes">
					
				</cfif>
				<cfset dayOfWeek = DayOfWeek(currentDate)>
				<cfif dayOfWeek EQ 1 OR dayOfWeek EQ 7>
					<cfset weekendDays[dateKey] = dayOfWeek>
				</cfif>
			</cfloop>
			<cfset currentDate = dateAdd('d', 1, currentDate)>
		</cfloop>
		<cfset employeeAttendanceCount = {}>


		<cfloop query="#allEmployeeDetails.attendance#">
			<cfset employeeName = allEmployeeDetails.attendance.first_name>
			<cfset dateKey = dateformat(allEmployeeDetails.attendance.created_date, "dd-mm-yyyy")>
			
			<cfif structKeyExists(employeeDetails, employeeName) AND structKeyExists(employeeDetails[employeeName], dateKey)>
				<cfif !structKeyExists(employeeAttendanceCount, employeeName)>
					<cfset employeeAttendanceCount[employeeName] = 1>
				<cfelse>
					<cfset employeeAttendanceCount[employeeName]++>
				</cfif>
				
				<cfset employeeDetails[employeeName][dateKey]["attendance"] = allEmployeeDetails.attendance.created_date>

			</cfif>
		</cfloop>
		<cfloop query="#allEmployeeDetails.logDetails#">
			<cfset employeeName = allEmployeeDetails.logDetails.first_name>
			<cfset dateKey = dateformat(allEmployeeDetails.logDetails.created_date, "dd-mm-yyyy")>
			<cfif !structKeyExists(employeeDetails, employeeName)>
				<cfset employeeDetails[employeeName] = {}>
			</cfif>
			<cfif len(allEmployeeDetails.logDetails.total_hours)>
				<!--- <cfoutput>#hour(allEmployeeDetails.logDetails.total_hours)#</cfoutput><br> --->
				<cfset employeeDetails[employeeName][dateKey]["log_hrs"] +=(hour(allEmployeeDetails.logDetails.total_hours)*60)+minute(allEmployeeDetails.logDetails.total_hours)>
			<cfelse>
				<cfset employeeDetails[employeeName][dateKey]["no_log_hrs"]=1>
			</cfif>
		</cfloop>
		<cfloop query="#allEmployeeDetails.timesheet#">
			<cfset employeeName = allEmployeeDetails.timesheet.first_name>
			<cfset dateKey = dateFormat(allEmployeeDetails.timesheet.start_time, "dd-mm-yyyy")>
			<cfif !structKeyExists(employeeDetails, employeeName)>
				<cfset employeeDetails[employeeName] = {}>
			</cfif>
			
			<cfif !structKeyExists(employeeDetails[employeeName], dateKey)>
				<cfset employeeDetails[employeeName][dateKey] = {"produc_mins": 0}>
			</cfif>
			
			<cfset employeeDetails[employeeName][dateKey]["produc_mins"] += (allEmployeeDetails.timesheet.productive_hours * 60) + allEmployeeDetails.timesheet.productive_mins>
		</cfloop>
		<cfset leaveCount = {}>
		<cfloop query="#allEmployeeDetails.leave#">
			<cfset employeeName = allEmployeeDetails.leave.first_name>
			<cfset fromDate = allEmployeeDetails.leave.from_date>
			<cfset toDate = allEmployeeDetails.leave.to_date>

			<cfset currentDate = fromDate>
			<cfloop condition="#currentDate LTE toDate#">
				<cfset dateKey = dateFormat(currentDate, "dd-mm-yyyy")>

				<cfif structKeyExists(employeeDetails, employeeName) AND structKeyExists(employeeDetails[employeeName], dateKey)>
					<cfif !structKeyExists(leaveCount, employeeName)>
						<cfset leaveCount[employeeName] = 1>
					<cfelse>
						<cfset leaveCount[employeeName]++>
					</cfif>
					
					<cfset employeeDetails[employeeName][dateKey]["leave"] = true>
				</cfif>


				<cfset currentDate = dateAdd("d", 1, currentDate)>
			</cfloop>
		</cfloop>
		<cfloop query="#allEmployeeDetails.wfh#">
			<cfset employeeName = allEmployeeDetails.wfh.first_name>
			<cfset fromDate = allEmployeeDetails.wfh.start_date>
			<cfset toDate = allEmployeeDetails.wfh.end_date>

			<cfset currentDate = fromDate>
			<cfloop condition="#currentDate LTE toDate#">
				<cfset dateKey = dateFormat(currentDate, "dd-mm-yyyy")>

				<cfif structKeyExists(employeeDetails, employeeName) AND structKeyExists(employeeDetails[employeeName], dateKey)>
					<cfset employeeDetails[employeeName][dateKey]["wfh"] = true>
				</cfif>

				<cfset currentDate = dateAdd("d", 1, currentDate)>
			</cfloop>
		</cfloop>

		
		<cfquery name="companyLeaves" datasource="entuite_hrms_dsn">
			SELECT company_leaves_JSON FROM company_leaves
		</cfquery>
		<cfset holidayDetails = {}>

		<cfloop query="companyLeaves">
			<cfset datesList = deserializeJSON(companyLeaves.company_leaves_JSON)>

			<cfloop from="1" to="#arrayLen(datesList)#" index="i">
				<cfset dateKey = dateformat(datesList[i]["DATE"], "dd-mm-yyyy")>
				<cfset reason = datesList[i]["REASON"]>

				<cfset holidayDetails[dateKey] = reason>
			</cfloop>
		</cfloop>
		 <cfinvoke component="models.Weeklyreport" startdate="#url.FSdate#" enddate="#url.FEdate#" method="workingDaysHours" returnvariable="workingDaysCount">
		<cfset detailsStruct ={}>
		<cfset detailsStruct.allEmployeeDetails =allEmployeeDetails>
		<cfset detailsStruct.attendanceCount =employeeAttendanceCount>
		<cfset detailsStruct.weekendDays =weekendDays>
		<cfset detailsStruct.employeeDetails =employeeDetails>
		<cfset detailsStruct.holidayDetails =holidayDetails>
		<cfset detailsStruct.leaveCount =leaveCount>
		<cfset detailsStruct.workingDaysCount =workingDaysCount>
		<cfset detailsStruct.employeeList =employeeList>
		<cfreturn detailsStruct>
	</cffunction>

	<cffunction name="getholiday">
		<cfquery name="holiday">
			SELECT * FROM company_leaves
			
		</cfquery>
		<cfreturn holiday>
	</cffunction>	
	
	<cffunction name="getTimesheetEmployees">
		<cfquery name="getAllEmployees">
			SELECT * FROM employee e
			WHERE 1=1
			AND status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(arguments, "emp_id") AND arguments.emp_id>
				AND id NOT IN (<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">)
			</cfif>
			AND e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			AND e.IsClient =<cfqueryparam value="0" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn getAllEmployees>
	</cffunction>


<cffunction name="getEmployeesDetails">
	<cfargument name="id" default="">
	<cfquery name="getEmployees">
		SELECT * FROM employee
		WHERE 1=1
		<cfif structKeyExists(arguments, "emp_id") AND arguments.emp_id>
			AND id =<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
		</cfif>
	</cfquery>
	<cfreturn getEmployees>
</cffunction>
<cffunction name="workingDaysHours">
	<cfargument name="startdate" default="">
	<cfargument name="enddate" default="">
	<cfset countofdays = 0>
	<cfquery name="companyLeaves" datasource="entuite_hrms_dsn">
		SELECT company_leaves_JSON FROM company_leaves
	</cfquery>
	<cfset holidayDetails = {}>
	<cfloop query="companyLeaves">
		<cfset datesList = deserializeJSON(companyLeaves.company_leaves_JSON)>

		<cfloop from="1" to="#arrayLen(datesList)#" index="i">
			<cfset dateKey = dateformat(datesList[i]["DATE"], "dd-mm-yyyy")>
			<cfset reason = datesList[i]["REASON"]>

			<cfset holidayDetails[dateKey] = reason>
		</cfloop>
	</cfloop>
	<cfloop from="#parseDateTime(arguments.startdate)#" to="#parseDateTime(arguments.enddate)#" index="D" step="#createTimespan(1, 0, 0, 0)#">
		<cfset weekdays = dayOfWeek("#D#")>
		<cfif weekdays NEQ 1 AND weekdays NEQ 7 AND !structKeyExists(holidayDetails, dateFormat(D, 'dd-mm-yyyy'))>
			<cfset countofdays++>
		</cfif>
	</cfloop>

	<cfreturn countofdays>
</cffunction>
</cfcomponent>

