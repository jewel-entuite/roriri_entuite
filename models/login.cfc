<cfcomponent>
	<cffunction name="newemp">
		<cfquery name="validOTP">
			SELECT * FROM employee
			WHERE mobile = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_varchar">
			AND OTP = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn validOTP>
	</cffunction>

	<cffunction name="InsAuth">
		<cfargument name="id">
		<cfset dec_id =arguments.id>
		<cfset encrypted=encrypt(arguments.password, "RHMm64ACs6qftCFBz4j+5Q==", "AES","HEX")>
		<cfquery name="newAuth">
			UPDATE employee
			SET user_name = <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
			password = <cfqueryparam value="#encrypted#" cfsqltype="cf_sql_varchar">,
			OTP = <cfqueryparam value="" cfsqltype="cf_sql_integer">
			WHERE id = <cfqueryparam value="#dec_id#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfquery name="get_new_user_details">
			SELECT * FROM employee
			WHERE id = <cfqueryparam value="#dec_id#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn get_new_user_details>
	</cffunction>

	<cffunction name="login">
		<!--- <cfdump var="#arguments#" abort="true"> --->
		<cfset encrypted=encrypt(arguments.password, "RHMm64ACs6qftCFBz4j+5Q==", "AES","HEX")>
		<cfquery name="verify_login">
			SELECT * FROM employee
			WHERE user_name=<cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_varchar"/>
			AND password=<cfqueryparam value="#encrypted#" cfsqltype="cf_sql_varchar"/>
		</cfquery>
		<!--- <cfdump var="#verify_login#" abort="true"> --->
		<cfreturn verify_login>
	</cffunction>

	<cffunction name="getuser">
		<cfargument name="role_id">
		<!--- <cfdump var="#arguments#"> --->
		<cfquery name="user">
			SELECT * FROM employee
			 WHERE status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
          		AND IsClient = <cfqueryparam value="0" cfsqltype="cf_sql_varchar"> 
			<cfif structKeyExists(arguments, "role_id") AND len(arguments.role_id)>
				AND role_id=<cfqueryparam value="4" cfsqltype="cf_sql_integer"/>
			</cfif>
		</cfquery>
		<cfreturn user>
	</cffunction>
</cfcomponent>