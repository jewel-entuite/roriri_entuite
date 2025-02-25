<cfcomponent>
	<cffunction name="getDesignation">
		<cfquery name="designation">
			SELECT * FROM designation
		</cfquery>
		<cfreturn designation>
	</cffunction>

	<cffunction name="getrole">
		<cfquery name="roles">
		SELECT * FROM role
		</cfquery>
		<cfreturn roles>
	</cffunction>	

	<cffunction name="insertEmployeeDetails">
		<cfset oneTimePass= randRange(100000, 999999)>
		<cfquery name="insertEmpDetails"  result="emp_result">
			INSERT INTO employee SET
			first_name = <cfqueryparam value="#form.Fname#" cfsqltype="cf_sql_varchar">,
			last_name = <cfqueryparam value="#form.Lname#" cfsqltype="cf_sql_varchar">,
			mobile = <cfqueryparam value="#form.mbnum#" cfsqltype="cf_sql_varchar">,
			emergency_contact = <cfqueryparam value="#form.emnum#" cfsqltype="cf_sql_varchar">,
			email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
			aadhaar_number = <cfqueryparam value="#form.aadhaarNum#" cfsqltype="cf_sql_varchar">,
			designation = <cfqueryparam value="#form.empDesg#" cfsqltype="cf_sql_integer">,
			role_id = <cfqueryparam value="#form.empRoleid#" cfsqltype="cf_sql_integer">,
			marital_status = <cfqueryparam value="#form.empMrgStatus#" cfsqltype="cf_sql_varchar">,
			current_address = <cfqueryparam value="#form.c_address#" cfsqltype="cf_sql_varchar">,
			permanent_address = <cfqueryparam value="#form.p_address#" cfsqltype="cf_sql_varchar">,
			name_of_father = <cfqueryparam value="#form.fathername#" cfsqltype="cf_sql_varchar">,
			pan_number = <cfqueryparam value="#form.panNum#" cfsqltype="cf_sql_varchar">,
			passport_number = <cfqueryparam value="#form.passNum#" cfsqltype="cf_sql_varchar">,
			nps_acct_number = <cfqueryparam value="#form.npsNum#" cfsqltype="cf_sql_varchar">,
			employee_id = <cfqueryparam value="#form.employee_id#" cfsqltype="cf_sql_varchar">,
			pf_acct_number = <cfqueryparam value="#form.pfNum#" cfsqltype="cf_sql_varchar">,
			OTP = <cfqueryparam value="#oneTimePass#" cfsqltype="cf_sql_varchar">,
			DOB = <cfqueryparam value="#form.DOB#" cfsqltype="cf_sql_date">,
			employee_created_date = <cfqueryparam value="#dateTimeFormat(now())#" cfsqltype="cf_sql_timestamp">,
			employee_joining_date = <cfqueryparam value="#form.joining_date#" cfsqltype="cf_sql_date">
		</cfquery>
		<cfquery name="adminMail">
			SELECT email FROM employee
			WHERE role_id = 1
		</cfquery>
		<cfif structKeyExists(form, "file") and isDefined("form.file") and len(form.file)>
			<cfif NOT directoryExists("#expandPath("../assets/kyc_documents")#/#emp_result.generatedkey#/employee_photo")>
				<cfdirectory action="create" directory="#expandPath("../assets/kyc_documents")#/#emp_result.generatedkey#/employee_photo">
			</cfif>
			<cfset employee_photoUploadDir = "#expandPath("../assets/kyc_documents")#/#emp_result.generatedkey#/employee_photo">
			<cffile action="upload" 
					fileField="file"
					destination="#employee_photoUploadDir#"
					nameconflict="makeunique"
					result="imageFiles">
		</cfif>
		<cfif structKeyExists(form, "documents") and isDefined("form.documents") and len(form.documents)>		
			<cfif NOT directoryExists("#expandPath("../assets/kyc_documents")#/#emp_result.generatedkey#/kyc_files")>
				<cfdirectory action="create" directory="#expandPath("../assets/kyc_documents")#/#emp_result.generatedkey#/kyc_files">
			</cfif>
			<cfset kyc_filesUploadDir = "#expandPath("../assets/kyc_documents")#/#emp_result.generatedkey#/kyc_files">
			<cfloop list="#form.documents#" index="documents">
				<cffile action="upload" 
						fileField="#documents#"
						destination="#kyc_filesUploadDir#"
						nameconflict="makeunique"
						result="documentFiles">
			</cfloop>
		</cfif>
				
		<cfset newstruct = structNew()>
		<cfset newstruct.adminMail =adminMail.email>
		<cfset newstruct.oneTimePass =oneTimePass>
		<cfreturn newstruct>
	</cffunction>

	<cffunction name="emp_profile">
		<cfargument name="user_id" default="">
		<cfquery name="getprofile">
			SELECT E.*,R.*,D.designation AS design FROM employee E
			LEFT JOIN role R ON R.id = E.role_id
			LEFT JOIN designation D ON D.id = E.designation
			WHERE E.id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn getprofile> 
	</cffunction>

	<cffunction name="updateProfile">
		<cfargument name="u_id" default="">
		<cfquery name="uProfile">
			UPDATE employee SET
			emergency_contact = <cfqueryparam value="#form.emnum#" cfsqltype="cf_sql_varchar"/>,
			marital_status = <cfqueryparam value="#form.empMrgStatus#" cfsqltype="cf_sql_varchar"/>,
			current_address = <cfqueryparam value="#form.c_address#" cfsqltype="cf_sql_varchar">,
			permanent_address = <cfqueryparam value="#form.p_address#" cfsqltype="cf_sql_varchar">,
			pan_number = <cfqueryparam value="#form.panNum#" cfsqltype="cf_sql_varchar">,
			passport_number = <cfqueryparam value="#form.passNum#" cfsqltype="cf_sql_varchar">,
			nps_acct_number = <cfqueryparam value="#form.npsNum#" cfsqltype="cf_sql_varchar">,
			pf_acct_number = <cfqueryparam value="#form.pfNum#" cfsqltype="cf_sql_varchar">,
			DOB = <cfqueryparam value="#form.DOB#" cfsqltype="cf_sql_date">,
			employee_joining_date = <cfqueryparam value="#form.joining_date#" cfsqltype="cf_sql_date">,
			employee_relieving_date = <cfqueryparam value="#form.relieving_date#" cfsqltype="cf_sql_date">
			WHERE id = <cfqueryparam value="#arguments.u_id#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfif structKeyExists(form, "file") and isDefined("form.file") and len(form.file)>
			<cfif NOT directoryExists("#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo")>
				<cfdirectory action="create" directory="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo">
			<cfelse>
				<cfdirectory action="list" directory="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo" name="existingImages">
				<cfloop query="existingImages">
					<cffile action="delete" file="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo/#existingImages.name#">
				</cfloop>
			</cfif>
			<cfset employee_photoUploadDir = "#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo">
			<cffile action="upload" 
					fileField="file"
					destination="#employee_photoUploadDir#"
					nameconflict="makeunique"
					result="imageFiles">
		
		</cfif>
		
		<cfif structKeyExists(form, "documents") and isDefined("form.documents") and len(form.documents)>		
			<cfif NOT directoryExists("#expandPath("../assets/kyc_documents")#/#arguments.u_id#/kyc_files")>
				<cfdirectory action="create" directory="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/kyc_files">
			</cfif>
			<cfset kyc_filesUploadDir = "#expandPath("../assets/kyc_documents")#/#arguments.u_id#/kyc_files">
			<cfloop list="#form.documents#" index="documents">
				<cffile action="upload" 
						fileField="#documents#"
						destination="#kyc_filesUploadDir#"
						nameconflict="makeunique"
						result="documentFiles">
			</cfloop>
		</cfif>
		<cfreturn 1>
	</cffunction>

	<cffunction name="updateProfileAdmin">
		<!--- <cfdump var="#form#"><cfabort> --->
		<cfargument name="u_id" default="">
		<cftry>
		<cfquery name="uProfile">
			UPDATE employee SET
			first_name = <cfqueryparam value="#form.Fname#" cfsqltype="cf_sql_varchar">,
			last_name = <cfqueryparam value="#form.Lname#" cfsqltype="cf_sql_varchar">,
			mobile = <cfqueryparam value="#form.mbnum#" cfsqltype="cf_sql_varchar">,
			emergency_contact = <cfqueryparam value="#form.emnum#" cfsqltype="cf_sql_varchar">,
			email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
			name_of_father = <cfqueryparam value="#form.fathername#" cfsqltype="cf_sql_varchar">,
			aadhaar_number = <cfqueryparam value="#form.aadhaarNum#" cfsqltype="cf_sql_varchar">,
			designation = <cfqueryparam value="#form.empDesg#" cfsqltype="cf_sql_integer">,
			role_id = <cfqueryparam value="#form.empRoleid#" cfsqltype="cf_sql_integer">,
			marital_status = <cfqueryparam value="#form.empMrgStatus#" cfsqltype="cf_sql_varchar">,
			current_address = <cfqueryparam value="#form.c_address#" cfsqltype="cf_sql_varchar">,
			permanent_address = <cfqueryparam value="#form.p_address#" cfsqltype="cf_sql_varchar">,
			name_of_father = <cfqueryparam value="#form.fathername#" cfsqltype="cf_sql_varchar">,
			pan_number = <cfqueryparam value="#form.panNum#" cfsqltype="cf_sql_varchar">,
			passport_number = <cfqueryparam value="#form.passNum#" cfsqltype="cf_sql_varchar">,
			nps_acct_number = <cfqueryparam value="#form.npsNum#" cfsqltype="cf_sql_varchar">,
			pf_acct_number = <cfqueryparam value="#form.pfNum#" cfsqltype="cf_sql_varchar">,
			DOB = <cfqueryparam value="#form.DOB#" cfsqltype="cf_sql_date">,
			employee_joining_date = <cfqueryparam value="#form.joining_date#" cfsqltype="cf_sql_date">
			<cfif structKeyExists(form, "form.relieving_date") AND form.relieving_date NEQ "">
				,employee_relieving_date = <cfqueryparam value="#form.relieving_date#" cfsqltype="cf_sql_date">
			</cfif>
			<cfif structKeyExists(form, "employee_status")>
				,status = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
			<cfelse>
				,status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			</cfif>
			WHERE id = <cfqueryparam value="#arguments.u_id#" cfsqltype="cf_sql_integer">		
		</cfquery>
		
		<cfif structKeyExists(form, "file") and isDefined("form.file") and len(form.file)>
		    <cfif NOT directoryExists("#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo")>
		        <cfdirectory action="create" directory="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo">
		    <cfelse>
		        <cfdirectory action="list" directory="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo" name="existingImages">
		        <cfloop query="existingImages">
		            <cffile action="delete" file="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo/#existingImages.name#">
		        </cfloop>
		    </cfif>
		    <cfset employee_photoUploadDir = "#expandPath("../assets/kyc_documents")#/#arguments.u_id#/employee_photo">
			<cffile action="upload" 
				fileField="file"
				destination="#employee_photoUploadDir#"
				nameconflict="makeunique"
				result="imageFiles">
		</cfif>

		<cfif structKeyExists(form, "documents") and isDefined("form.documents") and len(form.documents)>		
			<cfif NOT directoryExists("#expandPath("../assets/kyc_documents")#/#arguments.u_id#/kyc_files")>
				<cfdirectory action="create" directory="#expandPath("../assets/kyc_documents")#/#arguments.u_id#/kyc_files">
			</cfif>
			<cfset kyc_filesUploadDir = "#expandPath("../assets/kyc_documents")#/#arguments.u_id#/kyc_files">
			<cfloop list="#form.documents#" index="documents">
				<cffile action="upload" 
						fileField="#documents#"
						destination="#kyc_filesUploadDir#"
						nameconflict="makeunique"
						result="documentFiles">
			</cfloop>
		</cfif>
		<cfreturn 1>
		<cfcatch> <cfdump var="#cfcatch#" abort></cfcatch>
	</cftry>
	</cffunction>

	<cffunction name="deletefiles" access="remote" returnformat="JSON">
		<cfargument name="filename" required="true">
		<cfargument name="folderid" required="true">
		<cftry>
			<cffile action="delete" file="#expandPath("../assets/kyc_documents")#/#arguments.folderid#/kyc_files/#arguments.filename#">
			<cfcatch>
				<cfreturn "Error deleting file: #cfcatch.message#"> <!-- Return a user-friendly error message -->
			</cfcatch>
		</cftry>
		<cfreturn "Deleted successfully">
	</cffunction>
	

	<cffunction name="getemployee">
		<cfquery name="user" >
			SELECT * FROM employee
			WHERE id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/>
		</cfquery>
		<cfreturn user>
	</cffunction>

	<cffunction name="getAllEmployees">
		<cfquery name="employeeList">
			SELECT E.id,E.first_name,E.last_name,D.designation,R.role,E.mobile,E.email,E.aadhaar_number,E.current_address,E.employee_joining_date FROM employee E
			LEFT JOIN designation D ON D.id = E.designation
			LEFT JOIN role R ON R.id = E.role_id
			WHERE status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			AND e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
		    AND e.IsClient =<cfqueryparam value="0" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn employeeList>
	</cffunction>
	<cffunction name="ResignedEmployees">
		<cfquery name="employeeResignedList" >
			SELECT E.id,E.first_name,E.last_name,D.designation,R.role,E.mobile,E.email,E.aadhaar_number,E.current_address,E.employee_joining_date FROM employee E
			LEFT JOIN designation D ON D.id = E.designation
			LEFT JOIN role R ON R.id = E.role_id
			WHERE status = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn employeeResignedList>
	</cffunction>

	<cffunction name="getAllemployeeForAsset">
		<cfquery name="user" >
			SELECT * FROM employee
			WHERE status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
            AND IsClient = <cfqueryparam value="0" cfsqltype="cf_sql_varchar"> 
		</cfquery>
		<cfreturn user>
	</cffunction>
	<cffunction name="getAllemployeeForTask">
		<cfquery name="user" >
			SELECT * FROM employee
			WHERE role_id IN(<cfqueryparam value="1,4,5" list="true" cfsqltype="cf_sql_integer">)
			AND status =  <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
			ORDER BY first_name ASC
		</cfquery>
		<cfreturn user>
	</cffunction>
	
	<cffunction name="getEmployeeBirthdays" access="public" returntype="query">
	    <cfset var currentDate = now()>
	    <cfset var startDate = createDate(year(currentDate), month(currentDate), day(currentDate))>
	    <cfset var endDate = dateAdd("d", 30, startDate)>
	    <cfquery name="employeeBirthdays">
	        SELECT first_name, last_name, DOB
	        FROM employee
	        WHERE DATE_FORMAT(DOB, '%m-%d') BETWEEN DATE_FORMAT(<cfqueryparam value="#startDate#" cfsqltype="cf_sql_date">, '%m-%d') AND DATE_FORMAT(<cfqueryparam value="#endDate#" cfsqltype="cf_sql_date">, '%m-%d')
	    </cfquery>
	    <cfreturn employeeBirthdays>
	</cffunction>
	<cffunction name="upcomingEmployeeBirthdays" access="public" returntype="query">
	    <cfset var currentDate = now()>
	    <cfset var startDate = createDate(year(currentDate), month(currentDate), day(currentDate))>
	    <cfset var endDate = dateAdd("d", 7, startDate)>
	    <cfquery name="employeeBirthday">
	        SELECT first_name, last_name, DOB
	        FROM employee
	        WHERE DATE_FORMAT(DOB, '%m-%d') BETWEEN DATE_FORMAT(<cfqueryparam value="#startDate#" cfsqltype="cf_sql_date">, '%m-%d') AND DATE_FORMAT(<cfqueryparam value="#endDate#" cfsqltype="cf_sql_date">, '%m-%d')
	    </cfquery>
	    <cfreturn employeeBirthday>
	</cffunction>

	<cffunction name="getEmployeeAnniversaries">
	 	<cfset var currentDate = now()>
	 	<cfset var startDate = createDate(year(currentDate), month(currentDate), day(currentDate))>
		<cfset var endDate = dateAdd("d", 30, currentDate)>
		<cfquery name="employeeAnniversaries">
	     	SELECT first_name, last_name, employee_joining_date
	     	FROM employee
      		WHERE DATE_FORMAT(employee_joining_date, '%m-%d') BETWEEN DATE_FORMAT(<cfqueryparam value="#startDate#" cfsqltype="cf_sql_timestamp">, '%m-%d') AND DATE_FORMAT(<cfqueryparam value="#endDate#" cfsqltype="cf_sql_timestamp">, '%m-%d')
      		AND status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
	 	</cfquery>
	 	<cfreturn employeeAnniversaries>
	</cffunction>
    <cffunction name="getemployee_referral">
    	<cfif structKeyExists(form, "resume_upload") and len(form.resume_upload)>		
			<cfset resumeUpload = "#expandPath("../assets/resume_documents")#/">
			<cffile action="upload" 
				fileField="resume_upload"
				destination="#resumeUpload#"
				nameconflict="makeunique"
				result="documentFiles">
		</cfif>
		<cfif structKeyExists(form, "keySkills") AND isArray(form.keySkills)>
			<cfset keySkillsString = arrayToList(form.keySkills, ",")>
		</cfif>
	   <cfquery name="employeereferral" result="emp_result">
    INSERT into employee_referral (
        full_name,
        email_address,
        phone_number,
        year_of_experience,
        education_level,
        certifications_by,  
        key_skills,
        cover_letter,
        experience_status,
        referred_by,
        referral_date
        <cfif structKeyExists(form, "resume_upload") and len(form.resume_upload)>
            ,resume
        </cfif>
        <cfif structKeyExists(form, "linkedin") AND len(form.linkedin)> 
            ,linkedin_link
        </cfif>
          <cfif structKeyExists(form, "previousEmployer") AND len(form.previousEmployer)> 
            ,Previous_employer
        </cfif>
         <cfif structKeyExists(form, "jobname") AND len(form.jobname)> 
            ,current_job
        </cfif>
         <cfif structKeyExists(form, "Preference") AND len(form.Preference)> 
            ,job_submission
        </cfif>
        <cfif structKeyExists(form, "Relationship") AND len(form.Relationship)> 
            ,relationship_candidate
        </cfif>
         <cfif structKeyExists(form, "Recommending") AND len(form.Recommending)> 
            ,recommending_candidate
        </cfif>
         <cfif structKeyExists(form, "preferred_location") AND len(form.preferred_location)> 
            ,preferred_location
        </cfif>
            ,area_of_skills    
    )
    values(
        <cfqueryparam value="#form.fullname#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.emailid#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_varchar">,
        <cfif structKeyExists(form, "experience")>
            <cfqueryparam value="#form.experience#" cfsqltype="cf_sql_varchar">,
        <cfelseif structKeyExists(form, "status") AND form.status EQ "Fresher">
            <cfqueryparam value="#form.status#" cfsqltype="cf_sql_varchar">,
        </cfif>
        <cfqueryparam value="#form.educationLevel#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.certificate#" cfsqltype="cf_sql_varchar">,  
        <cfqueryparam value="#keySkillsString#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.cover_letter#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.status#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#dateFormat(form.referral_date, "yyyy-mm-dd")#" cfsqltype="cf_sql_date">
        <cfif structKeyExists(form, "resume_upload") and len(form.resume_upload)>
            ,<cfqueryparam value="#documentFiles.serverfile#" cfsqltype="cf_sql_varchar">
        </cfif>
        <cfif structKeyExists(form, "linkedin") AND len(form.linkedin)> 
            ,<cfqueryparam value="#form.linkedin#" cfsqltype="cf_sql_varchar">
        </cfif>
         <cfif structKeyExists(form, "previousEmployer") AND len(form.previousEmployer)> 
            ,<cfqueryparam value="#form.previousEmployer#" cfsqltype="cf_sql_varchar">
         </cfif>
         <cfif structKeyExists(form, "jobname") AND len(form.jobname)> 
            ,<cfqueryparam value="#form.jobname#" cfsqltype="cf_sql_varchar">
         </cfif>
         <cfif structKeyExists(form, "Preference") AND len(form.Preference)> 
           ,<cfqueryparam value="#form.Preference#" cfsqltype="cf_sql_varchar">
        </cfif>
        <cfif structKeyExists(form, "Relationship") AND len(form.Relationship)> 
            ,<cfqueryparam value="#form.Relationship#" cfsqltype="cf_sql_varchar">
        </cfif>
        <cfif structKeyExists(form, "Recommending") AND len(form.Recommending)> 
            ,<cfqueryparam value="#form.Recommending#" cfsqltype="cf_sql_varchar">
        </cfif>
        <cfif structKeyExists(form, "preferred_location") AND len(form.preferred_location)> 
            ,<cfqueryparam value="#form.preferred_location#" cfsqltype="cf_sql_varchar">
        </cfif>
         ,<cfqueryparam value="#form.status == "fresher"?form.interest:form.domain#" cfsqltype="cf_sql_varchar">
        )
        </cfquery>

        <cfreturn 1>

    </cffunction>
    <cffunction name="getall_referral">
    	<cfargument name="referral_emp" required="false" default="">
    	<cfargument name="referral_date" required="false" default="">
    	<cfargument name="experience" required="false" default="">
    	<cfargument name="education_level" required="false" default="">
    	<cfargument name="skills" required="false" default="">
    	<cfargument name="candidate_status" required="false" default="">
     
	    <cfquery name="referralall">
	       SELECT er.*,e.first_name,e.last_name,e.id as employee_id from employee_referral er
	       LEFT JOIN employee e ON e.id = er.referred_by
	       WHERE 1=1
	       <cfif structKeyExists(arguments, "referral_emp") AND arguments.referral_emp NEQ "">
	       	AND referred_by = <cfqueryparam value="#arguments.referral_emp#" cfsqltype="cf_sql_integer">
	       </cfif>
	       <cfif structKeyExists(arguments, "referral_date") AND arguments.referral_date NEQ "">
	       	AND CAST(referral_date AS DATE ) = <cfqueryparam value="#dateFormat(arguments.referral_date,"yyyy-mm-dd")#" cfsqltype="cf_sql_varchar">
	       </cfif>
	       <cfif structKeyExists(arguments, "experience") AND arguments.experience NEQ "">
	       	AND year_of_experience IN(<cfqueryparam value="#arguments.experience#" list="true" cfsqltype="cf_sql_varchar"> )
	       </cfif>
	       <cfif structKeyExists(arguments, "education_level") AND arguments.education_level NEQ "">
	       	AND education_level = <cfqueryparam value="#arguments.education_level#" cfsqltype="cf_sql_varchar">
	       </cfif>   
            <cfif structKeyExists(arguments, "skills") AND arguments.skills NEQ "">
	       	AND FIND_IN_SET(<cfqueryparam value="#arguments.skills#" cfsqltype="cf_sql_varchar">, key_skills) > 0
	       </cfif>
	        <cfif structKeyExists(arguments, "candidate_status") AND arguments.candidate_status NEQ "">
	       	AND referral_status = <cfqueryparam value="#arguments.candidate_status#" cfsqltype="cf_sql_bit">
	       </cfif>
	       	ORDER BY er.id DESC
	 	</cfquery>
		<cfreturn referralall>
    </cffunction>
    <cffunction name="getcandidate">
    	<cfargument name="id" required="true">
        <cfquery name="getcandidate">
	        SELECT 
			    er.*, 
			    e.first_name AS referred_first_name,
			    e.last_name AS referred_last_name,
			    CONCAT(ee.first_name, ' ', ee.last_name) AS deactivated_name
			FROM 
			    employee_referral er
			LEFT JOIN 
			    employee e ON e.id = er.referred_by
			LEFT JOIN 
			    employee ee ON ee.id = er.deactivated_by 
	        WHERE er.id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
	    </cfquery>
        <cfreturn getcandidate>
	</cffunction>
	<cffunction name="getAllcandidates">
		<cfquery name="getcandidatelists">
		   SELECT e.id, e.role_id, e.first_name , e.last_name
            FROM employee e
		    WHERE 1=1
		     AND e.status=<cfqueryparam value="1" cfsqltype="cf_sql_varchar">
		     AND e.IsClient =<cfqueryparam value="0" cfsqltype="cf_sql_varchar">
	   </cfquery>
	   <cfreturn getcandidatelists>
    </cffunction>
     <cffunction name="getallcandidate">
    	<cfargument name="id" required="true">
        <cfquery name="getcandidate">
	        SELECT * FROM employee_referral 
	        where id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
	    </cfquery>
      <cfreturn getcandidate>
	</cffunction>

