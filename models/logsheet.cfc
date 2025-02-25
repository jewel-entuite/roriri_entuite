<cfcomponent output="true">

<cffunction name="insertClockTime">

	<cfquery name="insertTime">
		INSERT INTO attendance SET
		employee_id = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
		checked_in_time = <cfqueryparam value="#dateTimeFormat(form.clockTime,"yyyy-mm-dd HH:nn:ss")#" cfsqltype="cf_sql_timestamp">,
		created_date = <cfqueryparam value="#dateFormat(now(), "yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		ip_in=<cfqueryparam value="#form.ip#" cfsqltype="cf_sql_varchar">
	</cfquery>

	<cfreturn 1>

</cffunction>

<cffunction name="updateClockTime">

	<cfquery name="getAttendance">
		SELECT checked_in_time FROM attendance
		WHERE employee_id = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">
		AND created_date = <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		AND checked_out_time is NULL
		ORDER BY id DESC
	</cfquery>

	<cfset startTime = #dateTimeFormat(getAttendance.checked_in_time,"yyyy-mm-dd HH:nn:ss")#>
	<cfset formendTime = #form.clockTime#>
	<cfset endTime = dateTimeFormat(form.clockTime, "yyyy-mm-dd HH:nn:ss")>
	<cfset hoursdiff = dateDiff("h", starttime, endTime)>
	<cfset minutediff = dateDiff("n", starttime, endTime)>
	<cfset minutes = minutediff-(hoursdiff*60)>
	<cfset seconddiff = dateDiff("s", starttime, endTime)>
	<cfset seconds = seconddiff-(minutediff*60)>
	<cfset datetime = createTime(hoursdiff, minutes, seconds)>
		

	<cfquery name="updateTime">
		UPDATE attendance SET
		checked_out_time = <cfqueryparam value="#dateTimeFormat(form.clockTime,"yyyy-mm-dd HH:nn:ss")#" cfsqltype="cf_sql_timestamp">,
		total_hours = <cfqueryparam value="#dateTimeFormat(datetime,"HH:nn:ss")#"	cfsqltype="cf_sql_time">,
		ip_out=<cfqueryparam value="#form.ip#" cfsqltype="cf_sql_varchar">
		WHERE 
		employee_id = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">
		AND 
		checked_out_time IS null 
		AND created_date = <cfqueryparam value="#dateFormat(now(), "yyyy-mm-dd")#" cfsqltype="cf_sql_date">
	</cfquery>

	<cfreturn 1>

</cffunction>

<cffunction name="getLogs" >

	<cfquery name="getAttendance">
		SELECT * FROM attendance
		WHERE employee_id = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">
		AND created_date = <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		ORDER BY id DESC
	</cfquery>
	<cfreturn getAttendance>

</cffunction>

<cffunction name="getDailyWorkhours" >

	<cfquery name="getAttendance">
		SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(total_hours))) as total_hours FROM attendance
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		AND created_date = <cfqueryparam value="#dateFormat(arguments.date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		and checked_out_time is NOT null
		ORDER BY id DESC
	</cfquery>

	<cfreturn getAttendance>

</cffunction>

<cffunction name="getDailyBreakCount" >

	<cfquery name="getAttendance">
		SELECT (COUNT(*) - 1) as breaks FROM attendance
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		AND created_date = <cfqueryparam value="#dateFormat(arguments.date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		and checked_out_time is NOT null
		ORDER BY id DESC
	</cfquery>

	<cfreturn getAttendance>

</cffunction>

<cffunction name="getTotalLogs" >

	<cfquery name="getTotalIndividualAttendance">
		SELECT checked_in_time,ip_in,checked_out_time,ip_out,total_hours,created_date FROM attendance
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		AND created_date = <cfqueryparam value="#dateFormat(arguments.date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		and checked_out_time is NOT null
		ORDER BY id ASC
	</cfquery>

	<cfreturn getTotalIndividualAttendance>

</cffunction>

<cffunction name="getEmployees" >

	<cfquery name="getEmployeesList">
		SELECT * FROM employee
		WHERE NOT role_id = <cfqueryparam value="1" cfsqltype="cf_sql_integer"/> 
	</cfquery>

	<cfreturn getEmployeesList>

</cffunction>

<cffunction name="getAllEmployees" >

	<cfquery name="getAllEmployeesList">
		SELECT * FROM employee
		WHERE status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
        AND IsClient = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
	</cfquery>

	<cfreturn getAllEmployeesList>

