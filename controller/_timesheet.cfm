<cfoutput>
	<cfif NOT structKeyExists(session, "employee")>
	    <cflocation url="../views/logout.cfm" addtoken="false">
	</cfif>
<cfif structKeyExists(form, "update") AND NOT structKeyExists(url, "id")>
		<!--- <cfdump var="update" abort> --->
		<cfinvoke component="models.timesheet" method="insert" argumentcollection="#form#" returnvariable="s" id="#session.employee.id#"/>
		<!--- <cfdump var="#session#" abort> --->
		<cfif session.employee.role_id EQ 1>
			<cflocation url="../views/admin_dashboard.cfm" addtoken="false">
		<cfelse>
			<cflocation url="../views/dashboard.cfm" addtoken="false">
		</cfif>
		
	</cfif>

	<cfif structKeyExists( form,"update") AND structKeyExists(url, "id")>
		<cfset urlData = deserializeJSON(form.url_data)>
		<cfset extraParams = "">
		<cfloop collection="#urlData#" item="data">
			<cfif extraParams EQ "">
				<cfset extraParams &= "?#data#=#urlData[data]#" />
			<cfelse>
				<cfset extraParams &= "&#data#=#urlData[data]#" />
			</cfif>
		</cfloop>
	<cfinvoke component="models.timesheet" method="updateSheet" id="#url.id#" argumentcollection="#form#" returnvariable="d"/>
		<cfif structKeyExists(session, "employee")>
			<cfif session.employee.role_id EQ 1>
				<cflocation url="../views/admin_timesheet_listing.cfm#extraParams#" addtoken="false">
			<cfelse>
				<cflocation url="../views/listing.cfm#extraParams#" addtoken="false">
			</cfif>
		<cfelse>
			<cflocation url="../views/logout.cfm" addtoken="false">
		</cfif>
	</cfif>
	<cfif structKeyExists(form, "task")>
		<cfinvoke component="models.timesheet" method="insertAssignedTask" argumentcollection="#form#"/>
		<cflocation url="../views/add_task.cfm?success" addtoken="false">
	</cfif>
	<cfif structKeyExists(form, "assignEmp")>
		<cfinvoke component="models.timesheet" method="assignTaskToMultipleEmployees" argumentcollection="#form#"/>
		<cflocation url="../views/assigned_task_details.cfm" addtoken="false">
	</cfif>
	<cfif structKeyExists(form, "update_task")>
	    <cfif structKeyExists(form, "status") AND form.status EQ "3">
	        <cfinvoke component="models.tasks" method="reopenedcount" argumentcollection="#form#" />
	    <cfelse>
	        <cfinvoke component="models.timesheet" method="updateTask" argumentcollection="#form#"/>
	    </cfif>
	    <cflocation url="../views/assigned_task_details.cfm" addtoken="false">
	</cfif>
	
</cfoutput>