<cfoutput>

	<cfif NOT structKeyExists(session, "employee")>
	    <cflocation url="../views/logout.cfm">
	</cfif>
	<cfif structKeyExists(url, "leaveid")><cfdump var="tesy">
		<cfinvoke  component="models.logsheet"method="leave_edit_update" id="#url.leaveid#"returnvariable="edit_update"/>
		<cflocation url="../views/employee_leave_history.cfm?id=#URL.id#">
	</cfif>
	<cfif structKeyExists(url, "wfhid")>
		<cfinvoke  component="models.logsheet"method="update_WFH" id="#url.wfhid#"returnvariable="applyy_WFH"/>
		<cflocation url="../views/employee_wfh_history.cfm?id=#URL.id#">
	</cfif>
	<cfif structKeyExists(url, "id") AND structKeyExists(form, "WFH_hidden")>
		<cfinvoke component="models.logsheet" method="apply_WFH" argumentcollection="#form#" ID="#url.id#" returnvariable="number"/>
		
		<cflocation url="../views/wfh_application_form.cfm?id=#url.id#&success=true">
	</cfif>

	<cfif structKeyExists(url, "id")>
		<cfinvoke component="models.logsheet" method="apply_leave" argumentcollection="#form#" id="#url.id#" returnvariable="number"/>
		<cflocation url="../views/leave_application_form.cfm?id=#url.id#&success=true">
	</cfif>
	
<cfif structKeyExists(url, "clockout") AND url.clockout EQ 0>
		<cfinvoke component="../models/logsheet" method="insertClockTime" argumentcollection="#form#" returnvariable="clockTime"/>
		<cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID eq 1>
			<cflocation url="../views/admin_dashboard.cfm">
		<cfelse> 
			<cflocation url="../views/dashboard.cfm">
		</cfif>
	<cfelse>
		<cfinvoke component="../models/logsheet" method="updateClockTime" argumentcollection="#form#" returnvariable="clockTime"/>
		<cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID eq 1>
			<cflocation url="../views/admin_dashboard.cfm">
		<cfelse> 
			<cflocation url="../views/dashboard.cfm">
		</cfif>
	</cfif>
</cfoutput>