</cffunction>

<cffunction name="getEmployeeLogs" >

	<cfquery name="getAllEmployeesList">
		SELECT * FROM employee
		where 1=1
		<cfif structKeyExists(arguments, id) AND len(arguments.id)>
		AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfif>
	</cfquery>

	<cfreturn getAllEmployeesList>

</cffunction>

<cffunction name="getEmployeeAttendanceToday">
	<cfquery name="getAllEmployeesList">
		SELECT DISTINCT E.id FROM employee E
		LEFT JOIN attendance A  ON A.employee_id=E.id
		WHERE A.created_date= <cfqueryparam value="#arguments.thisday#" cfsqltype="cf_sql_date">
		ORDER BY E.id
	</cfquery>
	<cfreturn getAllEmployeesList>
</cffunction>

<cffunction name="getEmployeeCheckIn" >
	<cfargument name="startdate" default="">
	<cfargument name="enddate" default="">
		
	<cfquery name="getEmployeeCheckIn">
		SELECT substring_index(group_concat(A.checked_in_time order by A.checked_in_time ASC), ',', 1) as checkIN,
		substring_index(group_concat(A.ip_in order by A.checked_in_time ASC), ',', 1) as ipIn,
		substring_index(group_concat(A.checked_out_time order by A.checked_out_time desc), ',', 1) as checkOUT,
		substring_index(group_concat(A.ip_out order by A.checked_out_time desc), ',', 1) as ipOut,
		SEC_TO_TIME(SUM(TIME_TO_SEC(A.total_hours))) as total_hours,E.first_name FROM employee E
		LEFT JOIN attendance A ON A.employee_id = E.id
		WHERE 1=1
		AND
		E.id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		AND CAST(A.created_date AS Date) BETWEEN <cfqueryparam value="#dateFormat(arguments.startdate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#dateFormat(arguments.enddate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
	</cfquery>

	<cfreturn getEmployeeCheckIn>

</cffunction>

<cffunction name="workingDays">
	<cfargument name="startdate" default="">
	<cfargument name="enddate" default="">
	<cfargument name="id" default="">
	<!--- <cfdump var="#arguments#"> --->
	<cfset details=structnew()>

	<cfset countofdays = 0>
	<cfset totalHours=0>
	<cfloop from="#parseDateTime(arguments.startdate)#" to="#parseDateTime(arguments.enddate)#" index="D" step="#createTimespan(1, 0, 0, 0)#">
		<cfset weekdays = dayOfWeek("#D#")>
		<cfif weekdays NEQ 1 AND weekdays NEQ 7>
			<cfset countofdays++>
		</cfif>
	</cfloop>
<!--- <cfdump var="#countofdays#"> --->
	<cfquery name="getEmpTotalHours">
		SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(total_hours))) as total_hours FROM attendance
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		AND CAST(created_date AS Date) BETWEEN <cfqueryparam value="#dateFormat(arguments.startdate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#dateFormat(arguments.enddate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		and checked_out_time is NOT null
		ORDER BY id DESC
	</cfquery>
<!--- <cfdump var="#getEmpTotalHours#"> --->
	<cfset details.EmpTotalHours = getEmpTotalHours.total_hours>
	<cfset details.countofdays = countofdays>

	<cfreturn details>
</cffunction>

