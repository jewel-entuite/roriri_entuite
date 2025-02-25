<cfoutput>
	<cfif structKeyExists(form, "taskStatus")>
		<cfinvoke component="models.tasks" method="updateTaskStatus" argumentcollection="#form#"/>
		<cflocation url="../views/task_listing.cfm?s" addtoken="false">
	</cfif>
	<cfif structKeyExists(form, "action") AND form.action EQ "delete">
        <cfinvoke component="models.tasks" method="maketaskinactive" returnvariable="updateactivestatus">
        <cflocation url="../views/assigned_task_details.cfm" addToken="false">
	</cfif>
	<cfif structKeyExists(form, "action") AND form.action EQ "revoke">
        <cfinvoke component="models.tasks" method="makeTaskActive" returnvariable="revoketask">
        <cflocation url="../views/assigned_task_details.cfm" addToken="false">
	</cfif>
</cfoutput>