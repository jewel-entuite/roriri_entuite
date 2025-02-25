<cfoutput>
	<cftry>
		<cfif structKeyExists(url, "token") AND url.token EQ "login">
		<cfinvoke component="../models/login" method="newemp" argumentcollection="#form#" returnvariable="validOTP"/>
				<cfif queryRecordCount(validOTP) GT 0>
					<cfif validOTP.user_name EQ "" AND validOTP.password EQ "">
						<cfset en_id = validOTP.id>
						<cflocation url="../views/renew_authentication.cfm?token=#en_id#">
					<cfelse>
						<cflocation url="../index.cfm?d">
					</cfif>
				<cfelse>
					<cfinvoke component="models.login" method="login" argumentcollection="#form#" returnvariable="user"/>
					<cfif queryRecordCount(user)GT 0>
						<cfset session.employee.user_name=user.first_name>
						<cfset session.employee.id=user.id>
						<cfset session.employee.role_id=user.role_id>
						<!--- <cfset session.curdate = dateAdd('h','11',parseDateTime(now(),"yyyy-mm-dd hh:nn:ss"))>
						<cfset session.curdatetime=dateAdd('n','-30',session.curdate)> --->
						<cfif user.role_id EQ "1">
							<cflocation url="..\views\admin_dashboard.cfm">
						<cfelse>
							<cflocation url="..\views\dashboard.cfm">
						</cfif>
					<cfelse>
						<cflocation url="..\index.cfm?d">
					</cfif>
				</cfif>
		</cfif>
		<cfif structKeyExists(form, "create_password") AND form.create_password EQ 50 >
			<cfinvoke component="../models/login" id="#form.en_id#" method="InsAuth" argumentcollection="#form#" returnvariable="newpass"/>
			<cfif queryRecordCount(newpass)GT 0>
				<cfset session.employee.user_name=newpass.user_name>
				<cfset session.employee.id=newpass.id>
				<cfset session.employee.role_id=newpass.role_id>
				<cfif newpass.role_id EQ "1">
					<cflocation url="../views/admin_dashboard.cfm">
				<cfelse>
					<cflocation url="../views/dashboard.cfm">
				</cfif>
			<cfelse>
				<cflocation url="../index.cfm?d">
			</cfif>
		</cfif>
		<cfcatch>
			<cfdump var="#cfcatch#">
		</cfcatch>
	</cftry>
</cfoutput>