<cffunction name="workingDaysHours">
	<cfargument name="startdate" default="">
	<cfargument name="enddate" default="">
	<cfargument name="id" default="">
	<cfset countofdays = 0>
	<cfloop from="#parseDateTime(arguments.startdate)#" to="#parseDateTime(arguments.enddate)#" index="D" step="#createTimespan(1, 0, 0, 0)#">
		<cfset weekdays = dayOfWeek("#D#")>
		<cfif weekdays NEQ 1 AND weekdays NEQ 7>
			<cfset countofdays++>
		</cfif>
	</cfloop>

	<cfquery name="getEmpTotalHours">
		SELECT total_hours FROM attendance 
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		AND CAST(created_date AS Date) BETWEEN <cfqueryparam value="#dateFormat(arguments.startdate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#dateFormat(arguments.enddate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		and checked_out_time is NOT null
		ORDER BY id DESC
	</cfquery>
	<cfset details=structnew()>

	<cfset totalHours= 0>
	<cfset totalMinus = 0>
	<cfset totalSec= 0>

	<cfloop query="getEmpTotalHours">
		<cfset totalHours += dateTimeFormat(getEmpTotalHours.total_hours,"HH")>
		<cfset totalMinus += dateTimeFormat(getEmpTotalHours.total_hours,"nn")>
		<cfset totalSec += dateTimeFormat(getEmpTotalHours.total_hours,"ss")>
	</cfloop>

	<cfset totalSec_cal=listGetAt(totalSec/60, 1,".")>
	<cfif totalSec_cal GTE 1 >
		<cfset final_cal_S = totalSec-(60*totalSec_cal)>
		<cfset balance_M = totalSec_cal>
	<cfelse>
		<cfset final_cal_S = totalSec>
		<cfset balance_M =0>
	</cfif>

	<cfset totalMinus = totalMinus + balance_M>

	<cfset totalMinus_cal=listGetAt(totalMinus/60, 1,".")>
	<cfif totalMinus_cal GTE 1 >
		<cfset final_cal_M = totalMinus-(60*totalMinus_cal)>
		<cfset balance_H = totalMinus_cal>
	<cfelse>
		<cfset final_cal_M = totalMinus>
		<cfset balance_H =0>
	</cfif>

	<cfset totalHours = totalHours + balance_H>

	<cfset details.countofdays=countofdays>
	<cfset details.h= totalHours>
	<cfset details.m= final_cal_M>
	<cfset details.s= final_cal_S>


	<cfreturn details>

</cffunction>

<cffunction name="getLeaveDetails">
	<cfargument name="id" default="">
	<cfargument name="date" default="">
	<!--- <cfdump var="#arguments#"> --->
	<cfquery name="leaveDetails">
		SELECT * FROM leave_history
		WHERE employee_id= <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfset details=structnew()>

	<cfif dateFormat(leaveDetails.from_date,"yyyy-mm-dd") LTE dateFormat(arguments.date,"yyyy-mm-dd") AND dateFormat(leaveDetails.to_date,"yyyy-mm-dd") GTE dateFormat(arguments.date,"yyyy-mm-dd")>
		<cfif dateFormat(leaveDetails.from_date,"yyyy-mm-dd") EQ dateFormat(arguments.date,"yyyy-mm-dd") AND dateFormat(leaveDetails.to_date,"yyyy-mm-dd") EQ dateFormat(arguments.date,"yyyy-mm-dd")>
			<cfif leaveDetails.start_period EQ "FN" AND leaveDetails.end_period EQ "FN">
				<cfset details.leaveStatus="halfday">
			<cfelse>
				<cfset details.leaveStatus="leave">
			</cfif>
		<cfelseif dateFormat(leaveDetails.from_date,"yyyy-mm-dd") EQ dateFormat(arguments.date,"yyyy-mm-dd") AND dateFormat(leaveDetails.to_date,"yyyy-mm-dd") NEQ dateFormat(arguments.date,"yyyy-mm-dd")>
			<cfif leaveDetails.start_period EQ "FN">
				<cfset details.leaveStatus="leave">
			<cfelse>
				<cfset details.leaveStatus="halfday">
			</cfif>
		<cfelseif dateFormat(leaveDetails.from_date,"yyyy-mm-dd") NEQ dateFormat(arguments.date,"yyyy-mm-dd") AND dateFormat(leaveDetails.to_date,"yyyy-mm-dd") EQ dateFormat(arguments.date,"yyyy-mm-dd")>
			<cfif leaveDetails.end_period EQ "FN">
				<cfset details.leaveStatus="halfday">
			<cfelse>
				<cfset details.leaveStatus="leave">
			</cfif>
		<cfelseif dateFormat(leaveDetails.from_date,"yyyy-mm-dd") NEQ dateFormat(arguments.date,"yyyy-mm-dd") AND dateFormat(leaveDetails.to_date,"yyyy-mm-dd") NEQ dateFormat(arguments.date,"yyyy-mm-dd")>
			<cfset details.leaveStatus="leave">
		</cfif>
	<cfelse>
		<cfset details.leaveStatus="none">
	</cfif>

	<cfreturn details>
	
</cffunction>

