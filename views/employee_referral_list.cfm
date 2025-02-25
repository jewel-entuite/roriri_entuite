<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RORIRI -Employee Management</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"/>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
       @media(max-width: 500px){
         section {
           overflow: scroll;
         }
       }
       .tag .remove {
          margin-left: 5px;
          color: #333;
          cursor: pointer;
/*            display: none;*/
        }
        .tag {
          display: inline-flex;
          align-items: center;
          background-color: #e0e0e0;
          padding: 4px 8px;
          border-radius: 10px;
          font-size: 14px;
          color: #333;
        }
        .selected-tags {
/*          margin-top: 10px;*/
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            }
        .clear-all {
            margin-top: 1px;
            color: gray;
            cursor: pointer;
            font-size: 16px;
            display: none; /* Hide initially */
            text-decoration: underline; /* Adds underline */
            }
        select {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px;
            }
        .selected-count {
            margin-top: 1px;
            font-size: 16px;
            color: dimgray;
            font-weight: bold;
            display: none; /* Hide initially */
            }  
        .selected-filter{
            padding: 1px 260px 10px 12px;
            margin-top:23px;
            }
         a.custom-btn {
          background: #fff;
          color: #7d66e3;
          border: 1px solid #7d66e3;
          border-radius: 5px;
          text-decoration: none;
          width:150px;
          padding: 4px;
          justify-content:center;
          }

          a.custom-btn:hover {
          background: #7d66e3;
          color: #fff;
          }
       .custom-dropdown-btn {
            background-color: transparent; / No background color /
            border: 1px solid #ced4da; / Neutral border similar to input /
            border-radius: 0.375rem; / Smooth corners /
            padding: 0.375rem 0.75rem; / Padding for alignment /
            box-shadow: none; / No default shadow /
            color: #495057; / Text color /
          }
       .custom-dropdown-btn:focus,
        .custom-dropdown-btn[aria-expanded="true"] {
            outline: none; / Remove default outline /
            border-color: #80bdff; / Highlighted blue border /
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25); / Light blue glow /
    }   
    .dropdown-menu li {
        padding: 0.3rem;
    }
    .dropdown-menu li:hover {
        background-color: #f8f9fa;
    }
    #selectedKeySkills {
        display: inline-block; / Ensures inline text layout /
        white-space: normal;   / Allows wrapping when necessary /
    }

    .custom-dropdown-btn {
        text-align: left; / Aligns text inside the button /
        white-space: normal; / Allows multi-line wrapping /
        overflow-wrap: break-word; / Breaks words if too long /
    }
    #loader {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 9999;
          }
    #overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
        z-index: 1000; /* Lower z-index */
          }
     </style>
      <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
  </head>
  <body>
    <cfoutput>
      <cfset active_status="employee_management">
      <cfif not structKeyExists(session, "EMPLOYEE")>
        <cflocation url="logout.cfm">
      <cfelseif session.employee.ROLE_ID EQ 1>
        <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
        <cfif structKeyExists(url, "referral_emp") AND url.referral_emp NEQ "">
          <cfinvoke component="models.employee" method="getall_referral" referral_emp="#url.referral_emp#" referral_date="#url.referral_date#" experience="#url.experience#" education_level="#url.education_level#" skills="#url.skills#" candidate_status="#url.candidate_status#"  returnvariable="referralList">
          <!--- <cfdump var="#referralList#"> --->
        <cfelse>
          <cfinvoke component="models.employee" method="getall_referral" referral_date="#url.referral_date#" experience="#url.experience#" education_level="#url.education_level#" skills="#url.skills#" candidate_status="#url.candidate_status#"  returnvariable="referralList">
          <!--- <cfinvoke component="models.employee" method="getall_referral" returnvariable="referralList"> --->
        </cfif>
      <cfelse>
        <cfset active_status="profile">
        <cfinclude template="../includes/header/user_header.cfm" runonce="true">
        <cfinvoke method="getall_referral" component="models.employee" referral_emp="#session.EMPLOYEE.ID#" referral_date="#url.referral_date#" experience="#url.experience#" education_level="#url.education_level#" skills="#url.skills#" candidate_status="#url.candidate_status#" returnvariable="referralList">
      </cfif>
      <!--- <cfdump var="#referralList#"> --->
    <main>
      <section id="contact" class="contact">
        <div class="m-5" data-aos="fade-up" style="margin-top: 80px">
                <div class="section-title pt-5 mt-5">
                    <h2>Employee Referral</h2>
                    <p>Referral List</p>
                </div>
            <div class="row mb-3">
                <div class="col-8"></div>    
                <div class="col-4 d-flex justify-content-end">
                    <a class="btn custom-btn btn-sm" href="employee_referral_form.cfm" role="button">New Referral</a>
                </div>
            </div>
          <div class="row">
            <div class="container">
              <style>
                  table{
                    border: 2px solid black;
                    border-radius: 20px;
                  }
                  td.cover-letter {
                    max-width: 0px; /* Set maximum width for the cover letter column */
                    overflow: hidden; /* Ensure text that overflows is hidden */
                    white-space: nowrap; /* Prevent text from wrapping to the next line */
                    text-overflow: ellipsis; /* Show ellipsis (...) when text overflows */
                  }
                  .danger-hover {
                  transition: background-color 0.3s, border-color 0.3s; /* Smooth transition */
                   }
                  .danger-hover:hover {
                  background-color: ##dc3545 !important; /* Danger red on hover */
                  border-color: ##dc3545 !important; /* Match border color */
                  color: white; /* Ensure text remains white */
                  }
                  .tag .remove {
                    margin-left: 5px;
                    color: ##333;
                    cursor: pointer;
/*                  display: none;*/
                   } 
                  .selected-filter{
                    padding: 1px 260px 10px 12px;
                    margin-top:23px;
                 }
                 .custom-btn {
                    background: ##fff;
                    color: ##7d66e3;
                    border: 1px solid ##7d66e3;
                    border-radius: 5px;
                    text-decoration: none;
                    width:150px;
                    padding: 4px;
                    justify-content:center;
               }
                  .custom-btn:hover {
                    background: ##7d66e3;
                    color: ##fff;
              }
                  .clear-all {
                    margin-top: 1px;
                    color: gray;
                    cursor: pointer;
                    font-size: 16px;
                    display: none; /* Hide initially */
                    text-decoration: underline;   
              }
              .custom-dropdown .dropdown-menu {
                  max-height: 200px; /* Limit the height of the dropdown for scrolling */
                  overflow-y: auto;  /* Enable vertical scrolling if items exceed max height */
                  padding: 10px;     /* Add padding around the items */
                  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Add a subtle shadow for depth */
              }

              /* Align the checkboxes and labels */
              .custom-dropdown .form-check-input {
                  margin-right: 10px; /* Add spacing between checkbox and label */
                  cursor: pointer;    /* Change cursor to pointer for interactivity */
              }

              /* Style each list item in the dropdown */
              .custom-dropdown li {
                  display: flex;          /* Align items horizontally */
                  align-items: center;    /* Center vertically */
                  padding: 5px 0;         /* Add spacing between items */
              }

              /* Button style for the dropdown */
              .custom-dropdown button {
                  text-align: left;             /* Align text to the left */
                  border: 1px solid ##ced4da;    /* Add a border to match Bootstrap styling */
                  background-color: ##fff;       /* White background */
                  color: ##495057;               /* Standard text color */
                  padding: 6.5px;                /* Add padding inside the button */
                  font-size: 15px;              /* Font size for readability */
                  border-radius: 4px;           /* Rounded corners */
                  box-shadow: none;             /* Remove Bootstrap default shadow */
              }

              /* Change button appearance on hover */
              .custom-dropdown button:hover {
                  background-color: ##f8f9fa;    /* Light gray background on hover */
                  color: ##343a40;               /* Darker text color */
              }

              /* Style for selected dropdown button when active */
              .custom-dropdown .dropdown-toggle::after {
                  content: ''; /* Remove default arrow icon */
                  display: inline-block;
                  margin-left: 0.5rem;
                  vertical-align: middle;
                  width: 0;
                  height: 0;
                  border-style: solid;
                  border-width: 0.4em 0.4em 0 0.4em;
                  border-color: transparent transparent transparent ##495057;
                  white-space: nowrap;
                  overflow: hidden;
                  text-overflow: ellipsis;
              }

              /* Scrollbar styling (optional for modern browsers) */
              .custom-dropdown .dropdown-menu::-webkit-scrollbar {
                  width: 8px;
              }

              .custom-dropdown .dropdown-menu::-webkit-scrollbar-thumb {
                  background-color: ##adb5bd; /* Gray color for scrollbar thumb */
                  border-radius: 4px;        /* Rounded edges */
                  justify-content:right; /* Set scrollbar width */
              }

              .custom-dropdown .dropdown-menu::-webkit-scrollbar-thumb:hover {
                  background-color: ##6c757d; /* Darker gray on hover */
              }

               </style>
              <div class="card p-2">
                <div class="mb-2 ms-3 mt-3 fs-6 fw-bold" style="color:##7d66e3;">
                      <label>REFERRAL LIST</label>
                </div>
                <hr>
                  <div id="overlay" style="display: none;"></div>
                  <div id="loader" style="display: none;">
                      <img src="../assets/img/loader.gif" width="50" height="50" alt="Loading...">
                  </div>
              <div class="m-5">
                <div class="row my-3 me-mx-5">
                  <cfif session.employee.ROLE_ID EQ 1>
                    <div class="col-md-2">
                      <cfinvoke  component="models.employee" method="getAllcandidates" returnvariable="referBy"/>
                      <label for="" >Referred By</label>
                      <select class="form-select border-dark show-selected-tags" name="Referredby" id="Referredby"  onchange="filter()">
                        <option class="dropdown-item" value="">Choose Employees</option>
                          <cfoutput query="referBy">
                            <option class="dropdown-item" value="#referBy.id#"<cfif structKeyExists(url, "referral_emp") AND url.referral_emp EQ "#referBy.id#">selected</cfif>>#referBy.first_name#</option>
                          </cfoutput>
                      </select>
                    </div>
                  </cfif>
                  <div class="col-md-2">
                    <label for="referral_date">Referral Date</label>
                      <cfoutput>
                          <input type="date" class="form-control border-dark show-selected-tags" name="referral_date" id="referral_date" onchange="filter()"  <cfif structKeyExists(url, "referral_date") AND url.referral_date NEQ "">value="#url.referral_date#" </cfif> >
                      </cfoutput>
                  </div>
                 <cfset year_of_experience_list = "Fresher,1-2 years,2-3 years,3-4 years,4-5 years,6-7 years,7-8 years,8-9 years,9-10 years,10-11 years,11-12 years,12-13 years,13-14 years,14-15 years" />
                     <div class="col-md-2">
                        <label for="experience">Fresher/Experience</label>
                        <div class="dropdown custom-dropdown">
                            <button class="dropdown-toggle-item w-100 border-dark show-selected-tags fw-4" type="button" id="dropdownMenuButtonExperience" data-bs-toggle="dropdown" aria-expanded="false">
                              <cfset expArray = []>
                              <cfloop list="#url.experience#" index="epxr">
                                  <cfif listFindNoCase(year_of_experience_list, epxr, ',')>
                                    <cfset arrayAppend(expArray, epxr)>
                                  </cfif>
                              </cfloop>
                              <cfset listOfExp = arrayToList(expArray)>
                              <cfset listOfExp = listRemoveDuplicates(listOfExp)>
                              <cfif listLen(listOfExp)>
                                #listOfExp#
                              <cfelse>
                                Fresher/Experience
                              </cfif>
                            </button>
                            <ul class="dropdown-menu w-100 all-employees-dropdown">

                                <!-- "All" Checkbox -->
                               <!---  <li>
                                    <input type="checkbox" class="form-check-input border-dark" id="experience-checkbox-all" value="all"
                                      <cfif structKeyExists(url, "experience") AND listFindNoCase(url.experience, "all")>checked</cfif>
                                           onchange="filter()">
                                      <!--- <label class="form-check-label" for="experience-checkbox-all">Fresher/Experience</label> --->
                                </li> --->

                                <!-- Loop through experience list -->
                                <cfloop list="#year_of_experience_list#" index="exp">
                                    <li>
                                        <input type="checkbox" class="form-check-input experience-checkbox" id="experience-checkbox-#exp#" value="#exp#" 
                                          <cfif structKeyExists(url, "experience") AND listFindNoCase(url.experience, exp)>checked</cfif> onchange="filter()">
                                              <label class="form-check-label" for="experience-checkbox-#exp#">#exp#</label>
                                    </li>
                                </cfloop>
                            </ul>
                        </div>
                    </div>
                  <cfset education_level_list = "Bachelors,Masters,PhD,Diploma,High School" />
                   <div class="col-md-2 ">
                     <label for="education_level">Education level</label>
                       <select class="form-select border-dark show-selected-tags" name="education_level" id="education_level" onchange="filter()">
                         <option class="dropdown-item" value="">Education level</option>
                           <cfloop list="#education_level_list#" index="item">
                                <option value="#item#"<cfif structKeyExists(url, "education_level") AND url.education_level EQ "#item#"> selected</cfif>>#item#</option>
                           </cfloop>
                       </select>
                    </div>
                  <div class="col-md-2">
                    <cfset key_Skills_list = "Java,Python,JavaScript,Design,SQL,SAP S/4HANA FI,Tally Prime & ERP 9,Zoho Books,MS Excel,GST,Gulf VAT,Income Tax,ESI & PF Declaration" />
                    <label for="Key_skills" >Key Skills</label>
                      <select class="form-select border-dark show-selected-tags" name="Key_skills" id="Key_skills" onchange="filter()">
                        <option class="dropdown-item" value="">Key Skills</option>
                          <cfloop list="#key_Skills_list#" index="item">
                            <option class="dropdown-item" value="#item#"<cfif structKeyExists(url, "skills") AND url.skills EQ item> selected</cfif>>#item#</option>
                          </cfloop>
                      </select>
                  </div>
                  <div class="col-md-2">
                    <label for="candidate_status" >Candidate Status</label>
                    <select class="form-select border-dark show-selected-tags" name="candidate_status" id="candidate_status" onchange="filter()">
                      <option class="dropdown-item" value="">Candidate Status</option>
                      <option class="dropdown-item" value="1"<cfif structKeyExists(url, "candidate_status") AND url.candidate_status EQ "1">selected</cfif>>Active</option>
                      <option class="dropdown-item" value="0"<cfif structKeyExists(url, "candidate_status") AND url.candidate_status EQ "0">selected</cfif>>Deactivated</option>        
                    </select>
                  </div>
              </div>
              <div class="row selected-filter ">
                <div id="selected-count" class="col-2 selected-count">Filter's Selected:0</div>
                <div class="col-1 clear-all" onclick="clearAll()">Clear All</div>
                <div id="selected-tags" class="col-9 selected-tags "></div>
              </div>
              <!--- <cfloop query="employeeList">
                <cfif session.employee.ROLE_ID EQ 1 AND URL.referral_emp NEQ "" AND queryRecordCount(referralList) GT "0">
                 <center>
                    <div class="p-2 text-center alert alert-warning rounded-top mb-2" style="width:500px;">
                      <h6><b>REFERRED BY-#ucase(referralList.first_name)# #ucase(referralList.last_name)#</b></h6>
                    </div>
                  </center>
                </cfif>
                <cfif queryRecordCount(referralList) GT 0>
                  <center>
                    <div class="p-2 text-center alert alert-warning rounded-top mb-2" style="width:500px;"><h6><b>#ucase(referralList.first_name)# #ucase(referralList.last_name)#</b></h6>
                    </div>
                  </center>
                  <table class="table table-striped border-dark px-5" style="overflow: hidden; width: 100%;">
                    <thead style="background-color: ##31394F;">
                      <tr class="justify-content-center" style="font-size: small; vertical-align:middle; color: white; height: 100%;">
                        <th>NO</th>
                        <th>CANDIDATE NAME</th>
                        <th>EMAIL ADDRESS</th>
                        <th>PHONE NUMBER</th>
                        <th>FRESHER/EXPERIENCE</th>
                        <th>EDUCATION LEVEL</th>
                        <th>KEY SKILLS</th>
                        <th>REFERRAL DATE</th>
                        <th style="width: 10%" class="justify-content-center">ACTION</th> 
                        <th>CANDIDATE STATUS</th>
                      </tr>
                    </thead>
                    <tbody style="background-color: ##FEF7F5">
                      <cfset k=1>
                      <cfif queryRecordCount(referralList) GT 0>
                        <cfoutput query="referralList">
                        <tr class="justify-content-center" >
                          <td>#k#</td>
                          <td>#referralList.full_name#</td>
                          <td>#referralList.email_address#</td>
                          <td>#referralList.phone_number#</td>
                          <td>#referralList.year_of_experience#</td>
                          <td>#referralList.education_level#</td>
                          <td>#referralList.key_skills#</td>
                          <td class="cover-letter">#dateFormat(referralList.referral_date,"dd-mm-yyyy")#</td>
                          <td>
                              <button data-toggle="tooltip" data-placement="bottom" title="" 
                                  class="btn btn-sm btn-outline-primary" 
                                  onclick="editDetails('#encrypt(referralList.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES', 'HEX')#')">
                                  <i class="bi bi-pencil-square"></i></button>
                        
                              <button data-toggle="tooltip" data-placement="bottom" title="" class="btn btn-sm btn-outline-success" onclick="CandidateDetails('#encrypt(referralList.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#')">
                                    <i class="bi bi-eye"></i></button>

                              <cfif referralList.referral_status EQ "1">
                                <span data-toggle="popover" data-bs-container="body" data-placement="right" title="#referralList.reason_of_deactivation#" class="outline-dark">
                                    <i class="bi bi-info-circle"></i>
                                </span>
                              </cfif>
                            </td>
                          <td>
                           <!--- <button id="deactivate-btn" class=" btn btn-sm btn btn-success" type="button" >Deactivate</button> --->
                            <cfif referralList.referral_status EQ "1">
                              <button type="button" class=" <cfif session.employee.ROLE_ID NEQ 1>btn btn-sm btn btn-outline-danger disabled </cfif> btn btn-sm btn btn-outline-success disabled" data-bs-toggle="modal" data-bs-target="##exampleModal1" data-bs-whatever="@mdo" onclick="referralDeactivat(#referralList.id#)"><cfif session.employee.ROLE_ID EQ 1>Active <cfelse>Deactivated</cfif></button>
                            <cfelse>
                              <button type="button" class="btn btn-sm btn btn-outline-success disabled" data-bs-toggle="modal" data-bs-target="##exampleModal" data-bs-whatever="@mdo" onclick="referralDeactivated(#referralList.id#)">Active</button>
                            </cfif>
                          </td>
                        </tr>
                        <cfset k++>
                      </cfoutput>
                    </cfif>
                    </tbody>  
                <cfelse>
                  <tfoot>
                    <tr>
                      <td colspan="12" class="text-center "><h3 class="my-5">No Records Found!</h3></td>
                    </tr>
                  </tfoot>  
              </cfif>
            </table>
          </cfloop> --->
                  <cfquery name="referredEmployeeList" dbtype="query">
                    SELECT first_name,last_name,employee_id
                    FROM [referralList]
                    GROUP BY employee_id
                  </cfquery>
                <cfloop query="referredEmployeeList">
                    <cfif NOT (structKeyExists(url, "referral_emp") AND url.referral_emp EQ "#referredEmployeeList.employee_id#")>
                      <cfif session.employee.ROLE_ID EQ 1>
                          <center>
                            <div class="p-2 text-center alert alert-warning rounded-top mb-2" style="width:500px;">
                              <h6><b>REFERRED BY-#ucase(referredEmployeeList.first_name)# #ucase(referredEmployeeList.last_name)#</b></h6>
                            </div>
                          </center>
                      </cfif>
                  </cfif>
                  <cfquery name="getemployeereferraldetails" dbtype="query">
                    SELECT * FROM [referralList]
                    WHERE referred_by = <cfqueryparam value="#referredEmployeeList.employee_id#" cfsqltype="cf_sql_varchar"/> 
                  </cfquery>
                <!--- <cfinvoke component="models.employee" method="getemployeereferraldetails" employee_id= "#referredEmployeeList.id#" returnvariable="getemployeereferraldetails"> --->

                <table class="table table-striped border-dark px-5" style="overflow: hidden; width: 100%;">
                        <thead style="background-color: ##31394F;">
                            <tr class="justify-content-center" style="font-size: small; vertical-align:middle; color: white; height: 100%;">
                                <th>NO</th>
                                <th>CANDIDATE NAME</th>
                                <th>EMAIL ADDRESS</th>
                                <th>PHONE NUMBER</th>
                                <th>FRESHER/EXPERIENCE</th>
                                <th>EDUCATION LEVEL</th>
                                <th class="">KEY SKILLS</th>
                                <th>REFERRAL DATE</th>
                                <th style="width: 10%" class="justify-content-center">ACTION</th> 
                                <th>CANDIDATE STATUS</th>
                            </tr>
                        </thead>
                        <tbody style="background-color: ##FEF7F5">
                          <cfset k=1>
                          <cfif queryRecordCount(getemployeereferraldetails) GT 0>
                            <cfoutput query="getemployeereferraldetails">

                            <tr class="justify-content-center" >
                              <td>#k#</td>
                              <td>#getemployeereferraldetails.full_name#</td>
                              <td>#getemployeereferraldetails.email_address#</td>
                              <td>#getemployeereferraldetails.phone_number#</td>
                              <td>#getemployeereferraldetails.year_of_experience#</td>
                              <td>#getemployeereferraldetails.education_level#</td>
                              <td class="text-break">#getemployeereferraldetails.key_skills#</td>
                              <td class="cover-letter">#dateFormat(getemployeereferraldetails.referral_date,"dd-mm-yyyy")#</td>
                             <td>
                                <button data-toggle="tooltip" data-placement="bottom" title="" 
                                    class="btn btn-sm btn-outline-primary" 
                                    onclick="editDetails('#encrypt(getemployeereferraldetails.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES', 'HEX')#')">
                                    <i class="bi bi-pencil-square"></i></button>
                                    <button data-toggle="tooltip" data-placement="bottom" title="" class="btn btn-sm btn-outline-success" onclick="CandidateDetails('#encrypt(getemployeereferraldetails.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#')">
                                      <i class="bi bi-eye"></i></button>
                                    <cfif session.employee.ROLE_ID EQ 1>
                                      <cfif getemployeereferraldetails.referral_status EQ "0">
                                          <span data-toggle="popover" data-bs-container="body" data-placement="right" title="#getemployeereferraldetails.reason_of_deactivation#" class="outline-dark">
                                              <i class="bi bi-info-circle"></i>
                                          </span>
                                       </cfif>
                                    </cfif>
                             </td>
                             <td>
                             <!--- <button id="deactivate-btn" class=" btn btn-sm btn btn-success" type="button" >Deactivate</button> --->
                                <cfif getemployeereferraldetails.referral_status EQ "1">
                                    <button type="button" class="btn btn-sm btn btn-outline-success disabled" data-bs-toggle="modal" data-bs-target="##exampleModal" data-bs-whatever="@mdo" onclick="referralDeactivated(#getemployeereferraldetails.id#)">Active</button>
                                <cfelse>
                                     <button type="button" class="btn btn-sm btn btn-outline-danger disabled" data-bs-toggle="modal" data-bs-target="##exampleModal1" data-bs-whatever="@mdo" onclick="referralDeactivat(#getemployeereferraldetails.id#)">Deactivated</button>
                                </cfif>
                             </td>
                            </tr>
                            <cfset k++>
                          </cfoutput>
                           </tbody>
                          <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                              <div class="modal-content">
                                  <form action="../controller/_employee.cfm?candidatelist=1" method="post">
                                      <input type="hidden" name="candidate_id" id="candidate_id">  
                                <!-- <div class="modal-header">
                                  <h1 class="modal-title fs-5" id="exampleModalLabel">New message</h1>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div> -->
                                  </form>
                              </div>
                            </div>
                          </div>  
                         <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <form action="../controller/_employee.cfm?candidatelist=2" method="post">
                                <input type="hidden" name="deactive_candidate_id" id="deactive_candidate_id">
                                <div class="modal-body">     
                                </div>
                                <div class="modal-footer">
                                  <button type="submit" class="btn btn-sm btn-success">Submit</button>
                                </div>
                              </form>
                            </div>
                          </div>
                        </div>  
                        </tbody> 
                              <cfelse>
                      <tfoot>
                        <tr>
                          <td colspan="12" class="text-center "><h3 class="my-5">No Records Found!</h3></td>
                        </tr>
                      </tfoot>  
                  </cfif> 
                </table>
              </cfloop>
              <cfif queryRecordCount(referredEmployeeList) EQ 0>
                <table class="table table-striped border-dark px-5" style="overflow: hidden; width: 100%;">
                  <thead style="background-color: ##31394F;">
                      <tr class="justify-content-center" style="font-size: small; vertical-align:middle; color: white; height: 100%;">
                          <th>NO</th>
                          <th>CANDIDATE NAME</th>
                          <th>EMAIL ADDRESS</th>
                          <th>PHONE NUMBER</th>
                          <th>FRESHER/EXPERIENCE</th>
                          <th>EDUCATION LEVEL</th>
                          <th>KEY SKILLS</th>
                          <th>REFERRAL DATE</th>
                          <th style="width: 10%" class="justify-content-center">ACTION</th> 
                          <th>CANDIDATE STATUS</th>
                      </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <td colspan="12" class="text-center "><h3 class="my-5">No Records Found!</h3></td>
                    </tr>
                  </tfoot>  
                </table>
              </cfif>
            </div>
          </div>
        </div>
      </section>
    </main>
  </cfoutput>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Include Bootstrap CSS and JS if not already added -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
     <script>
        function CandidateDetails(Id){
                location.href="admin_allreferral_employee_details.cfm?token=&id="+Id;
              }
              function editDetails(Id) {
                   location.href ="employee_referral_form.cfm?id="+Id;
              }
              function referralDeactivated(referralid) {
                  document.getElementById("candidate_id").value=referralid;
              }
              function referralDeactivat(referralid) {
                console.log(referralid);
                document.getElementById("deactive_candidate_id").value=referralid;
              }
              const radioButtons = document.querySelectorAll('input[name="joinReason"]');
              const otherReasonContainer = document.getElementById('otherReasonContainer');

              radioButtons.forEach(radio => {
                radio.addEventListener('change', function() {
               if (this.value === 'yes') {
                otherReasonContainer.style.display = 'block'; // Show the textarea
               } 
               else {
                otherReasonContainer.style.display = 'none'; // Hide the textarea
                }
              });
            });
        function filter(){
            var Referralby = document.getElementById("Referredby")?document.getElementById("Referredby").value:"";
            // console.log(Referralby, "Referralby");
            var referraldate = document.getElementById("referral_date").value;
            // console.log(referraldate, "referraldate");
            var experiences = Array.from(document.querySelectorAll(".experience-checkbox:checked"))
                .map(checkbox => checkbox.value)
                .join(",");
            // console.log(experiences, "experiences");
            var educationlevel = document.getElementById("education_level").value;
            // console.log(educationlevel, "educationlevel")
            var Keyskills= document.getElementById("Key_skills").value;
            // console.log(Keyskills, "Keyskills");
            var Candidatestatus= document.getElementById("candidate_status").value;
            // console.log(Candidatestatus, "Candidatestatus");
            location.href="employee_referral_list.cfm?referral_emp="+Referralby+"&referral_date="+referraldate+"&experience="+experiences+"&education_level="+educationlevel+"&skills="+Keyskills+"&candidate_status="+Candidatestatus;
            document.getElementById("loader").style.display = 'block';
            document.getElementById("overlay").style.display = 'block';       
         }
        </script>
        <script>
        function addTag() {
            const selectedTagsDiv = document.getElementById("selected-tags");
            const allElements = document.querySelectorAll(".show-selected-tags");

            allElements.forEach(dropdown => {
            let valueText = "";
            let dropdownId = dropdown.id;
            if (dropdown.type === "select-one" || dropdown.type === "button") {
                const selectedValue = $(dropdown).val();
                let selectedValues = selectedValue ? selectedValue.toString().split(",") : [];
                valueText = selectedValues.map(s => {
                    const option = dropdown.querySelector(`option[value="${s}"]`);
                    return option ? option.innerHTML : "";
                }).join(", ");
                let allInputs = dropdown.parentElement.querySelectorAll(".experience-checkbox");
                let arrInputValue = [];
                if(allInputs.length){
                  [...allInputs].forEach((input)=>{
                    if(input.checked){
                      arrInputValue.push(input.value);
                    }
                  });
                  valueText = arrInputValue.join(", ");
                }
            }   else if (dropdown.type === "date") {
                // Directly get the value for date input
                valueText = dropdown.value ? formatDate(dropdown.value) : "";
            }
        // Prevent adding empty or duplicate tags
        if (!valueText.length || Array.from(selectedTagsDiv.children).some(tag => tag.getAttribute("data-dropdown") === dropdownId)) {
            return;
        }
            const labelText = getLabelForDropdown(dropdownId);

            // Create the tag with an identifier for the dropdown
            const tag = document.createElement("div");
            tag.id = `select-tags${dropdownId}`;
            tag.className = "tag";
            tag.setAttribute("data-dropdown", dropdownId);
            tag.innerHTML = `<strong>${labelText}:</strong>&nbsp;${valueText}<span class="remove" onclick="removeTag(this)">&nbsp;&times;</span>`;

            // Add or update the tag in the selected tags area
        if (document.getElementById(`select-tags${dropdownId}`) != null) {
            if (dropdown.value != "") {
                document.getElementById(`select-tags${dropdownId}`).outerHTML = tag.outerHTML;
            } else {
                document.getElementById(`select-tags${dropdownId}`).remove();
            }
        }     else {
            if (valueText != "") {
                selectedTagsDiv.appendChild(tag);
            }
        }

        showClearAllButton();
        updateSelectedCount();
    });
}
        function formatDate(dateString) {
           const [year, month, day] = dateString.split("-");
           return `${day}-${month}-${year}`;
        }
        function getLabelForDropdown(dropdownId) {
           switch(dropdownId) {
            case "Referredby": return "Referred By";
            case "referral_date": return "Referral Date";
            case "dropdownMenuButtonExperience": return "Fresher/Experience";
            case "education_level": return "Education Level";
            case "Key_skills": return "Key Skills";
            case "candidate_status": return "Candidate Status";
            default: return "Label";
    }
}
        function removeTag(element) {
        console.log(element);
        const tag = element.parentElement;
        const dropdownId = tag.getAttribute("data-dropdown");

          // Reset the corresponding dropdown
          const dropdown = document.getElementById(dropdownId);
          if (dropdown) {
              dropdown.value = ""; // Reset dropdown to placeholder option
              if(dropdown.hasAttribute('multiple')){
                dropdown.dispatchEvent(new Event('focusout'));
            }else{
                dropdown.dispatchEvent(new Event('change'));
            }

          }
          // Remove the tag
          tag.remove();

          // Hide the "Clear All" button if there are no selected tags
          hideClearAllButton();

          // Update selected count
          updateSelectedCount();
      }

          function clearAll() {
          // Reset all dropdowns to their placeholder options
          const dropdowns = document.querySelectorAll(".show-selected-tags");
          dropdowns.forEach(dropdown => {
              dropdown.value = ""; // Reset to empty
          });
          // Remove all tags
          const selectedTagsDiv = document.getElementById("selected-tags");
          selectedTagsDiv.innerHTML = "";
          const checkboxes = document.querySelectorAll('[id^="experience-checkbox"]');
          checkboxes.forEach(check => {
            check.checked = false; 
          });
          
          // Hide the "Clear All" button after clearing
          hideClearAllButton();

          // Update selected count
          updateSelectedCount();
          // location.reload();
          console.log(dropdowns);
          dropdowns[0].dispatchEvent(new Event('change'));
      }

          function showClearAllButton() {
          const clearAllButton = document.querySelector(".clear-all");
          clearAllButton.style.display = "inline-block"; // Show the button
      }

          function hideClearAllButton() {
          const selectedTagsDiv = document.getElementById("selected-tags");
          const clearAllButton = document.querySelector(".clear-all");
          
          // console.log("Number of tags:", selectedTagsDiv.children.length);

          // Hide the "Clear All" button if there are no tags selected
          if (selectedTagsDiv.children.length === 0) {
              clearAllButton.style.display = "none";
          }
      }
          function updateSelectedCount() {
          const selectedTagsDiv = document.getElementById("selected-tags");
          const selectedCountDiv = document.getElementById("selected-count");

          // Update count and toggle visibility
          const count = selectedTagsDiv.children.length;
          selectedCountDiv.innerText = `Filter's Selected: (${count})`;
          selectedCountDiv.style.display = count > 0 ? "block" : "none";
      }
          document.addEventListener("DOMContentLoaded", function(e) {
          addTag();
          hideClearAllButton();
      });
          function initializeDropdown() {
              const dropdownButton = document.getElementById("dropdownMenuButtonExperience");
              const checkboxes = document.querySelectorAll(".experience-checkbox");
              const selectAllCheckbox = document.getElementById("experience-checkbox-all");

          // Update dropdown button text based on selected checkboxes
          function updateDropdownText() {
              const selectedValues = Array.from(checkboxes)
              .filter(checkbox => checkbox.checked)
              .map(checkbox => checkbox.nextElementSibling.textContent); // Get the label text of the checked checkboxes
          if (selectedValues.length > 0) {
              dropdownButton.textContent = selectedValues.join(", ");
          } 
          else {
              dropdownButton.textContent = "Fresher/Experience"; // Default text
              }
          }
          // Handle individual checkbox clicks
          checkboxes.forEach(checkbox => {
              checkbox.addEventListener("click", function () {
                  updateDropdownText(); // Update dropdown button text on checkbox click
                  updateSelectAllCheckbox(); // Check if "Select All" should be checked or unchecked
              });
          });
          // Handle "Select All" checkbox click
          selectAllCheckbox.addEventListener("change", function () {
              const isChecked = this.checked;
              checkboxes.forEach(checkbox => {
                  checkbox.checked = isChecked; // Check or uncheck all checkboxes
              });
              updateDropdownText(); // Update dropdown button text
          });
          // Update "Select All" checkbox based on individual selections
          function updateSelectAllCheckbox() {
              const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked); // Check if all checkboxes are selected
              selectAllCheckbox.checked = allChecked; // Update "Select All" checkbox status
            }

            // Initialize dropdown text when the page loads
            updateDropdownText();
        }
 </script>
    <script>
             $(function () {
            // Initialize Bootstrap tooltips
                  $('[data-toggle="tooltip"]').tooltip();
              });
                  $(document).ready(function() {
              // Initialize popover with trigger click
              $('[data-toggle="popover"]').popover({
                  trigger: 'click', // Show popover on click
                  html: true // Enable HTML content
              });
              // Hide the first popover when another one is clicked
              $('[data-toggle="popover"]').on('click', function (e) {
                  // Close all popovers except the one that was clicked
                  $('[data-toggle="popover"]').not(this).popover('hide');       
                  // If the clicked popover is already shown, hide it
                  var $popover = $(this);
                  if ($popover.attr('aria-describedby') !== undefined) {
                      $popover.popover('hide');
                  } else {
                      $popover.popover('show');
                  }
              });
              // Close the popover if clicked outside of any popover
              $(document).on('click', function (e) {
                  if (!$(e.target).closest('.popover, [data-toggle="popover"]').length) {
                      $('[data-toggle="popover"]').popover('hide');
                  }
              });
          });
      </script>
</body>
</html>
