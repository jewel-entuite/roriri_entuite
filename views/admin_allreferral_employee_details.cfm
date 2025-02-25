<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <title>RORIRI -Employee Management : Add Employee</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  

    <style>
    	.pointer {
    		cursor: pointer;
    	}
    	section {
			  padding: 40px 0;
			  overflow: hidden;
			}
    </style>

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
  </head>

  <body>
  	<!--- <cfdump var="#session#" ><cfabort>
  	<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
  	<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/> --->

<!--- header --->
		<cfset active_status="employee_management">
    <cfif not structKeyExists(session, "EMPLOYEE")>
      <cflocation url="logout.cfm">
    <cfelseif session.employee.ROLE_ID EQ 1>
      <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
    <cfelse>
      <cfset active_status="profile">
      <cfinclude template="../includes/header/user_header.cfm" runonce="true">
    </cfif>
<!--- header ends --->
	<cfif structKeyExists(url, "id")>
  		<cfinvoke component="models.employee" method="getcandidate" id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="getcandidate"/>
	</cfif>
	<style>
		h6{
			font-size: 15px;
			margin: 0px;
		}
		.font_style{
			color:#6f80a3;
			font-size: 15px;
			font-weight: bold;
		}
		.font_style_NA{
			color:red;
			font-size: 14px;
			font-weight: bold;
		}
	</style>
	<cfoutput>
	<div class="container" style="margin-top:100px;">
        <div class="row">
          	<div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-4">
				    <section id="contact" class="contact">
			            <div class="section-title">
						        <h2>Candidate Profile</h2>
						        <p>Candidate Details</p><br>
						        <h3 class="text-secondary" style="font-weight: bold;"></h3>
						      </div>

			          <div class="col-lg-12 mt-7 mt-lg-0 d-flex align-items-stretch"  data-aos-delay="200">
					    	<div class="container">
							  <div class="card shadow p-3 mb-5 bg-white rounded">
					            <h4 class="card-title m-4" style="color: ##7d66e3;">Candidate Profile</h4>
					            <div class="row mx-4">
					            	<div class="col-12">
					            		<h6  class="mb-2">Referral Date</h6>
                             <cfif getcandidate.referral_date NEQ "">
                              <span class="font_style">#DateFormat(getcandidate.referral_date, 'dd-mm-yyyy')#</span> 
                            <cfelse> 
                              <span class="font_style_NA">NA</span>
                            </cfif>
					            	</div>
					            	<!--- <br> --->
					            </div>
					            <div class="row mx-4 my-3">
					          <div class="col-12">
					            <h6 for="cover_letter" class="mb-1">Cover Letter</h6>
					            <br>
					            <cfif getcandidate.cover_letter NEQ "">
					              <span style="##6f80a3">#getcandidate.cover_letter#</span>       
                      <cfelse> 
                        <span class="font_style_NA">NA</span>
					            </cfif>
					          </div>
					            </div>
					           <div class="row mx-4">
					           	<div class="col-lg-4 p-3">
					                <h6>Experience Status</h6>
			                      <cfif getcandidate.experience_status NEQ "">
                            <span class="font_style">#getcandidate.experience_status#</span>
                            <cfelse> 
                            <span class="font_style_NA">NA</span>
                            </cfif>
                      </div>
                      <div class="col-lg-4 p-3">
                      <cfif getcandidate.experience_status NEQ "" AND getcandidate.experience_status EQ "Experience">
					                <h6>Area of Domain</h6>
			                <cfelse>
					               		<h6>Area of Interest</h6>
					            </cfif>
					                  <cfif getcandidate.area_of_skills NEQ "">
                              <span class="font_style">#getcandidate.area_of_skills#</span> 
                            <cfelse> 
                              <span class="font_style_NA">NA</span>
                            </cfif>
                      </div>
					           
					           </div>
					        </div>
					        <div class="card shadow p-3 mb-5 bg-white rounded">
											<div class="d-flex justify-content-between align-items-center">
						            <h4 class="card-title m-4" style="color:##7d66e3;">Candidate Details</h4>
					          	</div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Candidate Name</h6>
					                		<cfif getcandidate.full_name NEQ "">
                              <span class="font_style">#getcandidate.full_name#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>

					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Email Address</h6>
					                	<cfif getcandidate.email_address NEQ "">
                              <span class="font_style">#getcandidate.email_address#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                             </cfif>
					                	
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Phone Number</h6>
					                	<cfif getcandidate.phone_number NEQ "">
                              <span class="font_style">#getcandidate.phone_number#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>	
					                </div>
					               </div>
					               <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Fresher/Experience</h6>
					                	<cfif getcandidate.year_of_experience NEQ "">
                              <span class="font_style">#getcandidate.year_of_experience#</span> 
                              <cfelse> 
                              <span class="font_style">#getcandidate.year_of_experience#</span>
                              </cfif>
					                	
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Education Level</h6>
					                	<cfif getcandidate.education_level NEQ "">
                              <span class="font_style">#getcandidate.education_level#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                            </cfif>
					                </div>
					                <div class="col-lg-4 p-3 ">
					                	<h6>Certifications</h6>
					                	<cfif getcandidate.certifications_by NEQ "">
                              <span class="font_style">#getcandidate.certifications_by#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>	
					                </div>
					            </div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Key skills</h6>
					                	<cfif getcandidate.key_skills NEQ "">
                              <span class="font_style">#getcandidate.key_skills#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>	
					                </div>
					               	<div class="col-lg-4 p-3 ">
					                	<h6>Linkedin</h6>
					                	<cfif getcandidate.linkedin_link NEQ "">
                              <span class="font_style"><a href="#getcandidate.linkedin_link#" target="_blank">#getcandidate.linkedin_link#</a></span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                            </cfif>	
					                </div>
					            <div class="col-lg-4 p-3 ">
					                	<h6>Resume</h6>
					                	<cfif getcandidate.resume NEQ "">
                              <span class="font_style"><a href="../assets/resume_documents/#getcandidate.resume#">#getcandidate.resume#</a></span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>	
					                </div>
					           </div>
					            <div class="row mx-4">
					            	<cfif getcandidate.current_job NEQ "">
					                  <div class="col-lg-4 p-3 ">
					                	<h6>Current Job Title</h6>
					                	<cfif getcandidate.current_job NEQ "">
                              <span class="font_style">#getcandidate.current_job#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>	
					                  </div>
					              </cfif>
					                <cfif getcandidate.Previous_employer NEQ "">
					               	<div class="col-lg-4 p-3 ">
					                	<h6>Previous Employer</h6>
					                	<cfif getcandidate.Previous_employer NEQ "">
                              <span class="font_style">#getcandidate.Previous_employer#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                            </cfif>	
					                </div>
					              </cfif>
					           </div>
					         </div>
					        <div class="card shadow p-3 mb-5 bg-white rounded">
											<div class="d-flex justify-content-between align-items-center">
						            <h4 class="card-title m-4" style="color:##7d66e3;">Job Details</h4>
					          	</div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Job Submission Preference</h6>
					                		<cfif getcandidate.job_submission NEQ "">
                              <span class="font_style">#getcandidate.job_submission#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Preferred Location</h6>
					                	<cfif getcandidate.preferred_location NEQ "">
                              <span class="font_style">#getcandidate.preferred_location#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                             </cfif>	
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Relationship to Candidate</h6>
					                	<cfif getcandidate.relationship_candidate NEQ "">
                              <span class="font_style">#getcandidate.relationship_candidate#</span> 
                              <cfelse> 
                              <span class="font_style_NA">NA</span>
                              </cfif>	
					                </div>
					               </div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Why are you recommending this candidate ?</h6>
					                		<cfif getcandidate.recommending_candidate NEQ "">
                              	<span class="font_style">#getcandidate.recommending_candidate#</span> 
                              <cfelse> 
                              	<span class="font_style_NA">NA</span>
                              </cfif>   	
					                </div>
					            </div>
					        </div>

					      <cfif getcandidate.referral_status EQ "0">
					      	 
					        <div class="card shadow p-3 mb-5 bg-white rounded">
					            <h4 class="card-title m-4" style="color: ##7d66e3;">Candidate Referral Status</h4>
					            <div class="row mx-4">
					          <div class="col-4">
					            <h6>Candidate deactivate reason</h6>
					          
					           	<cfif getcandidate.referral_status NEQ "">
                              <span class="font_style">#getcandidate.reason_of_deactivation#</span> 
                      <cfelse> 
                              <span class="font_style_NA">NA</span>
                      </cfif>  
					          
					          </div>
					          <div class="col-4">
					            <h6>Candidate Status</h6>
					          
					           	<cfif getcandidate.referral_status NEQ "">
					           	<cfif getcandidate.referral_status EQ 0 >
                              <span class="font_style">Deactivated</span>
                      <cfelse>
                              <span class="font_style">Active</span>
                      </cfif> 
                      <!--- <cfelse> 
                              <span class="font_style_NA">NA</span>
 --->                 </cfif>  
					          
					          </div>
					          <div class="col-4">
						            <h6>Deactivated By</h6> 
						           		<cfif getcandidate.deactivated_by NEQ "" AND getcandidate.referral_status EQ 0>
                          	<span class="font_style">#getcandidate.deactivated_name#</span> 
	                        <cfelse> 
	                          <span class="font_style_NA">NA</span>
	                      </cfif>  
					          </div>
                    </div>
				         <div class="row mx-4">
					         <div class="col-lg-4 p-3">
					              <h6>Deactivated Date</h6>
					                <cfif getcandidate.deactivated_date NEQ "">
                            <span class="font_style">#DateFormat(getcandidate.deactivated_date,'dd-mm-yyyy')#</span> 
                          <cfelse> 
                            <span class="font_style_NA">NA</span>
                          </cfif>   	
					         </div>
					       </div> 
			             </form>
					    </div>
					  </cfif>
					</div>
				</section>
			</div>
		</div>
	</div>
</cfoutput>

<!-- Vendor JS Files -->
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>
</body>
</html>