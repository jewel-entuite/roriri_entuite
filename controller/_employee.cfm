<cfoutput>
	<cfif NOT structKeyExists(session, "employee")>
	    <cflocation url="../views/logout.cfm">
	</cfif>
	<cfif structKeyExists(url, "regSucess") AND url.regSucess EQ "1">
		<cfinvoke component="models.employee" method="insertEmployeeDetails" argumentcollection="#form#" returnvariable="newstruct"/>
		<cfif newstruct.adminMail NEQ "" AND newstruct.oneTimePass NEQ "">
			<!--- <cfmail to = "#form.email#" from = "#newstruct.adminMail#" subject = "Username = #form.mbnum# Password = #newstruct.oneTimePass#"> 
			</cfmail> --->
			<cflocation url="../views/admin_dashboard.cfm?s">
		<cfelse>
			<cflocation url="../views/admin_dashboard.cfm">
		</cfif>
	</cfif>

	<cfif structKeyExists(form, "u_profile")>
		<cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID EQ "1">
			<cfinvoke component="models.employee" method="updateProfileAdmin" u_id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" argumentcollection="#form#">
			<cflocation url="../views/all_employee_details.cfm?update">
		<cfelse>
			<cfinvoke component="models.employee" method="updateProfile" u_id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" argumentcollection="#form#"/>
			<cflocation url="../views/employee_profile_list.cfm?id=#url.id#">
		</cfif>
		<!--- <cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID EQ "1">
		<cfelse>
		</cfif> --->
	</cfif>

	<cfif structKeyExists(url, "referralform") AND url.referralform EQ "1">
	 	<!--- <cfdump var="#form#"><cfabort> --->
	 	<cfif structKeyExists(form, "url_id") AND form.url_id NEQ ''>
	 		<cfinvoke method="updatecandidatedetails" component="models.employee" argumentcollection="#form#" returnvariable="updateresponse"/>
	 	<cfelse>
	 		<cfinvoke method="getemployee_referral" component="models.employee" argumentcollection="#form#" returnvariable="employee_response"/>
	    <!--- <cfdump var="#employee_response#"> --->
	 	</cfif>
	 	<cflocation url="../views/employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=" addtoken="false">
	</cfif>
	<cfif structKeyExists(url, "candidatelist") AND url.candidatelist EQ "1">
	 	<cfinvoke method="candidatesactivestatusupdate" component="models.employee" argumentcollection="#form#" returnvariable="res"/>
	 	<cflocation url="../views/employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=" addtoken="false">
	</cfif>

	<cfif structKeyExists(url, "candidatelist") AND url.candidatelist EQ "2">
	 	<cfinvoke method="candidatesdeactivestatusupdate" component="models.employee" argumentcollection="#form#" returnvariable="res"/>
	 	<cflocation url="../views/employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=" addtoken="false">
	</cfif>

</cfoutput>