<cffunction name="apply_leave">
<!--- <cfdump var="#arguments#" abort> --->
	<cfargument name="id" default="">
	<cfset from_date = dateFormat(form.fromdate)>
	<cfset to_date = dateFormat(form.todate)>
	<cfset from_timespan = form.start_period>
	<cfset to_timespan = form.end_period>
	<cfif from_timespan EQ to_timespan>
		<cfset halfday = 0.5>
	<cfelse>
		<cfset halfday = 1>
	</cfif>
	<cfset days = dateDiff("d", from_date, to_date)>
	<cfset total = days + halfday>
	<cfquery name="inLeave" result="leave">
		INSERT INTO leave_history SET
		from_date = <cfqueryparam value="#dateFormat(form.fromdate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		to_date = <cfqueryparam value="#dateFormat(form.todate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		start_period = <cfqueryparam value="#form.start_period#" cfsqltype="cf_sql_varchar">,
		end_period = <cfqueryparam value="#form.end_period#" cfsqltype="cf_sql_varchar">,
		reason = <cfqueryparam value="#form.reason#" cfsqltype="cf_sql_varchar">,
		employee_id = <cfqueryparam value="#decrypt(arguments.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" cfsqltype="cf_sql_integer">,
		total_days = <cfqueryparam value="#total#" cfsqltype="cf_sql_float">,
		created_date = <cfqueryparam value="#dateFormat(now())#" cfsqltype="cf_sql_date">,
		approved_status = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
	</cfquery>
	<!--- <cfquery name="insertNotification">
	INSERT INTO notification SET
	content = <cfqueryparam value="leave" cfsqltype="cf_sql_varchar">,
	content_id = <cfqueryparam value="#leave.generatedkey#" cfsqltype="cf_sql_integer">
	</cfquery> --->
	<cfreturn 1>

</cffunction>

<cffunction name="getLeaveHistory">
	<cfargument name="id" default="">
	<cfquery name="leave_list">
		SELECT * FROM leave_history
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		ORDER BY leave_history.id DESC
	</cfquery>
	<cfreturn leave_list>
</cffunction>

<cffunction name="getLeaveCount">
	<cfargument name="startdate" default="">
	<cfargument name="enddate" default="">
	<cfargument name="id" default="">

	<!--- Query the leave history for the given employee and date range --->
	<cfquery name="leaveHistory">
        SELECT * 
        FROM leave_history
        WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        AND from_date <= <cfqueryparam value="#arguments.enddate#" cfsqltype="cf_sql_date">
        AND to_date >= <cfqueryparam value="#arguments.startdate#" cfsqltype="cf_sql_date">
    </cfquery>

    <cfset count = 0>

    <!--- Loop through the leave records ---> 
    <cfloop query="leaveHistory">
        <!--- Check if the leave is a single day or spans multiple days --->
        <cfif dateFormat(from_date, "yyyy-mm-dd") EQ dateFormat(to_date, "yyyy-mm-dd")>
            <!--- Single day leave --->
            <cfset leave_type = "full"> <!--- Default to full-day leave --->
            <!--- Determine if the leave is a half-day or full-day based on periods --->
            <cfif start_period eq "FN" AND end_period eq "AN">
                <cfset leave_type = "full">
            <cfelseif (start_period eq "AN" AND end_period eq "AN") OR (start_period eq "FN" AND end_period eq "FN")>
                <cfset leave_type = "half">
            </cfif>
            
            <cfif leave_type eq "full">
                <cfset count = count + 1>
            <cfelseif leave_type eq "half">
                <cfset count = count + 0.5>
            </cfif>

        <cfelse>
            <cfset numDays = dateDiff("d", from_date, to_date) + 1> 
            <cfset count = count + numDays> 

        </cfif>
    </cfloop>

    <cfreturn count>
</cffunction>


<cffunction name="admin_leave_history">
	<cfargument name="id">
	<cfargument name="sd" default="">
	<cfargument name="ed" default="">
	<cfquery name="emp_leave">
		SELECT * FROM leave_history L
		LEFT JOIN employee E ON L.employee_id = E.id 
		where 1=1
		<cfif structKeyExists(arguments, "id") AND arguments.id NEQ "">
			AND	L.employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif arguments.sd NEQ "" AND arguments.ed NEQ "">
			AND (CAST(from_date AS DATE) BETWEEN <cfqueryparam value="#arguments.sd#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#arguments.ed#" cfsqltype="cf_sql_date"> OR CAST(to_date AS DATE) BETWEEN <cfqueryparam value="#arguments.sd#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#arguments.ed#" cfsqltype="cf_sql_date">)
		</cfif>
		ORDER BY L.id DESC
	</cfquery>
	<cfreturn emp_leave>
