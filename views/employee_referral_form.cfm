<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>
    <link
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <title>RORIRI -Employee Management</title>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">

    <title>CVform</title>
    <style>
      .form-group {
        margin-bottom: 15px;
        display: flex;
      }
      label {
        display: block;
        margin-bottom: 5px;
      }
      .checkbox-group {
        margin-bottom: 10px;
      }
      .checkbox-group label {
        display: inline-block;
        margin-right: 10px;
      }
      #areaOfInterest,
      #areaOfDomain {
        display: none;
      }
      .statuscheck input:checked  {
        background-color: #428c01;
      }
       a.custom-btn {
        background: #fff;
        color: #7d66e3;
        border: 1px solid #7d66e3;
        border-radius: 5px;
        text-decoration: none;
        width:150px;
        padding: 4px;
        display: flex;
        justify-content:center;
      }
       a.custom-btn:hover {
        background: #7d66e3;
        color: #fff;
      }
       .custom-dropdown-btn {
        background-color: transparent; /* No background color */
        border: 1px solid #ced4da; /* Neutral border similar to input */
        border-radius: 0.375rem; /* Smooth corners */
        padding: 0.375rem 0.75rem; /* Padding for alignment */
        box-shadow: none; /* No default shadow */
        color: #495057; /* Text color */
    }

    /* Focus Styling (like input focus) */
    .custom-dropdown-btn:focus,
    .custom-dropdown-btn[aria-expanded="true"] {
        outline: none; /* Remove default outline */
        border-color: #80bdff; /* Highlighted blue border */
        box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25); /* Light blue glow */
    }

    /* Dropdown Menu Items */
    .dropdown-menu li {
        padding: 0.3rem;
    }

    /* Optional: Light hover effect for dropdown items */
    .dropdown-menu li:hover {
        background-color: #f8f9fa;
    }
     /* Style for inline row-wise display */
    #selectedKeySkills {
        display: inline-block; /* Ensures inline text layout */
        white-space: normal;   /* Allows wrapping when necessary */
    }

    .custom-dropdown-btn {
        text-align: left; /* Aligns text inside the button */
        white-space: normal; /* Allows multi-line wrapping */
        overflow-wrap: break-word; /* Breaks words if too long */
    }
    #keySkillsDropdown button:focus {
          outline: none; 
          box-shadow: none; 
    }
    /*#keySkillsDropdown.invalid button {
        border: 1px solid red;
    }
    #keySkillsDropdown.valid button {
        border: 1px solid green;
    }*/

    </style>
  </head>
  <body>
     <cfif structKeyExists(URL,"id") AND len(url.id)>
