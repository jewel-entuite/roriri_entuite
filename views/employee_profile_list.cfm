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
  	<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
  	<cfif NOT structKeyExists(session, "employee")>
      <cflocation url="logout.cfm">
  	</cfif>
  	<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
  	<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>

<!--- header --->
		<cfset active_status="profile">
    <cfinclude template="../includes/header/user_header.cfm" runonce="true"> 
<!--- header ends --->

	<cfoutput>
	<cfif structKeyExists(url, "id")>
  		<cfinvoke component="models.employee" method="emp_profile" user_id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="getprofile"/>
	</cfif>
	<style>
		h6{
			font-size: 15px;
			margin: 0px;
		}
		.font_style{
			color:##6f80a3;
			font-size: 15px;
			font-weight: bold;
		}
		.font_style_NA{
			color:red;
			font-size: 14px;
			font-weight: bold;
		}
	</style>
	<div class="px-1" style="margin-top:100px;">
        <div class="row">
          	<div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-4">
				<section id="contact" class="contact">
			            <div class="section-title">
						        <h2>Profile</h2>
						        <p>Employee Details</p>
						      </div>
			          <div class="col-lg-12 mt-7 mt-lg-0 d-flex align-items-stretch"  data-aos-delay="200">
						<div class="container">
							<div class="shadow card px-4">
								<div class="fw-bold mt-4" style="font-size: 0.9rem; color:##7d66e3;">
 	  							<label>EMPLOYEE DETAILS</label>
 								</div>
 								<hr>
							<div class="card shadow p-3 mb-5 bg-white rounded">
											<div class="d-flex justify-content-between align-items-center">
						            <h4 class="card-title m-4" style="color:##7d66e3;">Personal Details</h4>
						            <form name="editform" method="post" action="employee_profile.cfm?id=#url.id#">
										<cfif structKeyExists(getprofile, "id")>
											<cfdirectory action="list" directory="#expandPath("../assets/kyc_documents")#/#getprofile.id#/employee_photo" recurse="false" name="myList">
											<cfset imagefiles = queryFilter(myList, function(obj){
												return listFindNoCase(obj.name,"jpg",".") || listFindNoCase(obj.name,"jpeg",".") || listFindNoCase(obj.name,"png",".") || listFindNoCase(obj.name,"gif",".");
											})>
										
											<cfif imagefiles.recordCount gt 0>
												<cfloop query="imagefiles">
													<div>
														<img src="../assets/kyc_documents/#getprofile.id#/employee_photo/#imagefiles.name#" alt="Employee Photo" style="max-width: 100px;">
													</div>
												</cfloop>
											</cfif>
										</cfif>
										<br>
										<button class="float-end" style="background: ##7d66e3;border: 0; color: ##fff;border-radius: 4px;" type="submit" class="btn float-right" >
							            	<i class="bi bi-pencil-square"></i>
							            </button>
						          	</form>
					          	</div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>First Name</h6>
					                		<cfif getprofile.first_name NEQ "">
					                			<span class="font_style">#getprofile.first_name#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Last Name</h6>
					                		<cfif getprofile.last_name NEQ "">
					                			<span class="font_style">#getprofile.last_name#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Father's Name</h6>
					                		<cfif getprofile.name_of_father NEQ "">
					                			<span class="font_style">#getprofile.name_of_father#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					            </div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Phone Number</h6>
					                		<cfif getprofile.mobile NEQ "">
					                			<span class="font_style">#getprofile.mobile#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Emergency Contact Number</h6>
					                		<cfif getprofile.emergency_contact NEQ "">
					                			<span class="font_style">#getprofile.emergency_contact#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Email ID</h6>
					                		<cfif getprofile.email NEQ "">
					                			<span class="font_style">#getprofile.email#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					            </div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Marital Status</h6>
					                		<cfif getprofile.marital_status NEQ "">
					                			<span class="font_style">#getprofile.marital_status#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Designation</h6>
					                		<cfif getprofile.designation NEQ "">
					                			<span class="font_style">#getprofile.design#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Role</h6>
					                		<cfif getprofile.role NEQ "">
					                			<span class="font_style">#getprofile.role#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Joining Date</h6>
					                		<cfif getprofile.employee_joining_date NEQ "">
					                			<span class="font_style">#dateformat(getprofile.employee_joining_date, 'mmm-dd-yyyy')#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Relieving Date</h6>
					                		<cfif getprofile.employee_relieving_date NEQ "">
					                			<span class="font_style">#dateformat(getprofile.employee_relieving_date, 'mmm-dd-yyyy')#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>Date of Birth</h6>
					                		<cfif getprofile.DOB NEQ "">
					                			<span class="font_style">#dateformat(getprofile.DOB, 'mmm-dd-yyyy')#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					            </div>
					        </div>
					        <div class="card shadow p-3 mb-5 bg-white rounded">
					            <h4 class="card-title m-4" style="color:##7d66e3;">KYC Details</h4>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>Aadhaar Number</h6>
					                		<cfif getprofile.aadhaar_number NEQ "">
					                			<span class="font_style">#getprofile.aadhaar_number#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>PAN Number</h6>
					                		<cfif getprofile.pan_number NEQ "">
					                			<span class="font_style">#getprofile.pan_number#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
									<div class="col-lg-4 p-3">
					                	<h6>Passport Number</h6>
					                		<cfif getprofile.passport_number NEQ "">
					                			<span class="font_style">#getprofile.passport_number#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					            </div>
					            <div class="row mx-4">
					                <div class="col-lg-4 p-3">
					                	<h6>NPS Account Number</h6>
					                		<cfif getprofile.nps_acct_number NEQ "">
					                			<span class="font_style">#getprofile.nps_acct_number#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
					                <div class="col-lg-4 p-3">
					                	<h6>PF Account Number</h6>
					                		<cfif getprofile.pf_acct_number NEQ "">
					                			<span class="font_style">#getprofile.pf_acct_number#</span>
					                		<cfelse>
					                			<span class="font_style_NA">NA</span>
					                		</cfif>
					                </div>
									<div class="col-lg-4 p-3">
					                	<h6>Uploaded Documents</h6>
										<cfif structKeyExists(getprofile, "id")>
											<cfdirectory action="list" directory="#expandPath("../assets/kyc_documents")#/#getprofile.id#/kyc_files" recurse="false" name="myList">
											<cfset pdffiles = queryFilter(myList, function(obj){
												return listFindNoCase(obj.name,"pdf",".") || listFindNoCase(obj.name,"jpg",".") || listFindNoCase(obj.name,"jpeg",".") || listFindNoCase(obj.name,"png",".") || listFindNoCase(obj.name,"doc",".") || listFindNoCase(obj.name,"docx",".");
											})>
										
											<cfset k=1>
											<cfif pdffiles.recordCount gt 0>
												<cfloop query="pdffiles">
													<div>
														<a class="font_style" href="../assets/kyc_documents/#getprofile.id#/kyc_files/#pdffiles.name#" style="font-size: 9px;" target="blank">#pdffiles.name#</a>
													</div>
												</cfloop>
											<cfelse>
												<span class="font_style_NA">NA</span>
											</cfif>
										</cfif>
					                </div>
					            </div>
					        </div>
					        <div class="card shadow p-3 mb-5 bg-white rounded">
					          <h4 class="card-title m-4" style="color:##7d66e3;">Address</h4>
					          <div class="row mx-4"> 
					            <div class="col-lg-6">
					              <div class="my-3">
					                <h6 style="line-height:1.6">Permanent Address</h6>
					                	<cfif getprofile.permanent_address NEQ "">
				                			<span class="font_style" style="line-height:1.6;">#getprofile.permanent_address#</span>
				                		<cfelse>
				                			<span class="font_style_NA">NA</span>
				                		</cfif>
					              </div>
					            </div>
					            <div class="col-lg-6">
					              <div class="my-3">
					                <h6 style="line-height:1.6">Current Address</h6>
					                	<cfif getprofile.current_address NEQ "">
				                			<span class="font_style" style="line-height:1.6;">#getprofile.current_address#</span>
				                		<cfelse>
				                			<span class="font_style_NA">NA</span>
				                		</cfif>
					              </div>
					            </div>
					          </div>
					        </div>
			          </form>
					    </div>
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