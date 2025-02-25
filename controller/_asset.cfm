<cfoutput>
	<cfif NOT structKeyExists(session, "employee")>
	    <cflocation url="../views/logout.cfm">
	</cfif>

	<cfif structKeyExists(url, "id")>
		<cfinvoke  component="models.asset" method="update_asset" id="#url.id#"  returnvariable="update"/>
		<cfdump var="#update#">
		<cflocation url="../views/asset_list.cfm">
	</cfif>

	<cfif structKeyExists(form, "abc")>
		<cfinvoke component="models.asset" method="assign_asset" argumentcollection="#form#" returnvariable="in_asset"/>
		<cfif in_asset EQ 0>
			<cflocation url="../views/admin_dashboard.cfm?##">
		<cfelse>
			<!--- <cfdump var="#URL#"> --->
			<cflocation url="../views/asset_assign.cfm?asset_type=#URL.asset_type#&e=#URL.e#">
		</cfif>
	</cfif>	

	<cfif structKeyExists(form, "asset_hidden")>
		<cfinvoke component="models.asset" method="insert_asset"  argumentcollection="#form#" returnvariable="a"/>
		<cflocation url="../views/asset_registration_form.cfm">
	</cfif>
</cfoutput>