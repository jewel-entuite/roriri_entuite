<cfoutput>
	<cfif structKeyExists(url,"dlt")>
	<cfinvoke component="models.leaves" method="deleteleaves" argumentcollection="#form#"/>
	<cflocation url="../views/company_leave_days.cfm?d">
<cfelseif structKeyExists(form, "edit")>
	<cfinvoke component="models.leaves" method="editleaves" argumentcollection="#form#"/>
	<cflocation url="../views/company_leave_days.cfm?b">
<cfelse>
	<cfinvoke component="models.leaves" method="company_leaves" argumentcollection="#form#"/>
	<cflocation url="../views/company_leave_days.cfm?s">
</cfif>
</cfoutput>