</cffunction>

<cffunction name="getleaves">
	<cfargument name="id" default="">
	<cfquery name="getleave">
		SELECT * FROM leave_history
		WHERE 1=1 
		AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfreturn getleave>
</cffunction>
<cffunction name="leave_edit_update">
<!--- <cfdump var="#arguments#" abort> --->
	<cfargument name="id" default="">
	<cfset from_date = dateFormat(form.fromdate)>
	<cfset to_date = dateFormat(form.todate)>
	<cfset from_timespan = form.start_period>
	<cfset to_timespan = form.end_period>
	<cfif from_timespan EQ to_timespan>
		<cfset halfday = 0.5>
	<cfelse>
		<cfset halfday = 1>
	</cfif>
	<cfset days = dateDiff("d", from_date, to_date)>
	<cfset total = days + halfday>

	<cfquery name="leave_edit_update">
		 UPDATE leave_history SET
		from_date = <cfqueryparam value="#dateFormat(form.fromdate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		to_date = <cfqueryparam value="#dateFormat(form.todate,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		start_period = <cfqueryparam value="#form.start_period#" cfsqltype="cf_sql_varchar">,
		end_period = <cfqueryparam value="#form.end_period#" cfsqltype="cf_sql_varchar">,
		reason = <cfqueryparam value="#form.reason#" cfsqltype="cf_sql_varchar">,
		total_days = <cfqueryparam value="#total#" cfsqltype="cf_sql_float">
		WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
	</cfquery>
	
	<cfreturn 1>
</cffunction>

<cffunction name="getClockStatus" returntype="any" access="remote" returnformat="JSON">
	<cfargument name="emp_id" default="">
	<cfquery name="status">
		SELECT * FROM attendance
		WHERE employee_id = <cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
		AND created_date = <cfqueryparam value="#dateFormat(now(),"yyyy-mm-dd")#" cfsqltype="cf_sql_date">
		ORDER BY id DESC
	</cfquery>
	<cfset details=structnew()>
	<cfif queryRecordCount(status) GT 0>
        <cfif status.checked_in_time NEQ "" AND status.checked_out_time EQ "">
        	<cfset details.status="Active">
        <cfelse>
        	<cfset details.status="Inactive">
        </cfif>
    <cfelse>
    	<cfset details.status="Offline">
    </cfif>
    <cfset details.emp_id=arguments.emp_id>
	<cfreturn serializeJSON(details)>
</cffunction>

<cffunction name="apply_WFH">
	<cfargument name="ID" default="">

	<cfset WFHfrom_date = dateFormat(form.WFHfromdate)>
	<cfset WFHto_date = dateFormat(form.WFHtodate)>
	<cfset WFHfrom_timespan = form.WFHstart_period>
	<cfset WFHto_timespan = form.WFHend_period>

	<cfif WFHfrom_timespan EQ WFHto_timespan>
		<cfset halfday = 0.5>
		<cfdump var="#halfday#">
	<cfelse>
		<cfset halfday = 1>
		<cfdump var="#halfday#">
	</cfif>

	<cfset days = dateDiff("d", WFHfrom_date, WFHto_date)>
	<cfset totald = days + halfday>
	<cfdump var="#totald#">
<cfdump var="#arguments#">
	<cfquery name="apply_WFH" result="WFH">

		INSERT INTO wfh_history SET
		start_date = <cfqueryparam value="#dateFormat(WFHfrom_date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		start_period = <cfqueryparam value="#form.WFHstart_period#" cfsqltype="cf_sql_varchar">,
		end_date = <cfqueryparam value="#dateFormat(WFHto_date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		end_period = <cfqueryparam value="#form.WFHend_period#" cfsqltype="cf_sql_varchar">,
		reason = <cfqueryparam value="#form.WFHreason#" cfsqltype="cf_sql_varchar">,
		created_date = <cfqueryparam value="#dateFormat(now())#" cfsqltype="cf_sql_date">,
		total_days = <cfqueryparam value="#totald#" cfsqltype="cf_sql_float">,
		employee_id = <cfqueryparam value="#decrypt(arguments.ID, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" cfsqltype="cf_sql_integer">,
		approved_status = <cfqueryparam value="1" cfsqltype="cf_sql_integer">

	</cfquery>
	<!--- <cfquery name="insertNotification">
		INSERT INTO notification SET
		content = <cfqueryparam value="WFH" cfsqltype="cf_sql_varchar">,
		content_id = <cfqueryparam value="#WFH.generatedkey#" cfsqltype="cf_sql_integer"> 
	</cfquery> --->

	<cfreturn 1>
