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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
      .pointer {
        cursor: pointer;
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
<cfinvoke component="models.employee" method="getDesignation" returnvariable="designation">
<cfinvoke component="models.employee" method="getrole" returnvariable="roles"/>
<!--- header --->
  <cfif session.EMPLOYEE.ROLE_ID EQ 1>
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
  <cfelse>
    <cfinclude template="../includes/header/user_header.cfm" runonce="true">
  </cfif>
<!--- header ends --->
<cfoutput>

      <div class="container d-flex align-items-center justify-content-between" style="margin-top:100px;">
        <div class="row">
          <div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-5">
          <section id="contact" class="contact">
            <div class="container" data-aos="fade-up">
              <div class="section-title">
                  <h2 style="font-size: 24px;font-weight: 1000;padding-bottom: 0;line-height: 1px;margin-bottom: 15px;color: ##b3a6ed;">Profile</h2>
                  <p>Employee Details</p>
              </div>
            </div>

            <cfif structKeyExists(url, "id")>
              <cfinvoke component="models.employee" method="emp_profile" user_id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="getprofile"/>
            </cfif>
            <!--- <cfdump var="#getprofile#"> --->
          <div class="col-lg-12 mt-7 mt-lg-0 d-flex align-items-stretch"  data-aos-delay="200">
            <form action="../controller/_employee.cfm?id=#url.id#" enctype="multipart/form-data" method="post" onsubmit="return check()">
              <div class="card shadow p-3 mb-5 bg-white rounded">
                <h4 class="card-title m-4" style="color:##7d66e3;">Personal Details</h4>
                <div class="row mx-4">
                  <input type="hidden" name="u_profile">
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">First Name</label>
                    <input style="font-size: small;" type="text" name="fname" id="fname" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.first_name#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Last Name</label>
                    <input style="font-size: small;" type="text" name="Lname" id="Lname" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.last_name#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Mobile Number</label>
                    <input style="font-size: small;" type="text" name="mbnum" id="mbnum" class="form-control" maxlength="10" <cfif structKeyExists(url, "id")>value="#getprofile.mobile#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Emergency Contact Number</label>
                    <input style="font-size: small;" type="number" name="emnum" id="emnum" class="form-control" maxlength="10"<cfif structKeyExists(url, "id")>value="#getprofile.emergency_contact#"</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Email</label>
                    <input style="font-size: small;" type="text" name="email" id="email" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.email#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="DOB">Date of Birth</label>
                    <input style="font-size: small;" type="date" class="form-control" name="DOB" id="DOB" <cfif structKeyExists(url, "id")> value="#dateFormat(getprofile.DOB,'yyyy-mm-dd')#"</cfif>>
                  </div>
                
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Father's Name</label>
                    <input style="font-size: small;" type="text" name="fathername" id="fathername" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.name_of_father#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                  </div>
                  <div class="form-group col-md-4 p-3">
                    <label style="font-size: small;" for="start_date">Marital Status</label>
                    <!--- <input style="font-size: small;" type="text" name="empMrgStatus" id="empMrgStatus" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.marital_status#"</cfif>> --->
                    <select  class="select form-control" name="empMrgStatus" id="empMrgStatus">
                      <option class="form-select" style="font-size: small;" value="">Please select</option>
                        <option class="form-select" style="font-size: small;" value="Single"<cfif structKeyExists(url, "id") AND getprofile.marital_status EQ "Single">selected</cfif>>Single</option>
                        <option class="form-select" style="font-size: small;" value="Married" <cfif structKeyExists(url, "id") AND getprofile.marital_status EQ "Married">selected</cfif>>Married</option>
                    </select>
                  </div>
                  <div class="col-lg-4 col-lg-4 p-3">
                    <label style="font-size: small;" for="name"> Permanent Address</label>
                    <textarea style="font-size: small;" name="p_address" id="p_address" class="form-control" rows="1"><cfif structKeyExists(url, "id")>#getprofile.permanent_address#</cfif></textarea>
                  </div>
                  <div class="col-lg-4 col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Current Address</label>
                    <textarea style="font-size: small;" name="c_address" id="c_address" class="form-control" rows="1" ><cfif structKeyExists(url, "id")>#getprofile.current_address#</cfif></textarea>
                    <div class="d-flex justify-content-start align-items-center">
                      <input type="checkbox" id="c1" name="c1" onchange="checkbox()"> &nbsp;
                      <label for="c1" style="font-size: small;">Same as Permanent Address</label>
                    </div>
                  </div>
                  <div class=" col-lg-4 form-group my-3">
                    <div class="row">
                      <div class="col-lg-10">
                        <label style="font-size: small;" for="file">Upload Image</label>
                        <input style="font-size: small;" type="file" class="form-control" name="file" id="file" accept="image/*">
                      </div>
                      <div class="col-lg-2 form-group my-4">
                        <button type="button" class="btn btn-sm btn-primary ms-3" data-bs-toggle="modal" data-bs-target="##myModal" > <i class="fa fa-eye"></i>
                        </button>
                      </div>
                   </div>
                </div>
              </div>
              <cfif structKeyExists(url,"id")>
                <cfset decryptedId = decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES', 'HEX')>
                <cfdirectory action="list" directory="#expandPath("../assets/kyc_documents")#/#decryptedId#/employee_photo" recurse="false" name="myList">
                <div>
                  <cfset imagefiles = queryFilter(myList, function(obj){
                     return listFindNoCase(obj.name,"jpg",".")||listFindNoCase(obj.name,"jpeg",".")||listFindNoCase(obj.name,"png",".")||listFindNoCase(obj.name,"gif",".") ;
                  })>
                <div class="modal" id="myModal">
                  <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                      <!-- Modal Header -->
                      <div class="d-flex justify-content-between mt-4">
                        <div></div>
                        <div>
                          <h5 class="modal-title">Uploaded Images</h5>
                        </div>
                        <div>
                          <button type="button" class="btn-close float-end mx-3" data-bs-dismiss="modal"></button>
                        </div>
                      </div>
                      <!-- Modal body -->
                      <div class="modal-body">
                        <div class="row m-3">
                        <cfloop query="imagefiles">
                          <div class="col-4 my-3">
                          <div class="card">
                            <img class="card-img-top" src="../assets/kyc_documents/#decryptedId#/employee_photo/#imagefiles.name#" style="max-width:100px;">
                          </div>
                        </div>
                          </cfloop>
                      </div>
                      </div>
                    </div>
                  </div>
                </div>
             </cfif>
            </div>
            </div>
              <br>
              <div class="card shadow p-3 mb-5 bg-white rounded">
                <h4 class="card-title m-4" style="color:##7d66e3;">KYC Details</h4>
                <div class="row mx-4">             
                  <div class="form-group col-lg-4">
                    <label style="font-size: small;" for="name">Aadhaar Number</label>
                    <input style="font-size: small;" type="text" name="aadhaarNum" id="aadhaarNum" class="form-control"<cfif structKeyExists(url, "id")> value="#getprofile.aadhaar_number#"</cfif> <cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                  </div>
                  <div class="form-group col-lg-4">
                    <label style="font-size: small;" for="name">PAN Number</label>
                    <input style="font-size: small;" type="text" name="panNum" id="panNum" class="form-control"<cfif structKeyExists(url, "id")>value="#getprofile.pan_number#"</cfif>>
                  </div>
                  <div class="form-group col-lg-4">
                    <label style="font-size: small;" for="file">Upload Files</label>
                      <input style="font-size: small;" type="file" class="form-control" name="documents" id="documents" multiple="multiple" accept=".pdf, .doc, .docx">
                      <cfif structKeyExists(url,"id")>
                        <cfset decryptedId = decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES', 'HEX')>
                        <cfdirectory action="list" directory="#expandPath("../assets/kyc_documents")#/#decryptedId#/kyc_files" recurse="false" name="myList">
                          <cfset pdffiles = queryFilter(myList, function(obj){
                            return listFindNoCase(obj.name,"pdf",".")||listFindNoCase(obj.name,"doc",".")||listFindNoCase(obj.name,"docx",".");
                         })>
                    <cfset k=1>
                    <cfif structKeyExists(url,"id")>
                      <cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID EQ "1">
                        <cfloop query="pdffiles">
                            <cfset pdfdate = pdffiles.name>
                            <cfset sl = k>
                            <cfset k++>
                            <cfset combinedValue = sl & "." & pdfdate>
                            <div>
                                <a href="../assets/kyc_documents/#decryptedId#/kyc_files/#pdffiles.name#" style="font-size: 9px;" target="blank">#combinedValue#</a>
                                <button style="border: 0;padding: 1px 0px;background-color: ##fcfffd;border-radius: 4px;" id="conform" onclick="showConfirmation(event,'#decryptedid#','#pdffiles.name#')" ><i class="fa fa-trash-o mx-3" style="color: ##7d66e3;"></i></button>
                            </div>
                        </cfloop>
                      <cfelse>
                        <cfloop query="pdffiles">
                          <cfset pdfdate = pdffiles.name>
                          <cfset sl = k>
                          <cfset k++>
                          <cfset combinedValue = sl & "." & pdfdate>
                          <div>
                              <a href="../assets/kyc_documents/#decryptedId#/kyc_files/#pdffiles.name#" style="font-size: 9px;" target="blank">#combinedValue#</a>
                              
                          </div>
                        </cfloop>
                      </cfif> 
                    </cfif>
                  </cfif>  
                  </div>
                  <div class="form-group col-lg-4 p-3 my-3">
                    <label style="font-size: small;" for="name">Passport Number</label>
                    <input style="font-size: small;" type="text" name="passNum" id="passNum" class="form-control"<cfif structKeyExists(url, "id")>value="#getprofile.passport_number#"</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3 my-3">
                    <label style="font-size: small;" for="name">NPS Account Number</label>
                    <input style="font-size: small;" type="text" name="npsNum" id="npsNum" class="form-control"<cfif structKeyExists(url, "id")>value="#getprofile.nps_acct_number#"</cfif>>
                  </div>
                  <div class="form-group col-lg-4 p-3 my-3">
                    <label style="font-size: small;" for="name">PF Account Number</label>
                    <input style="font-size: small;" type="text" name="pfNum" id="pfNum" class="form-control"<cfif structKeyExists(url, "id")>value="#getprofile.pf_acct_number#"</cfif>>
                  </div>
                </div>
              </div>
            </div>
                <br>
            <div class="card shadow p-3 mb-5 bg-white rounded">
              <h4 class="card-title m-4" style="color:##7d66e3;">Employment Details</h4>
              <div class="row mx-4">
                <div class="form-group col-lg-6 p-3">
                    <label style="font-size: small;" for="name">Designation</label>
                    <!--- <input style="font-size: small;"  type="text" name="empDesg" id="empDesg" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.designation#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>> --->
                    <select style="font-size:small;"  class="select form-select" name="empDesg" id="empDesg" required <cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                      <option class="form-select" style="font-size: small;" value="">Choose Designation</option>
                        <cfloop query="designation">
                        <option class="form-select" style="font-size: small;" value="#designation.id#" <cfif structKeyExists(url, "id") AND getprofile.designation EQ designation.id>selected</cfif>>#designation.designation#</option>
                      </cfloop>
                    </select>
                  </div>
                  <div class="form-group col-lg-6 p-3">
                    <label style="font-size: small;" for="start_date">Role</label>
                    <!--- <input style="font-size: small;" type="text" name="empRoleid" id="empRoleid" class="form-control" <cfif structKeyExists(url, "id")>value="#getprofile.role#"</cfif><cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>> --->
                    <select style="font-size:small;" class="select form-select" name="empRoleid" id="empRoleid" <cfif structKeyExists(session, "EMPLOYEE") AND session.EMPLOYEE.ROLE_ID NEQ "1">disabled</cfif>>
                      <option class="form-select" style="font-size: small;" value="">Select Role</option>
                        <cfloop query="roles">
                        <option class="form-select" style="font-size: small;" value="#roles.id#" <cfif structKeyExists(url, "id") AND getprofile.role_id EQ roles.id>selected</cfif>>#roles.role#</option>
                      </cfloop>
                    </select>
                  </div>
              </div>
              <div class="row mx-4">
                  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="stime">Date of Joining</label>
                      <input style="font-size: small;"  type="date" name="joining_date" class="form-control rounded border" id="joining_date" <cfif structKeyExists(url, "id")> value="#dateformat(getprofile.employee_joining_date, 'yyyy-mm-dd')#"</cfif>>
                  </div>
                  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="stime">Relieving Date</label>
                      <input style="font-size: small;" type="date" name="relieving_date" class="form-control rounded border" id="relieving_date" <cfif structKeyExists(url, "id")> value="#dateFormat(getprofile.employee_relieving_date, 'yyyy-mm-dd')#"</cfif>>
                  </div>
              </div>
              <cfif structKeyExists(url, "id")>
              <div class="row mx-4">
                  <div class="form-group col-lg-6 p-3">
                  </div>
                  <div class="form-group col-lg-6 p-3">
                      <input type="checkbox" id="employee_status" name="employee_status" <cfif getprofile.status EQ 0>checked</cfif>>
                      <label style="font-size: small;">Relieving status</label>
                  </div>
              </div>
            </cfif>
            <div class="row mx-4">
                  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="employee_id">Employee Id</label>
                      <input style="font-size: small;"  type="text" name="employee_id" class="form-control rounded border" id="employee_id" disabled <cfif structKeyExists(url, "id")>value="#getprofile.employee_id#"</cfif>>
                  </div>
                 <!---  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="stime">Relieving Date</label>
                      <input style="font-size: small;" type="date" name="relieving_date" class="form-control rounded border" id="relieving_date">
                  </div> --->
              </div>
            </div>
             <div class="form-group mt-3">
                  <div class="text-center"><button style="background: ##7d66e3;border: 0;padding: 10px 24px;color: ##fff;transition: 0.4s;border-radius: 4px;" type="submit" id="submitButton" class="btn">Update Profile</button></div>
                </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  </cfoutput>

  <script>
    function checkbox(){
          var checked=document.getElementById("c1").checked;
          var pAddress=document.getElementById("p_address").value;
          if(checked){
            document.getElementById("c_address").value=pAddress;
          }
          else{
            document.getElementById("c_address").value="";
          }
        }
  </script>

  <script>
    function check(){
      var statuschecked = document.getElementById("employee_status").checked;
     if (statuschecked) {
      var relivingdate = document.getElementById("relieving_date").value;
      if (relivingdate == "") {
        alert("Relieving Date must be filled");
        return false;
      }
     }
    document.getElementById("submitButton").disabled=true;
    document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
    document.getElementById("submitButton").innerHTML="Sending, please wait...";
     
    }
  </script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
 function showConfirmation(e, id, name) {
    e.preventDefault();
    var confirmation = confirm("Are you sure to delete this file?");

    if (confirmation) {
        $.ajax({
            url: "../models/employee.cfc",
            type: "post", 
            data: {
                method: "deletefiles",
                filename: name,
                folderid: id
            },
            success: function(res) {
                alert(res); 
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText); 
                alert("An error occurred while deleting the file.");
            }
        });
    }
}

</script>
<script>
  document.getElementById('documents').addEventListener('change', function() {
      var files = this.files;
      if (files.length > 4) {
          alert('Please Select up to 4 files and try again.');
          this.value = ''; 
      }
  });
</script>
 

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