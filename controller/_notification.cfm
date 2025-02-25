<cfoutput>
<cfif structKeyExists(form, "leave_approve")>
	<cfinvoke component="models.leaves" method="update_approve_leave" argumentcollection="#form#"/>
	<cflocation url="../views/Leave_notification.cfm">
<cfelseif structKeyExists(form, "wfh_approve")>
	<cfinvoke component="models.leaves" method="update_approve_wfh" argumentcollection="#form#"/>
	<cflocation url="../views/WFH_notification.cfm">
</cfif>
<cfif structKeyExists(form, "leave_read")>
	<cfinvoke  component="models.leaves" method="update_readstatus_leave" returnvariable="read_leave" argumentcollection="#form#"/>
	<cflocation url="../views/employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
<cfelseif structKeyExists(form, "wfh_read")>
 	<cfinvoke  component="models.leaves" method="update_readstatus_wfh" returnvariable="read_wfh" argumentcollection="#form#"/>
 	<cflocation url="../views/employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
</cfif>	
</cfoutput>
