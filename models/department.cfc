<cfcomponent>
	<cffunction name="getDepartments">
		<cfquery name="qgetDepartments">
			SELECT id,name FROM department
		</cfquery>
		<cfreturn qgetDepartments>
	</cffunction>
</cfcomponent>