<cfinvoke method="getcandidatedetails" component="models.employee" returnvariable="res" id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
</cfif>
    <cfset active_status="employee_management">
  <cfif not structKeyExists(session, "EMPLOYEE")>
      <cflocation url="logout.cfm">
    <cfelseif session.employee.ROLE_ID EQ 1>
      <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
    <cfelse>
      <cfset active_status="profile">
      <cfinclude template="../includes/header/user_header.cfm" runonce="true">
    </cfif>    
    <div class="my-3 py-2">&nbsp;</div>
    <div class="m-3">
      <form action="../controller/_employee.cfm?referralform=1" method="post" class="needs-validation" novalidate id="uploadForm"
        enctype="multipart/form-data" onsubmit="return validateForm(event);">
      <cfoutput>  
        <input type="hidden" name="user_name" value="#session.employee.USER_NAME#">
          <input type="hidden" name="referral_date"  value="#dateFormat(now(), 'yyyy-mm-dd')#">
        <cfif structKeyExists(url, "id")>
          <input type="hidden" name="url_id" value="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
        </cfif>
         <div class="section-title pt-5 mt-5">
             <h2 class="pt-5">Employee Referral</h2>
             <p>Referral Form</p>
         </div>
         <div class="row ms-5 ps-5 mb-3">
              <div class="col-10"></div>
                <div class="col-2 d-flex justify-content-end">
                  <a class="custom-btn btn-sm" href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=" role="button">Referral List</a>
                </div>
          </div>
           <div class="shadow card px-4 py-4 pt-3">
              <div class="ms-1 mt-1 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                  <label>REFERRAL FORM</label>
              </div>
              <hr>
              <div class="card p-4 my-2 shadow bg-white rounded">
                <div>
                  <h4 style="color: ##7d66e3; font-family: 'Raleway', sans-serif">
                    Candidate Profile
                  </h4>
                </div>
              <div>
           <label for="coverletter">Cover Letter</label>
        <textarea class="form-control" id="coverletter" name="cover_letter" rows="2" cols="2" placeholder="Write cover letter here..." required><cfif structKeyExists(url, "id") AND len(url.id)>#res.cover_letter# </cfif> </textarea>
            <div class="invalid-feedback" style="font-size: 17px"> Cover Letter is required </div>
          </div>
          <!-- <br> -->
          <div class="my-3">
            <div class="form-group">
              <div>
                <label class="">Select Status</label>
                <input type="radio" id="fresher" name="status" class="form-check-input mx-1" value="Fresher" onclick="showOptions()" required <cfif structKeyExists(url, "id") AND len(url.id) AND res.year_of_experience EQ "Fresher"> checked</cfif> />
                <label for="fresher" class="mx-4">Fresher</label>
                <input type="radio" id="Experience" name="status" class="form-check-input mx-1" value="Experience" onclick="showOptions()" required <cfif structKeyExists(url, "id") AND len(url.id) AND res.year_of_experience NEQ "Fresher"> checked</cfif> />
                <label for="Experience" class="mx-4">Experience</label>
                <div class="invalid-feedback" style="font-size: 17px"> Select Status is required </div>
              </div>
            </div>
            <div id="areaOfInterest" class="form-group">
              <label>Area of Interest:</label>
                <div class="checkbox-group" style="margin-left: 30px">
                  <input class="form-check-input" type="checkbox" id="webdev" name="interest" value="Web Development" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Web Development")> checked</cfif>  />
                  <label class="form-check-label" for="webdev"> Web Development (Frontend/Backend)</label> <br/>
                  <input class="form-check-input" type="checkbox" id="mobiledev" name="interest" value="Mobile App Development" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Mobile App Development")> checked</cfif>  />
                  <label class="form-check-label" for="mobiledev"> Mobile App Development (iOS/Android)</label> <br />
                  <input class="form-check-input" type="checkbox" id="database" name="interest" value="Database Management" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Database Management")> checked</cfif> />
                  <label class="form-check-label" for="database">Database Management</label> <br />
                  <input class="form-check-input" type="checkbox" id="cloud" name="interest" value="Cloud Computing" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Cloud Computing")> checked</cfif>  />
                  <label class="form-check-label" for="cloud">Cloud Computing</label> <br />
                  <input class="form-check-input" type="checkbox" id="datascience" name="interest" value="Data Science" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Data Science")> checked</cfif> />
                  <label class="form-check-label" for="datascience">Data Science / Machine Learning</label> <br />
                  <input class="form-check-input" type="checkbox" id="cybersecurity" name="interest" value="Cybersecurity" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Cybersecurity")> checked</cfif> />
                  <label class="form-check-label" for="cybersecurity"> Cybersecurity</label> <br />
                  <input class="form-check-input" type="checkbox" id="uiux" name="interest" value="UI/UX Design" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "UI/UX Design")> checked</cfif> />
                  <label class="form-check-label" for="uiux">UI/UX Design</label> <br />
                  <input class="form-check-input" type="checkbox" id="testing" name="interest" value="Software Testing" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Software Testing")> checked</cfif> />
                  <label class="form-check-label" for="testing">Software Testing</label> <br />
                  <input class="form-check-input" type="checkbox" id="networking" name="interest" value="Networking" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Networking")> checked</cfif> />
                  <label class="form-check-label" for="networking"> Networking</label> <br />
                  <input class="form-check-input" type="checkbox" id="devops" name="interest" value="DevOps" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "DevOps")> checked</cfif> />
                  <label class="form-check-label" for="devops">DevOps</label> <br />
                  <input class="form-check-input" type="checkbox" id="ai" name="interest" value="Artificial Intelligence" <cfif structKeyExists(url, "id") AND len(url.id) AND  listFind(res.area_of_skills, "Artificial Intelligence")> checked</cfif>  />
                  <label class="form-check-label" for="ai"> Artificial Intelligence (AI) / Automation</label> <br/>
                  <input class="form-check-input" type="checkbox" id="accoutant" name="interest" value="Junior Accountant" <cfif structKeyExists(url, "id") AND len(url.id) AND  listFind(res.area_of_skills, "accoutant")> checked</cfif>  />
                  <label class="form-check-label" for="accoutant"> Junior Accountant</label>
                  <div id="areaInterestError" class="invalid-feedback" style="display: none; font-size: 17px;"> Area of Interest is required </div>
                </div>
            </div>

            <!-- Area of Domain for Experienced -->
            <div id="areaOfDomain" class="form-group">
                <label>Area of Domain:</label>
                  <div class="checkbox-group" style="margin-left: 30px">
                    <input class="form-check-input" type="checkbox" id="dotnet" name="domain" value=".NET" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills,".NET")> checked</cfif> />
                    <label class="form-check-label" for="dotnet">.NET (C##, ASP.NET, Blazor)</label> <br />
                    <input class="form-check-input" type="checkbox" id="js" name="domain" value="JavaScript" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "JavaScript")> checked</cfif> />
                    <label class="form-check-label" for="js"> JavaScript (React, Angular, Vue.js)</label> <br />
                    <input class="form-check-input" type="checkbox" id="php" name="domain" value="PHP" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "PHP")> checked</cfif> />
                    <label class="form-check-label" for="php">PHP (Laravel, Symfony)</label><br />
                    <input class="form-check-input" type="checkbox" id="python" name="domain" value="Python" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Python")> checked</cfif> />
                    <label class="form-check-label" for="python"> Python (Django, Flask)</label> <br />
                    <input class="form-check-input" type="checkbox" id="ruby" name="domain" value="Ruby" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Ruby")> checked</cfif> />
                    <label class="form-check-label" for="ruby">Ruby on Rails</label><br />

                    <input class="form-check-input" type="checkbox" id="qa" name="domain" value="Quality Assurance" <cfif structKeyExists(url, "id") AND len(url.id) AND listFind(res.area_of_skills, "Quality Assurance")> checked</cfif> />
                    <label class="form-check-label" for="qa">Quality Assurance (QA)</label> </br>
                    <div id="areaDomainError" class="invalid-feedback" style="display: none; font-size: 17px;">Area of Domain is required </div>
                  </div>
              </div>
            </div>
          </div>
          <div class="card p-4 my-2 shadow bg-white rounded">
            <div class="text-left">
              <h4 style="color: ##7d66e3; font-family: 'Raleway', sans-serif">Candidate Information </h4>
            </div>
            <div class="row py-1">
              <div class="col-4">
                <label for="fullname">Candidate Name</label>
                <input type="text" class="form-control" id="fullname" name="fullname" onkeypress="return isAlphabet(event)" required <cfif structKeyExists(url, "id") AND len(url.id)> value="#res.full_name#"</cfif> />
                <span id="error-message" style="color: red; display: none; font-size: 17px">Only letters are allowed!</span>
                <div class="invalid-feedback" style="font-size: 17px">Full name is required </div>
              </div>
              <div class="col-4">
                <label for="emailid">Email Address</label>
                  <input type="email" class="form-control" id="emailid" name="emailid" onblur="validateEmail()" required <cfif structKeyExists(url, "id") AND len(url.id)> value="#res.email_address#" </cfif>/>
                  <div class="invalid-feedback" style="font-size: 17px" id="emailError"/>Please enter a valid email address.</div>
              </div>
              <div class="col-4">
                <label for="phone">Phone Number</label>
                  <input type="number" class="form-control" id="phone" name="phone" onkeyup="return isNumberKey(event)" maxlength="10" required <cfif structKeyExists(url, "id") AND len(url.id)> value="#res.phone_number#" </cfif> />
                  <small id="phoneError" style="color: ##dc3545; display: none; font-size: 17px">Please enter a valid 10-digit phone number.</small>
              </div>
            </div>
            <!-- <br> -->
            <cfset year_of_experience_list = "1-2 years,2-3 years,3-4 years,4-5 years,6-7 years,7-8 years,8-9 years,9-10 years,10-11 years,11-12 years,12-13 years,13-14 years,14-15 years" />
            <cfif structKeyExists(url, "id") AND len(url.id) AND listFindNoCase(year_of_experience_list, res.year_of_experience)>
              <cfset isExperience = true>
            <cfelse>
              <cfset isExperience = false>
            </cfif>
            <div class="row py-1">
              <div class="col-4" id="jobTitleField"style="display: <cfif isExperience> block <cfelse> none </cfif>;">
                <label for="jobname">Current Job Title</label>
                <input type="text" class="form-control" id="jobname" name="jobname" <cfif structKeyExists(url, "id") AND len(url.id)> value="#res.current_job#" </cfif> />
              </div>
              <div class="col-4" id="experienceField">
                <label for="experience">Years of Experience</label>
                <select class="form-select" id="experience" name="experience" required>
                  <option value="no-experience" disabled selected hidden>Choose Experience</option>
                    <cfloop list="#year_of_experience_list#" index="item">
                        <option value="#item#"<cfif structKeyExists(url, "id") AND len(url.id) AND res.year_of_experience EQ "#item#"> selected</cfif>>#item#</option>
                  </cfloop>
                </select>
                    <div class="invalid-feedback" style="font-size: 17px">
                      Years of Experience is required
                    </div>
              </div>
              <div class="col-4" id="previousEmployerField">
                <label for="previousEmployer">Previous Employer</label>
                <input type="text" class="form-control" id="previousEmployer" name="previousEmployer" <cfif structKeyExists(url, "id") AND len(url.id)> value="#res.Previous_employer#" </cfif> />
              </div>
            </div>
            <cfset education_level_list = "Bachelors,Masters,PhD,Diploma,High School" />
            <cfif structKeyExists(url, "id") AND len(url.id) AND listFindNoCase(education_level_list, res.education_level)>
            </cfif>
            <div class="row py-1">
              <div class="col-4">
                <label for="educationLevel">Education Level</label>
                <select class="form-select" id="educationLevel" name="educationLevel"  required>
                  <option value="" disabled selected> Choose Education Level </option>
                    <cfloop list="#education_level_list#" index="item">
                      <option value="#item#"<cfif structKeyExists(url, "id") AND len(url.id) AND res.education_level EQ "#item#"> selected</cfif>>#item#</option>
                    </cfloop>
                </select>
                <div class="invalid-feedback" style="font-size: 17px">
                  Education Level is required
                </div>
              </div>
              <div class="col-4">
                <label for="certifications">Certifications</label>
                  <textarea type="text" class="form-control" id="certifications" name="certificate" rows="1"><cfif structKeyExists(url, "id") AND len(url.id)> #res.certifications_by#</cfif></textarea>
              </div>
            <div class="col-4">
                <cfset key_Skills_list = "HTML5,CSS,Java,JavaScript,Python,Design,SQL,SAP S/4HANA FI,Tally Prime & ERP 9,Zoho Books,MS Excel,GST,Gulf VAT,Income Tax,ESI & PF Declaration"/>
                <label for="keySkills">Key Skills</label>
                <div class="dropdown" id="keySkillsDropdown">
                    <button class="dropdown-toggle w-100 d-flex justify-content-between form-control align-items-center custom-dropdown-btn" 
                            type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span id="selectedKeySkills">Select Key Skills</span>
                    </button>
                    <ul class="dropdown-menu w-100" aria-labelledby="dropdownMenuButton">
                        <cfloop list="#key_Skills_list#" index="item">
                            <li>
                                <div class="form-check">
                                    <input class="form-check-input key-skill-checkbox" type="checkbox" id="keySkills_#item#" 
                                           name="keySkills[]" value="#item#"
                                           <cfif structKeyExists(url, "id") AND len(url.id) AND listFindNoCase(res.key_skills, item)>
                                               checked
                                           </cfif>>
                                    <label class="form-check-label" for="keySkills_#item#">#item#</label>
                                </div>
                            </li>
                        </cfloop>
                    </ul>
                </div>
                   <div id="keySkillsError" class="invalid-feedback" style="font-size: 17px; display: none;">Key Skills is required</div>
            </div>
          </div>
        <!-- <br> -->
            <div class="row py-1">
                <div class="col-6">
                  <label for="linkedin">LinkedIn Profile or Portfolio Link</label>
                    <input type="url" id="linkedin" name="linkedin" class="form-control" <cfif structKeyExists(url, "id") AND len(url.id)>
                    value="#res.linkedin_link#" </cfif> />
                </div>
                <div class="col-6">
                  <label for="fileInput">Resume Upload</label>
                    <input type="file" class="form-control" id="fileInput" name="resume_upload" accept=".pdf,.doc,.docx" <cfif NOT structKeyExists(url, "id")> required </cfif>  />
                    <div class="invalid-feedback" style="font-size: 17px">Resume is required </div>
                    <p id="fileError" style="color: red; font-size: 17px"></p>
                </div>
            </div>
          </div>
          <div class="card p-4 my-2 shadow bg-white rounded">
            <div class="text-left my-2">
              <h4 class="" style=" color: ##7d66e3; font-family: 'Raleway', sans-serif; font-weight: 400;">Job Details</h4>
            </div>
            <div class="row py-1">
              <div class="col-4">
                  <label>Job Submission Preference</label>
                    <input class="form-check-input mx-1" type="radio" id="currentopening" name="Preference" value="Apply for current opening" required <cfif structKeyExists(url, "id") AND len(url.id) AND res.job_submission EQ "Apply for current opening"> checked</cfif> />
                  <label for="currentopening" class="mx-4">Apply for current opening</label>
                    <input class="form-check-input mx-1" type="radio" id="futureopening" name="Preference" value="Apply for any future opening" required <cfif structKeyExists(url, "id") AND len(url.id) AND res.job_submission EQ "Apply for any future opening"> checked</cfif> />
                  <label for="futureopening" class="mx-4">Apply for any future opening</label>
                    <div class="invalid-feedback" style="font-size: 17px">Job Submission Preference is required </div>
              </div>
              <div class="col-4">
                  <label>Preferred Location</label>
                    <input type="radio" class="form-check-input mx-1" id="onsite" name="preferred_location" value="On-site" required <cfif structKeyExists(url, "id") AND len(url.id) AND res.preferred_location EQ "On-site"> checked</cfif> />
                  <label for="onsite" class="mx-4">On-site</label>
                    <input type="radio" class="form-check-input mx-1" id="remote" value="Remote" name="preferred_location" required <cfif structKeyExists(url, "id") AND len(url.id) AND res.preferred_location EQ "Remote"> checked</cfif> />
                  <label for="remote" class="mx-4">Remote</label>
                    <div class="invalid-feedback" style="font-size: 17px">Preferred Location is required </div>
              </div>
                  <cfif structKeyExists(url, "id")>
              <div class="col-4">
                  <div class="d-flex align-items-center status-container">
                    <label for="statuscheck" class="me-5" id="statusLabel">Status</label>
                        <div class="form-check form-switch statuscheck">
                            <!-- Checkbox is only editable for admin users -->
                            <input class="form-check-input" type="checkbox" id="statuscheck" name="statuscheck" value="1" onchange="toggleStatus()" <cfif structKeyExists(url, "id") AND len(url.id) AND res.referral_status EQ "1"> checked <cfelseif structKeyExists(url, "id") AND len(url.id) AND session.employee.ROLE_ID NEQ 1> disabled <cfelseif NOT (structKeyExists(url, "id") AND len(url.id) AND session.employee.ROLE_ID EQ 1)> </cfif>>
                        </div>
                  </div>

                  <div class="mb-3" id="reasonContainer" style="display: <cfif structKeyExists(url, "id") AND len(url.id) AND res.referral_status EQ "1"> none <cfelse> </cfif>;">
                      <label for="reasonDeactive" class="form-label" id="reasonlabel">Reason For Deactive</label>
                        <textarea type="text" class="form-control" id="reasondeactive" name="reason" rows="1" placeholder="Enter reason here"<cfif structKeyExists(url, "id") AND len(url.id) AND session.employee.ROLE_ID NEQ 1 AND res.referral_status EQ 0> readonly="readonly"</cfif>><cfif structKeyExists(url, "id") AND len(url.id) AND res.reason_of_deactivation NEQ "">#res.reason_of_deactivation#</cfif></textarea>
                      <div class="invalid-feedback" style="font-size: 17px">Deactive reason is required </div>
                  </div>
              </div>
            </cfif>
             <cfset Relationship_candidate_list = "Friend,Former Colleague,Family,Other" />
            <cfif structKeyExists(url, "id") AND len(url.id) AND listFindNoCase(Relationship_candidate_list, res.relationship_candidate)>
            </cfif>
            <div class="row py-1">
                <div class="col-6 my-2">
                <label for="Relationship">Relationship to Candidate</label>
                <select class="form-select" id="Relationship" name="Relationship" required>
                  <option value="" disabled selected>
                    Select Relationship to Candidate
                  </option>
                  <cfloop list="#Relationship_candidate_list#" index="item">
                        <option value="#item#"<cfif structKeyExists(url, "id") AND len(url.id) AND res.relationship_candidate EQ "#item#"> selected</cfif>>#item#</option>
                    </cfloop>
                </select>
                <div class="invalid-feedback" style="font-size: 17px">
                  Relationship to Candidate is required
                </div>
              </div>
              <div class="col-6 my-2">
                <label for="Recommending">
                  Why are you recommending this candidate ?</label>
                <textarea type="text" class="form-control" id="Recommending" name="Recommending" rows="1"><cfif structKeyExists(url, "id") AND len(url.id)>#res.recommending_candidate#</cfif> </textarea>
              </div>
            </div>
          </div>
        </div>
          <div class="text-center my-3 lg">
             <cfif structKeyExists(url, "id")>
                <a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=" class="btn btn-sm" style="background-color: ##ff0000; color: ##fff; transition: 0.4s; border: 0; text-decoration: none;">
                  Cancel
                </a>
             </cfif>
                <button style="background: <cfif structKeyExists(url, 'id')>##28a745<cfelse>##7d66e3</cfif>; color: ##fff; transition: 0.4s; border: 0;" 
                  class="btn btn-sm" type="submit"> <cfif structKeyExists(url, "id")>Update<cfelse>Submit</cfif>
                </button>
          </div>
          </cfoutput>
          </div>
        </form>
      <script>
           function showOptions() {
          const fresher = document.getElementById("fresher").checked;
          const Experience = document.getElementById("Experience").checked;
        <cfif NOT (structKeyExists(url,"id") AND len(url.id))>
          if(Experience){
            document.getElementById("webdev").checked = false;
            document.getElementById("mobiledev").checked = false;
            document.getElementById("database").checked = false;
            document.getElementById("cloud").checked = false;
            document.getElementById("datascience").checked = false;
            document.getElementById("cybersecurity").checked = false;
            document.getElementById("uiux").checked = false;
            document.getElementById("testing").checked = false;
            document.getElementById("networking").checked = false;
            document.getElementById("devops").checked = false;
            document.getElementById("ai").checked = false;
          }
          if(fresher){
            document.getElementById("dotnet").checked = false;
            document.getElementById("js").checked = false;
            document.getElementById("php").checked = false;
            document.getElementById("python").checked = false;
            document.getElementById("ruby").checked = false;
            document.getElementById("qa").checked = false;
          }
          </cfif>
            const isEditMode = document.getElementById("editMode") ? true : false;

              if (isEditMode) {
                  // In edit mode, show only the appropriate section
                  if (fresher) {
                      document.getElementById("areaOfInterest").style.display = "block";
                      document.getElementById("areaOfDomain").style.display = "none"; // Hide Area of Domain if Fresher
                  } else if (Experience) {
                      document.getElementById("areaOfInterest").style.display = "none"; // Hide Area of Interest if Experience
                      document.getElementById("areaOfDomain").style.display = "block";
                  }
              } else {
                  // Otherwise, toggle visibility based on fresher or Experienced status
                  document.getElementById("areaOfInterest").style.display = fresher ? "block" : "none";
                  document.getElementById("areaOfDomain").style.display = Experience ? "block" : "none";
              }

          toggleFields();
        }
              document.addEventListener('DOMContentLoaded', function () {
              showOptions(); // Call showOptions on page load to ensure the sections are visible in edit mode
          });

            function validateForm(event) {
            const status = document.querySelector('input[name="status"]:checked') != null?document.querySelector('input[name="status"]:checked').value:null;
            const interestOptions = document.querySelectorAll('input[name="interest"]:checked');
            const domainOptions = document.querySelectorAll('input[name="domain"]:checked');
            
            let valid = true;

            // Validate Area of Interest for Fresher
            if (status === "Fresher" && interestOptions.length === 0) {
                document.getElementById('areaInterestError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('areaInterestError').style.display = 'none';
            }

            // Validate Area of Domain for Experience
            if (status === "Experience" && domainOptions.length === 0) {
                document.getElementById('areaDomainError').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('areaDomainError').style.display = 'none';
            }

            var isPhoneValid = validatePhoneNumber();
            if(!isPhoneValid){
              valid = isPhoneValid;
            }

            var isValidKeySkills = validateKeySkills();
            if(!isValidKeySkills){
              valid = isValidKeySkills;
            }

            if (!valid) {
                // Prevent form submission if invalid
                event.preventDefault();
            }

            return valid;  // Only submit the form if valid
        }
            document.getElementById("uploadForm").addEventListener("submit", function(event) {
            validateForm(event);
        });

        function toggleFields() {
          const fresher = document.getElementById("fresher").checked;

          // Get individual fields
          const jobTitleField = document.getElementById("jobTitleField");
          const experienceField = document.getElementById("experienceField");
          const previousEmployerField = document.getElementById(
            "previousEmployerField"
          );

          // Hide or show fields based on the selection
          if (fresher) {
            jobTitleField.style.display = "none"; // Hide Current Job Title
            experienceField.style.display = "none"; // Hide Years of Experience
            previousEmployerField.style.display = "none"; // Hide Previous Employer
          } else {
            jobTitleField.style.display = "block"; // Show Current Job Title
            experienceField.style.display = "block"; // Show Years of Experience
            previousEmployerField.style.display = "block"; // Show Previous Employer
          }
        }
        function isAlphabet(evt) {
          var charCode = evt.which ? evt.which : evt.keyCode;

          // Allow only alphabetic characters (A-Z, a-z) and space
          if (
            (charCode >= 65 && charCode <= 90) ||
            (charCode >= 97 && charCode <= 122) ||
            charCode == 32
          ) {
            document.getElementById("error-message").style.display = "none"; // Hide error message
            return true;
          } else {
            document.getElementById("error-message").style.display = "inline"; // Show error message
            return false;
          }
        }
        function validateEmail() {
          const emailInput = document.getElementById("emailid");
          const emailError = document.getElementById("emailError");
          const emailPattern =
            /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // Basic regex for email validation

          // Check if the email input is empty
          // if (emailInput.value.trim() === "") {
            if (emailInput.value.trim() === "") {

            // alert("Email address is required."); // Show alert if empty
            emailError.style.display = "none"; // Hide error message
          } else if (emailPattern.test(emailInput.value)) {
            emailError.style.display = "none"; // Hide error message
          } else {
            emailError.style.display = "block"; // Show error message
          }
        }
        function isNumberKey(evt) {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          var valid = true;
          // Allow only numbers (ASCII codes 48-57 represent 0-9)
          if (charCode > 31 && (charCode < 48 || charCode > 57)) {
              valid = false; // Block non-numeric input
          }
          var isValidPhone = validatePhoneNumber();
          if(!isValidPhone){
            valid = isValidPhone;
          }
          return valid; // Allow numeric input
        }

        function validatePhoneNumber() {
          var phoneInput = document.getElementById("phone").value;
          var phoneError = document.getElementById("phoneError");

          // Check if the phone number is exactly 10 digits long
          if (phoneInput.length !== 10) {
              phoneError.style.display = "inline"; // Show error message
              return false; // Prevent form submission
          } else {
              phoneError.style.display = "none"; // Hide error message
              return true; // Allow form submission
          }
        }
          function toggleStatus() {
            const checkbox = document.getElementById('statuscheck');
            const reasonTextarea = document.getElementById('reasondeactive');
            const reasonLabel = document.getElementById('reasonlabel');
            const reasonContainer = document.getElementById('reasonContainer');

            // Check the state of the checkbox
            if (checkbox.checked) {
                checkbox.value = 1;
                // Checkbox is checked, hide the reason
                reasonLabel.style.display = 'none'; // Hide the label
                reasonTextarea.style.display = 'none'; // Hide the textarea
                reasonContainer.style.display = 'none'; // Hide the entire container
            } else {
                checkbox.value = 0;
                // Checkbox is unchecked, show the reason
                reasonLabel.style.display = 'block'; // Show the label
                reasonTextarea.style.display = 'block'; // Show the textarea
                reasonContainer.style.display = 'block'; // Show the entire container
            }
        }

        <cfif NOT structKeyExists(url, "id")>
         document.getElementById("uploadForm")
          .addEventListener("submit", function (event) {
            const fileInput = document.getElementById("fileInput");
            const filePath = fileInput.value;
            const allowedExtensions = /(\.pdf|\.doc|\.docx)$/i;

            // Check if a file has been selected
            if (!fileInput.value) {
              document.getElementById("fileError").textContent = "";
              event.preventDefault();
              return;
            }

            // Check file extension
            if (!allowedExtensions.exec(filePath)) {
              document.getElementById("fileError").textContent =
                "Invalid file type. Please upload a PDF or Word file.";
              fileInput.value = ""; // Clear the file input
              event.preventDefault();
              return;
            }

            // Reset error message if file is valid
            document.getElementById("fileError").textContent = "";
          });
         </cfif>
        // document
        //   .querySelector("form")
        //   .addEventListener("submit", function (event) {
        //     const linkedinInput = document.getElementById("linkedin").value;
        //     const linkedinRegex = /^(https?:\/\/)?(www\.)?linkedin\.com\/.*$/;

        //     // if (!linkedinRegex.test(linkedinInput)) {
        //     //   alert("Please enter a valid LinkedIn profile link.");
        //     //   event.preventDefault(); // Prevent form submission if validation fails
        //     // }
        //   });
      </script>

      <script>
        (() => {
          "use strict";

          // Fetch all the forms we want to apply custom Bootstrap validation styles to
          const forms = document.querySelectorAll(".needs-validation");
          // Loop over them and prevent submission
          Array.from(forms).forEach((form) => {
            form.addEventListener(
              "submit",
              (event) => {
                 if (!form.checkValidity()||!customValidation()) {
                  event.preventDefault();
                  event.stopPropagation();
                }

                form.classList.add("was-validated");
              },
              false
            );
          });
        })();
         function validateKeySkills() {
            const checkboxes = document.querySelectorAll('.key-skill-checkbox');
            const dropdown = document.getElementById('keySkillsDropdown');
            const errorDiv = document.getElementById('keySkillsError');
            let atLeastOneChecked = false;

            // Check if any checkbox is selected
            checkboxes.forEach(checkbox => {
                if (checkbox.checked) {
                    atLeastOneChecked = true;
                }
            });

            // Apply styles to dropdown only
            if (atLeastOneChecked) {
                dropdown.querySelector("button").classList.remove('is-invalid');
                dropdown.querySelector("button").classList.add('is-valid');
                errorDiv.style.display = "none"; // Hide error message
            } else {
                dropdown.querySelector("button").classList.remove('is-valid');
                dropdown.querySelector("button").classList.add('is-invalid');
                errorDiv.style.display = "block"; // Show error message
            }
            return atLeastOneChecked;
        }

        // Attach event listeners to all checkboxes
        document.querySelectorAll('.key-skill-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', validateKeySkills);
        });

        // Validate on form submission
        document.querySelector('form').addEventListener('submit', function (e) {
            const checkboxes = document.querySelectorAll('.key-skill-checkbox');
            let atLeastOneChecked = false;

            checkboxes.forEach(checkbox => {
                if (checkbox.checked) {
                    atLeastOneChecked = true;
                }
            });

            if (!atLeastOneChecked) {
                e.preventDefault(); // Prevent form submission
                validateKeySkills(); // Trigger validation feedback
            }
        });
        function customValidation(){
           const status = document.getElementById("statuscheck");
           const reasonTextarea = document.getElementById("reasondeactive");
          const feedbackElement = reasonTextarea.parentElement.querySelector(".invalid-feedback");
        if (!status.checked && reasonTextarea.value == "") {
                
                $(feedbackElement).show(); 
                $(reasonTextarea).addClass("is-invalid");
                return false; 
            } else {
               
                $(feedbackElement).hide(); 
                $(reasonTextarea).removeClass("is-invalid"); 
            }
            return true;
        }
      </script>
      <script>
    // Update displayed selected key skills on page load
      document.addEventListener('DOMContentLoaded', () => {
          const selectedSkills = Array.from(document.querySelectorAll('.key-skill-checkbox:checked'))
              .map(checkbox => checkbox.value)
              .join(', ');
          document.getElementById('selectedKeySkills').textContent = selectedSkills || 'Select Key Skills';
      });

      // Update displayed selected key skills on checkbox change
      document.querySelectorAll('.key-skill-checkbox').forEach(checkbox => {
          checkbox.addEventListener('change', () => {
              const selectedSkills = Array.from(document.querySelectorAll('.key-skill-checkbox:checked'))
                  .map(checkbox => checkbox.value)
                  .join(', ');
              document.getElementById('selectedKeySkills').textContent = selectedSkills || 'Select Key Skills';
          });
      });

</script>
</body>
</html>
