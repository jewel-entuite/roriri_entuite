<cfoutput>
	<cfif structKeyExists(form, "login")>
	<cfinvoke component="../models/login" method="login" argumentcollection="#form#" returnvariable="u"/>
	<cfif queryRecordCount(u)GT 0>
		<cfset session.user.name=u.user_name>
		<cfset session.user.id=u.id>
		<cfset session.user.role=u.role_id>
		<cfif u.role_id EQ "1">
			<cflocation url="../views/admin_dashboard.cfm">
		<cfelse>
			<cflocation url="../views/dashboard.cfm">
		</cfif>
	<cfelse>
		<cflocation url="../views/index.cfm?d">
	</cfif>
	</cfif>

	<cfif structKeyExists(form, "update") AND NOT structKeyExists(url, "id")>
		<!--- <cfdump var="update" abort> --->
		<cfinvoke component="../models/login" method="insert" argumentcollection="#form#" returnvariable="s" id="#session.user.id#"/>
		<cflocation url="../views/dashboard.cfm">
	</cfif>

	<cfif structKeyExists( form,"update") AND structKeyExists(url, "id")>
	<!--- <cfdump var="#update#" abort> --->
	<cfinvoke component="../models/login" method="updateSheet" id="#url.id#" argumentcollection="#form#" returnvariable="d"/>
		<cfif structKeyExists(session, "user")>
			<cfif session.user.role EQ 1>
				<cflocation url="../views/listing.cfm?d">
			<cfelse>
				<cflocation url="../views/listing.cfm?userid=#session.user.id#">
			</cfif>
		</cfif>
	</cfif>


	<cfif structKeyExists(url, "clockout") AND url.clockout EQ 0>
		<cfinvoke component="../models/login" method="insertClockTime" argumentcollection="#form#" returnvariable="clockTime"/>
		<cflocation url="../views/dashboard.cfm">
	<cfelseif structKeyExists(url, "clockout") AND url.clockout EQ 1>
		<cfinvoke component="../models/login" method="updateClockTime" argumentcollection="#form#" returnvariable="clockTime"/>
		<cflocation url="../views/dashboard.cfm">
	</cfif>


	<cfif structKeyExists(form, "asset_hidden")>
		<cfinvoke component="../models/login" method="insert_asset"  argumentcollection="#form#" returnvariable="a"/>
		<cflocation url="../views/asset_registration_form.cfm">
	</cfif>

	
</cfoutput>
