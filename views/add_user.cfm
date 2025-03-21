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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  
    <style>
    #output.image-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-gap: 30px; /* Optional: Add some spacing between images */
    }
      .pointer {
        cursor: pointer;
      }
      .custom-btn {
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
       .custom-btn:hover {
          background: #7d66e3;
          color: #fff;
      }
    </style>
    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
  </head>
     <!--- style="background-color:#f2f2f2;"  --->
    <body>
      <cfif NOT structKeyExists(session, "employee")>
          <cflocation url="logout.cfm">
      </cfif>
      <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
<!--- header --->
    <cfset active_status="employee_management">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
<!--- header ends --->
<cfoutput>

  <cfinvoke component="models.employee" method="getDesignation" returnvariable="designation">
  <cfinvoke component="models.employee" method="getrole" returnvariable="roles"/>
      <div class="container d-flex align-items-center justify-content-between" style="margin-top:100px;">
        <div class="row">
          <div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-5">
          <section id="contact" class="contact">
            <div data-aos="fade-up">
              <div class="section-title">
                  <h2 style="font-size: 24px;font-weight: 1000;padding-bottom: 0;line-height: 1px;margin-bottom: 15px;color: ##b3a6ed;">Employee Management</h2>
                  <p>Registration Form</p>
              </div>
            </div><div class="row mb-3">
              <div class="col-6"></div>
              <div class="col-6 d-flex justify-content-end">
                <a class="custom-btn btn-sm me-2" href="all_employee_details.cfm" role="button">Employee List</a>
                <!--- <a class="custom-btn btn-sm me-2" href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&employee=&today" role="button">Timesheet</a> --->
                <!--- <a class="custom-btn btn-sm me-2" href="admin_weeklyreport_listing.cfm?emp_id=&year=&month=&FSdate=#dateFormat(dateAdd('d', -5, now()), 'yyyy-mm-dd')#&FEdate=#dateFormat(now(), 'yyyy-mm-dd')#" role="button">Log Sheet</a> --->
                <!--- <form action="../views/resigned_employee_list.cfm" method="post"> --->
                <!--- <div style="margin-left: 53%; margin-top:-5%" class="mb-5 pb-5"> --->
                  <a class="custom-btn btn-sm me-1" type="submit" href="resigned_employee_list.cfm">Resigned Employees</a>
                <!--- </div> --->
              <!--- </form>  --->
              </div>
            </div>
             <div class="shadow card px-5 py-4 m-1">
          <div class="col-lg-12 mt-7 mt-lg-0 d-flex align-items-stretch" id="section1"  data-aos-delay="200">
            <form action="../controller/_employee.cfm?regSucess=1&r_id" enctype="multipart/form-data" method="post" name="empRegForm" role="form" onsubmit="check()">
              <div class="mb-2 me-5 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                  <label>EMPLOYEE REGISTRATION FORM</label>
              </div>
              <hr>
              <div class="card shadow p-3 mb-5 bg-white rounded">
                <h4 class="card-title m-4" style="color:##7d66e3;">Personal Details</h4>
                <div class="row mx-4">
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">First Name</label>
                    <input style="font-size: small;" type="text" name="Fname" onfocusout="validfname()" class="form-control" id="Fname" placeholder="First Name" required>
                    <span class="error" id="firsterror" style="color:red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Last Name</label>
                    <input style="font-size: small;" type="text" name="Lname" onfocusout="validlname()" class="form-control" id="Lname" placeholder="Last Name" required>
                    <span class="error" id="lasterror" style="color:red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Mobile Number</label>
                    <input style="font-size: small;" type="Number" class="form-control" name="mbnum" id="mbnum" placeholder="Mobile Number" required onfocusout="validphn()">
                    <span id="mberror" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Emergency Contact Number</label>
                    <input style="font-size: small;" type="Number" class="form-control" name="emnum" id="emnum" placeholder="Emerrgency Contact Number" required onfocusout="validem()">
                    <span id="emerror" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Email</label>
                    <input style="font-size: small;" type="email" class="form-control" name="email" id="email" onfocusout="vaidemail()" placeholder="Email Address" required>
                    <span id="emailerror" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Date of Birth</label>
                    <input style="font-size: small;" type="date" class="form-control" name="DOB" id="DOB" onfocusout="validdate()" placeholder="Date of Birth" required>
                    <span id="DOBerror" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3">
                    <label style="font-size: small;" for="name">Father's Name</label>
                    <input style="font-size: small;" type="text" class="form-control" name="fathername" id="fathername" placeholder="Father's Name" onfocusout="validfathername()" required>
                    <span id="fathererror" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-md-4 p-3">
                    <label style="font-size: small;" for="start_date">Marital Status</label>
                    <select style="font-size: small;" class="form-select" data-style="btn-white col-lg-2 p-3" name="empMrgStatus" id="empMrgStatus">
                      <option value="">Please select</option>
                        <option value="Single">Single</option>
                        <option value="Married">Married</option>
                    </select>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group my-3">
                      <label style="font-size: small;" for="name">Permanent Address</label>
                      <textarea style="font-size: small;" class="form-control" name="p_address" id="p_address" rows="1"  required></textarea>
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group my-3">
                      <label style="font-size: small;" for="name">Current Address</label>
                      <textarea style="font-size: small;" class="form-control" name="c_address" id="c_address" rows="1" required></textarea>
                      <div class="d-flex justify-content-start align-items-center">
                        <input type="checkbox" id="c1" name="c1" onchange="checkbox()"> &nbsp;
                        <label for="c1" style="font-size: small;">Same as Permanent Address</label>
                      </div>
                    </div>
                  </div>
                  <div class=" col-lg-4">
                    <div class="form-group my-3">
                      <label style="font-size: small;" for="file">Upload Image</label>
                        <input style="font-size: small;" type="file" class="form-control" name="file" id="file" accept="image/*">
                    </div>
                  </div>  
                  
                </div>
              </div>
              <br>
              <div class="card shadow p-3 mb-5 bg-white rounded">
                <h4 class="card-title m-4" style="color:##7d66e3;">KYC Details</h4>
                <div class="row mx-4">             
                  <div class="form-group col-lg-4">
                    <label style="font-size: small;" for="name">Aadhaar Number</label>
                    <input style="font-size: small;" type="text" class="form-control" name="aadhaarNum" id="aadhaarNum" placeholder="Aadhaar Number" required onchange="validaAdhaar()">
                    <span id="lblError" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-lg-4">
                    <label  style="font-size: small;"for="name">PAN Number</label>
                    <input style="font-size: small;" type="text" class="form-control" name="panNum" id="panNum" placeholder="PAN Number" onchange="validPan()">
                    <span class="error" id="panerror" style="color:red;"></span>
                  </div>
                  <div class="form-group col-lg-4">
                    <label style="font-size: small;" for="file">Upload Files</label>
                    <input style="font-size: small;" type="file" class="form-control" name="documents" id="documents" multiple="multiple" accept=".pdf, .doc, .docx">
                     
                  </div>
                  <div class="form-group col-lg-4 p-3 my-3">
                    <label style="font-size: small;" for="name">Passport Number</label>
                    <input style="font-size: small;" type="text" class="form-control" name="passNum" id="passNum" placeholder="Passport Number" onchange="validpass()">
                    <span class="error" id="passerror" style="color:red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3 my-3">
                    <label style="font-size: small;" for="name">NPS Account Number</label>
                    <input style="font-size: small;" type="text" class="form-control" name="npsNum" id="npsNum" placeholder="NPS Accout Number" onchange="validnps()">
                    <span class="error" id="npserror" style="color:red;"></span>
                  </div>
                  <div class="form-group col-lg-4 p-3 my-3">
                    <label style="font-size: small;" for="name">PF Account Number</label>
                    <input style="font-size: small;" type="text" class="form-control" name="pfNum" id="pfNum" placeholder="PF Account Number" onchange="validpf()">
                    <span class="error" id="pferror" style="color:red;"></span>
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
                    <select style="font-size: small;" class="form-select" onchange="validDesignation()" data-style="btn-light col-md-4 p-3" name="empDesg" id="empDesg" required>
                      <option class="dropdown-item" value="">Choose Designation</option>
                      <cfloop query="designation">
                        <option class="dropdown-item" value="#designation.id#">#designation.designation#</option>
                      </cfloop>
                    </select>
                    <span id="empDesgerror" class="error" style="color: red;"></span>
                  </div>
                  <div class="form-group col-lg-6 p-3">
                    <label style="font-size: small;" for="start_date">Role</label>
                    <select style="font-size: small;" class="form-select" onchange="validRole()" name="empRoleid" id="empRoleid">
                      <option class="dropdown-item" value="">Select Role</option>
                      <cfloop query="roles">
                        <option class="dropdown-item" value="#roles.id#">#roles.role#</option>
                      </cfloop>
                    </select>
                    <span id="empRolegerror" class="error" style="color: red;"></span>
                  </div>
              </div>
              <div class="row mx-4">
                  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="joining_date">Date of Joining</label>
                      <input style="font-size: small;"  type="date" name="joining_date" class="form-control rounded border" id="joining_date">
                      <!--- <span class="error" id="joining_dateerror" style="color:red;"></span> --->
                  </div>
                  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="relieving_date">Relieving Date</label>
                      <input style="font-size: small;" type="date" name="relieving_date" class="form-control rounded border" id="relieving_date">
                      <!--- <span class="error" id="relieving_dateerror" style="color:red;"></span> --->
                  </div>
              </div>
               <div class="row mx-4">
                  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="employee_id">Employee Id</label>
                      <input style="font-size: small;"  type="text" name="employee_id" class="form-control rounded border" id="employee_id" onchange="validlEmployeeid()">
                      <!--- <span class="error" id="employee_iderror" style="color:red;"></span> --->
                  </div>
                 <!---  <div class="form-group col-lg-6 p-3">
                      <label style="font-size: small;" for="stime">Relieving Date</label>
                      <input style="font-size: small;" type="date" name="relieving_date" class="form-control rounded border" id="relieving_date">
                  </div> --->
              </div>
            </div>
              <div class="form-group mt-3">
                <div class="text-center"><button style="background: ##7d66e3;border: 0;padding: 10px 24px;color: ##fff;transition: 0.4s;border-radius: 4px;" type="submit" onclick="return finalcheck()" id="submitButton" class="btn">Submit</button></div>
              </div>
            </form>
            </div>
          </div>
        </div>
      </div>
    </section>
</cfoutput>

  <script>
  function check(){
    document.getElementById("submitButton").disabled=true;
    document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
    document.getElementById("submitButton").innerHTML="Sending, please wait...";
  }
  </script>

    <script>
      function validaAdhaar(){
            var aadhaar = document.getElementById("aadhaarNum").value;
            var lblError = document.getElementById("lblError");
            lblError.innerHTML = "";
            var expr = /^([0-9]{4}[0-9]{4}[0-9]{4}$)|([0-9]{4}\s[0-9]{4}\s[0-9]{4}$)|([0-9]{4}-[0-9]{4}-[0-9]{4}$)/;
            if (!expr.test(aadhaar)) {
                lblError.innerHTML = "*Invalid Format";
            }
        }

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

      function validPan() {
        var pan = document.getElementById("panNum").value;
        var panerror = document.getElementById("panerror");
          panerror.innerHTML ="";
          var regexp = /^([A-Z]{5}[0-9]{4}[A-Z]{1})/;
          if (!regexp.test(pan)) {
             panerror.innerHTML ="*Please enter valid credentials";
          }
      }
      function validpass() {
        var pass = document.getElementById("passNum").value;
        var passerror = document.getElementById("passerror");
        passerror.innerHTML="";
        var regexpp = /(^[A-Z]{1}-[0-9]{7}$)/;
        if (!regexpp.test(pass)){
          passerror.innerHTML="*Please enter valid credentials";
        }
      }
      function validnps() {
        var nps = document.getElementById("npsNum").value;
        var npserror = document.getElementById("npserror");
        npserror.innerHTML = "";
        var regexnp = /(^[0-9]{8}[R]{1}[A-HJ-NP-TV-Z]{1}$)/;
        if(!regexnp.test(nps)){
          npserror.innerHTML = "*Please enter valid credentials";
        }
      }
      function validpf() {
        var pf = document.getElementById("pfNum").value;
        var pferror = document.getElementById("pferror");
        pferror.innerHTML = "";
        var regexpf = /(^[A-Z]{2}[\s\/]?[A-Z]{3}[\s\/]?[0-9]{7}[\s\/]?[0-9]{3}[\s\/]?[0-9]{7}$)/;
        if(!regexpf.test(pf)){
          pferror.innerHTML = "*Please enter valid credentials";
        }
      }

      function validphn() {
        var mobile = document.getElementById("mbnum").value;
        var mberror = document.getElementById("mberror");
        mberror.innerHTML = "";
        // var regexmb = /(\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+)|\d{5}([- ]*)\d{6}/;
        var regexmb = /^[0-9]{10,10}$/;
        if(!regexmb.test(mobile)){
          mberror.innerHTML = "*Please enter valid number";
        }
      }
      function validem() {
        var em = document.getElementById("emnum").value;
        var emerror = document.getElementById("emerror");
        emerror.innerHTML = "";
        // var regexem = /(\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+)|\d{5}([- ]*)\d{6}/;
        var regexem = /^[0-9]{10,10}$/;
        if(!regexem.test(em)){
          emerror.innerHTML = "*Please enter valid credentials";
        }
      }
      function finalcheck(){
        var firstName = document.getElementById("Fname").value;
        var lastName = document.getElementById("Lname").value;
        var mobile= document.getElementById("mbnum").value;
        var emnum = document.getElementById("emnum").value;
        var fathername = document.getElementById("fathername").value;
        var empDesg = document.getElementById("empDesg").value;
        var empRoleid = document.getElementById("empRoleid").value;
        var aadhaarNum = document.getElementById("aadhaarNum").value;
        var aadharReg = /^([0-9]{4}[0-9]{4}[0-9]{4}$)|([0-9]{4}\s[0-9]{4}\s[0-9]{4}$)|([0-9]{4}-[0-9]{4}-[0-9]{4}$)/;
        var mobileReg = /^[0-9]{10,10}$/;
        var NameReg = /^[a-zA-Z]+$/;
        var NameReg2 = /[a-zA-Z][a-zA-Z ]*/;
        if(firstName==""){
          document.getElementById("firsterror").innerHTML="*First Name is Required";
          document.getElementById("Fname").focus();
          return false;
        }
        else if(!NameReg.test(firstName)){
          document.getElementById("firsterror").innerHTML="*Invalid First Name";
          document.getElementById("Fname").focus();
          return false;
        }
        else if(lastName==""){
          document.getElementById("lasterror").innerHTML="*Last Name is Required";
          document.getElementById("Lname").focus();
          return false;
        }
        else if(!NameReg.test(lastName)){
          document.getElementById("lasterror").innerHTML="*Invalid Last Name";
          document.getElementById("Lname").focus();
          return false;
        }
        else if(!mobileReg.test(mobile)){
          document.getElementById("mberror").innerHTML="*Please enter valid number";
          document.getElementById("mbnum").focus();
          return false;
        }
        else if(!mobileReg.test(emnum)){
          document.getElementById("emerror").innerHTML="*Please enter valid number";
          document.getElementById("emnum").focus();
          return false;
        }
        else if(!NameReg2.test(fathername)){
          document.getElementById("fathererror").innerHTML="*Father's Name is Invalid";
          document.getElementById("fathername").focus();
          return false;
        }
        else if(empDesg==""){
          document.getElementById("empDesgerror").innerHTML="*This is Required field";
          document.getElementById("empDesg").focus();
          return false;
        }
        else if(empRoleid==""){
          document.getElementById("empRoleerror").innerHTML="*This is Required field";
          document.getElementById("empRoleid").focus();
          return false;
        }
        else if(!aadharReg.test(aadhaarNum)){
          document.getElementById("lblError").innerHTML="*Invalid Aadhar Number";
          document.getElementById("aadhaarNum").focus();
          return false;
        }
        else{
          return true;
        }
      }
      function validfname(){
        var firstName = document.getElementById("Fname").value;
        var NameReg = /^[a-zA-Z]+$/;
        if(firstName==""){
          document.getElementById("firsterror").innerHTML="*First Name is Required";
        }
        else if(!NameReg.test(firstName)){
          document.getElementById("firsterror").innerHTML="*Invalid First Name";
        }
        else{
          document.getElementById("firsterror").innerHTML="";
        }
      }
      function validlname(){
        var lastName = document.getElementById("Lname").value;
        var NameReg = /^[a-zA-Z]+$/;
        if(lastName==""){
          document.getElementById("lasterror").innerHTML="*Last Name is Required";
        }
        else if(!NameReg.test(lastName)){
          document.getElementById("lasterror").innerHTML="*Invalid Last Name";
        }
        else{
          document.getElementById("lasterror").innerHTML="";
        }
      }
      function validfathername(){
        console.log('test');
        var fathername = document.getElementById("fathername").value;
        var NameReg = /^[a-zA-Z]+$/;
        if(fathername==""){
          document.getElementById("fathererror").innerHTML="*Father's Name is Required";
        }
        else if(!NameReg.test(fathername)){
          document.getElementById("fathererror").innerHTML="*Father's Name is Invalid";
        }
        else{
          document.getElementById("fathererror").innerHTML="";
        }
      }
      function vaidemail(){
        var email = document.getElementById("email").value;
        var emailReg = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        if(email==""){
          document.getElementById("emailerror").innerHTML="*Email is Required";
        }
        else if(!emailReg.test(email)){
          document.getElementById("emailerror").innerHTML="*Invalid Email";
        }
        else{
          document.getElementById("emailerror").innerHTML="";
        }
      }
      function validdate(){
        var Dob = document.getElementById("DOB").value;
        if(Dob==""){
          document.getElementById("DOBerror").innerHTML="This is Required field";
        }
        else{
          document.getElementById("DOBerror").innerHTML="";
        }
      }
      function validDesignation(){
        var empDesg = document.getElementById("empDesg").value;
        if(empDesg==""){
          document.getElementById("empDesgerror").innerHTML="*This is Required field";
        }else{
          document.getElementById("empDesgerror").innerHTML="";
        }
      }
      function validRole(){
        var empRoleid = document.getElementById("empDesg").value;
        if(empRoleid==""){
          document.getElementById("empRolegerror").innerHTML="*This is Required field";
        }else{
          document.getElementById("empRolegerror").innerHTML="";
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