</cffunction>

<cffunction name="getwfhHistory">
	<cfargument name="id" default="">
	<cfquery name="wfh_list">
		SELECT * FROM wfh_history
		WHERE 1=1
		 AND id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfreturn wfh_list>
</cffunction>

<cffunction name="update_WFH">
	<cfargument name="id" default="">

	<cfset WFHfrom_date = dateFormat(form.WFHfromdate)>
	<cfset WFHto_date = dateFormat(form.WFHtodate)>
	<cfset WFHfrom_timespan = form.WFHstart_period>
	<cfset WFHto_timespan= form.WFHend_period>

	<cfif WFHfrom_timespan EQ WFHto_timespan>
		<cfset halfday = 0.5>
		
	<cfelse>
		<cfset halfday = 1>
		
	</cfif>

	<cfset days = dateDiff("d", WFHfrom_date, WFHto_date)>
	<cfset totald = days + halfday>
	
	<cfquery name="applyy_WFH">

		UPDATE wfh_history SET
		start_date = <cfqueryparam value="#dateFormat(WFHfrom_date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		start_period = <cfqueryparam value="#form.WFHstart_period#" cfsqltype="cf_sql_varchar">,
		end_date = <cfqueryparam value="#dateFormat(WFHto_date,"yyyy-mm-dd")#" cfsqltype="cf_sql_date">,
		end_period = <cfqueryparam value="#form.WFHend_period#" cfsqltype="cf_sql_varchar">,
		reason = <cfqueryparam value="#form.WFHreason#" cfsqltype="cf_sql_varchar">,
		
		total_days = <cfqueryparam value="#totald#" cfsqltype="cf_sql_float">
		
		WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cfreturn 1>
</cffunction>

<cffunction name="get_wfh_history">
	<cfargument name="id" default="">
	<cfquery name="Get_WFH_History">
	 SELECT * FROM wfh_history
	 WHERE employee_id = <cfqueryparam value="#decrypt(arguments.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" cfsqltype="cf_sql_integer">
	 ORDER BY wfh_history.id DESC
	</cfquery>
	<cfreturn Get_WFH_History>
</cffunction>

<cffunction name="admin_wfh_history">
	<cfargument name="sd" default="">
	<cfargument name="ed" default="">
	<cfargument name="id" default="">
	<cfquery name="emp_wfh">
		SELECT * FROM wfh_history W
		LEFT JOIN employee E ON W.employee_id = E.id 
		<cfif structKeyExists(arguments, "id") AND arguments.id NEQ "">
			AND E.id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfif>
		<cfif arguments.sd NEQ "" AND arguments.ed NEQ "">
			AND (CAST(from_date AS DATE) BETWEEN <cfqueryparam value="#arguments.sd#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#arguments.ed#" cfsqltype="cf_sql_date"> OR CAST(to_date AS DATE) BETWEEN <cfqueryparam value="#arguments.sd#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#arguments.ed#" cfsqltype="cf_sql_date">)
		</cfif>
		 ORDER BY W.id DESC
	</cfquery>
	<cfreturn emp_wfh>
</cffunction>
<cffunction name="WFH_status">
	<cfargument name="id">
	<cfquery name="WFH_status">
		SELECT * FROM wfh_history
		WHERE employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfset now = now()>
	<cfset wfh = 0>
	<cfloop query="WFH_status">
		<cfloop from="#parseDateTime(WFH_status.start_date)#" to="#parseDateTime(WFH_status.end_date)#" index="w" step="#createTimespan(1, 0, 0, 0)#">
			<cfif dateFormat(now) EQ  dateFormat(w)>
				<cfset wfh = 1>
			</cfif>
		</cfloop>
	</cfloop>
	<cfreturn wfh>
</cffunction>
<!--- <cffunction name="clock_timer">
	<cfquery name="timer">
	 	SELECT * FROM attendance A
 		WHERE A.employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfset today = dateFormat(now(),"yyyy-mm-dd")>
	<cfset date = 0>
    <cfloop query="timer">
    	<cfif today EQ  timer.created_date>
				<cfset date = 1>
		</cfif>
    </cfloop>
    <cfreturn date>
</cffunction> --->

</cfcomponent>