<cffunction name="getcandidatedetails">
	<cfargument name="id" required="true">
	 <cfquery name="getcandidatedetails">
	        SELECT * FROM employee_referral 
	        where id=<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
	    </cfquery>
	    <cfreturn getcandidatedetails>
</cffunction>

<cffunction name="updatecandidatedetails">
	<cftry>
		<cfif structKeyExists(form, "resume_upload") and len(form.resume_upload)>		
			<cfset resumeUpload = "#ExperienceandPath("../assets/resume_documents")#/">
			<cffile action="upload" 
				fileField="resume_upload"
				destination="#resumeUpload#"
				nameconflict="makeunique"
				result="documentFiles">
		</cfif>
		<cfif structKeyExists(form, "keySkills") AND isArray(form.keySkills)>
			<cfset keySkillsString = arrayToList(form.keySkills, ",")>
		</cfif>
		<cfquery name="updatecandidate">
			 update employee_referral
			 set
			cover_letter = <cfqueryparam value="#form.cover_letter#" cfsqltype="cf_sql_varchar">,
			experience_status = <cfqueryparam value="#form.status#" cfsqltype="cf_sql_varchar">,
			area_of_skills = <cfqueryparam value="#form.status == "fresher"?form.interest:form.domain#" cfsqltype="cf_sql_varchar">,
			full_name = <cfqueryparam value="#form.fullname#" cfsqltype="cf_sql_varchar">,
			email_address = <cfqueryparam value="#form.emailid#" cfsqltype="cf_sql_varchar">,
			phone_number = <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_varchar">,
			<cfif structKeyExists(form, "status") and form.status EQ "Experience">
				year_of_experience = <cfqueryparam value="#form.experience#" cfsqltype="cf_sql_varchar">,
				current_job = <cfqueryparam value="#form.jobname#" cfsqltype="cf_sql_varchar">,
				Previous_employer = <cfqueryparam value="#form.previousEmployer#" cfsqltype="cf_sql_varchar">,
			</cfif>
			education_level = <cfqueryparam value="#form.educationLevel#" cfsqltype="cf_sql_varchar">,
			key_skills = <cfqueryparam value="#keySkillsString#" cfsqltype="cf_sql_varchar">,
			certifications_by = <cfqueryparam value="#form.certificate#" cfsqltype="cf_sql_varchar">,
			<cfif structKeyExists(form, "resume_upload") AND len(form.resume_upload)>
				resume = <cfqueryparam value="#documentFiles.serverfile#" cfsqltype="cf_sql_varchar">,
			</cfif>
			linkedin_link = <cfqueryparam value="#form.linkedin#" cfsqltype="cf_sql_varchar">,
			recommending_candidate = <cfqueryparam value="#form.Recommending#" cfsqltype="cf_sql_varchar">,
			relationship_candidate= <cfqueryparam value="#form.Relationship#" cfsqltype="cf_sql_varchar">,
			preferred_location= <cfqueryparam value="#form.preferred_location#" cfsqltype="cf_sql_varchar">,
			<cfif structKeyExists(form, "reason") AND len(form.reason) AND structKeyExists(form, "statuscheck") AND form.statuscheck EQ 1>
				reason_of_deactivation= <cfqueryparam null="true" cfsqltype="cf_sql_varchar">,
				deactivated_by = <cfqueryparam null="true" cfsqltype="cf_sql_integer">,
	         	deactivated_date = <cfqueryparam null="true" cfsqltype="cf_sql_date">,
			<cfelse>
				reason_of_deactivation= <cfqueryparam value="#form.reason#" cfsqltype="cf_sql_varchar">,
				deactivated_by = <cfqueryparam value="#session.EMPLOYEE.id#" cfsqltype="cf_sql_integer">,
	         	deactivated_date = <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">,
			</cfif>
			<cfif structKeyExists(form, "statuscheck") AND form.statuscheck EQ 1>
				referral_status= <cfqueryparam value="1" cfsqltype="cf_sql_bit">,
			<cfelse>
				referral_status= <cfqueryparam value="0" cfsqltype="cf_sql_bit">,
			</cfif>
			job_submission= <cfqueryparam value="#form.Preference#" cfsqltype="cf_sql_varchar">
			<cfif structKeyExists(form, "status") and form.status EQ "Fresher">
				,year_of_experience= <cfqueryparam value="#form.status#" cfsqltype="cf_sql_varchar">
				,current_job= <cfqueryparam value="" cfsqltype="cf_sql_varchar">
				,Previous_employer= <cfqueryparam value="" cfsqltype="cf_sql_varchar">
			</cfif>
			 WHERE id = <cfqueryparam value="#form.url_id#" cfsqltype="cf_sql_integer">
	         
		</cfquery>
		<cfcatch>
			<cfdump var="#cfcatch#"><cfabort>
		</cfcatch>
	</cftry>
	<cfreturn 1>
</cffunction>

<cffunction name="getemployeereferraldetails">
	<cfargument name="employee_id" required="true">
	<cfquery name="getemployeereferraldetails">
	     SELECT * FROM employee_referral
	     WHERE referred_by = <cfqueryparam value="#arguments.employee_id#">
	</cfquery>

	<cfreturn getemployeereferraldetails>
</cffunction>
	</cfcomponent>
  
