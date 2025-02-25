<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
  </script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/css/style.css">
    <title>RORIRI -Employee Management</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">

    <style>
        .pointer {
          cursor: pointer;
        }
      </style>  
    <!-- Template Main CSS File -->
        <!--- <link href="../assets/css/style.css" rel="stylesheet"> --->
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">

</head>
<style type="text/css">
  .apply_button{
    background: #7d66e3;
    border:0;
    padding:10px 24px;
    color:#fff;
    transition:0.4s;
    border-radius:4px;
  }
  .history_button{
    background: #7d66e3;
    border:0;
    padding:10px 24px;
    color:#fff;
    transition:0.4s;
    border-radius:4px;
    float: right;
  }
  .message{
    padding-left: 972px;
    padding-right: 350px;
    margin-right: 700px;
    
  }
  .alert{
    padding-left: 65px;
    margin-right: -19px;
    margin-left: 45px;

  }
  .custom-btn {
    background: #fff;
    color: #7d66e3;
    border: 1px solid #7d66e3;
    border-radius: 5px;
    text-decoration: none;
    width:150px;
    padding: 4px;
    justify-content:center;
  }
  .custom-btn:hover {
    background: #7d66e3;
    color: #fff;
  }
</style>
<body>
  <cfoutput>
    <cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
  <cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm"/>
  </cfif>
  <!--- header --->
   <cfset active_status="WFH">
    <cfif session.employee.role_id EQ 1 OR session.employee.role_id EQ 2 OR session.employee.role_id EQ 3>
       
        <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
  <cfelse>
        
        <cfinclude template="../includes/header/user_header.cfm" runonce="true">
  </cfif>
<!--- header ends --->

    <cfif structKeyExists(url, "wfhid")>
      <cfinvoke component="models.logsheet" method="getwfhHistory" id="#URL.wfhid#" returnvariable="wfh_list"/>
    </cfif>

    <cfif structKeyExists(url, "wfh_list" )>
      <cfinvoke  component="models.logsheet"method="update_WFH" id="#URL.wfhid#"returnvariable="applyy_WFH"/>
    </cfif>

  <main id="main">
    <section id="update" class="update">
      <div class="container">
        <div class="container-fluid" style="margin-left: 1000px;">
            <form action="employee_wfh_history.cfm?id=#url.id#" method="post">
              <!--- <button type="submit" class="btn btn-outline-white mx-3" style="font-size:small; vertical-align: middle; background-color: ##ee7843; Color:white;">View WFH History</button> --->
            </form>
          </div>
        <div class="row justify-content-between ">
          <div class="col-lg-5 d-flex align-items-center justify-content-center about-img">
              <img src="assets/img/about-img.svg" class="img-fluid" alt="" data-aos="zoom-in">
          </div>
          <div class="col-lg-6 pt-lg-0">
            <section id="contact" class="contact">
              <div class="container" data-aos="fade-up">
                <div class="section-title">
                    <h2>Work From Home Application Form</h2>
                    <p>Apply for WFH here!</p>
                </div>
                 <div class="row me-2 mb-3">
                    <div class="col-6"></div>
                    <div class="col-6 d-flex justify-content-end">
                      <cfif session.employee.role_id EQ 1>
                        <a class="btn btn-sm custom-btn me-2 " href="admin_employee_wfh_management.cfm" role="button">WFH Requests</a>
                      </cfif>
                        <a class="btn btn-sm custom-btn me-1 " href="employee_wfh_history.cfm?id=#url.id#" role="button">WFH History</a>

                    </div>
                </div>
                <!-- <center>
                  <div style="width:600px; height: 50px;">
                    <cfif structKeyExists(url, "w")> 
                      <div class="alert-success shadow" style="width:300px; height: 50px;" id="alert" role="alert">
                        <p style=" padding: 10px; text-align: center;">Application sent successfully</p>
                      </div>
                      <script>
                        console.log('alert')
                        function alert(){
                          console.log('alert1')
                          document.getElementById("alert").style.display = 'none'
                        }
                        setInterval(alert, 3000);
                      </script>
                    </cfif>
                  </div>
                </center> -->
                <div class="container">
                  <div class="col-lg-12 mt-lg-0 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
                  <form 
                    <cfif structKeyExists(url, "wfhid")> 
                      action="../controller/_logsheet.cfm?id=#url.id#&wfhid=#url.wfhid#"
                    <cfelse>
                      action="../controller/_logsheet.cfm?id=#url.id#"
                    </cfif> 
                      method="post" id="wfh_form" class="needs-validation" novalidate onsubmit="return validateLeave()"> 

                      <div class="row">
                          <input type="hidden" name="WFH_hidden">
                        <div class="col-lg-3">
                          <label style="font-size:small;" class="p-2">From Date</label>
                          <cfset minday= dateFormat(dateAdd("d", -0, dateFormat(now())),"yyyy-mm-dd")>
                          <!--- <cfset maxday = dateTimeFormat(dateAdd("d", 6, now()), "yyyy-mm-dd HH:nn")> --->
                          <input style="font-size:small;" type="date" min="#minday#" class="form-control" id="WFHfromdate" name="WFHfromdate" required <cfif structKeyExists(url, "wfhid")> value="#dateFormat(wfh_list.start_date,'yyyy-mm-dd')#"</cfif> />
                          
                          <div class="invalid-feedback">From Date is required.</div>
                        </div>
                        <div class="col-lg-3">
                          <label style="font-size:small;" class="p-2">From Session</label>
                          <select style="font-size:small;" class="form-select" name="WFHstart_period" id="WFHstart_period" required>
                            <option value="" <cfif NOT structKeyExists(url, "id")>selected</cfif>>Session</option>
                            <option value="FN" <cfif structKeyExists(url, "wfhid")AND wfh_list.start_period EQ "FN">selected </cfif>>FN</option>
                            <option value="AN"<cfif structKeyExists(url, "wfhid")AND wfh_list.start_period EQ "AN">selected </cfif>>AN</option>
                          </select>
                          <div class="invalid-feedback">From Session is required.</div>
                        </div>
                        <div class="col-lg-3">
                          <label style="font-size:small;" class="p-2">To Date</label>
                            <cfset minday= dateFormat(dateAdd("d", -0, dateFormat(now())),"yyyy-mm-dd")>
                          <input style="font-size:small;" type="date" min="#minday#" class="form-control" id="WFHtodate" name="WFHtodate" required <cfif structKeyExists(url, "wfhid")> value="#dateFormat(wfh_list.end_date,'yyyy-mm-dd')#"</cfif> />
  
                          <div class="invalid-feedback">To Date is required.</div>
                        </div>
                        <div class="col-lg-3">
                          <label style="font-size:small;" class="p-2">To Session</label>
                          <select style="font-size:small;" class="form-select" name="WFHend_period" id="WFHend_period" required>
                            <option value="" <cfif NOT structKeyExists(url, "id")>selected</cfif>>Session</option>
                            <option value="FN" <cfif structKeyExists(url, "wfhid")AND wfh_list.end_period EQ "FN">selected </cfif>>FN</option>
                            <option value="AN" <cfif structKeyExists(url, "wfhid")AND wfh_list.end_period EQ "AN">selected </cfif>>AN</option>
                          </select>
                          <div class="invalid-feedback">To Session is required.</div>
                        </div>
                      </div>
                      <br>
                       <p id="errorMessage" style="color: red;" class="mx-4"></p>

                        <div class="row mt-2">
                        <div class="col-lg-12">
                          <label for="WFHreason" style="font-size:small;" class="p-2">Reason</label>
                          <textarea style="font-size:small;" name="WFHreason" id="WFHreason" class="form-control" cols="12" rows="2" required><cfif structKeyExists(url, "wfhid")>#wfh_list.reason#</cfif></textarea>
                          <div class="invalid-feedback">Reason field is required.</div>
                        </div>
                      </div>
                      <br>
                      <div class="mt-3">
                        <div class="text-center">
                          <button style="font-size:small;" id="submitButton" type="submit"  class="apply_button"><cfif structKeyExists(URL, "wfhid")>Update<cfelse>Apply</cfif></button>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </section>
          </div>
        </div>
      </div>
      <cfif structKeyExists(url, "success") AND url.success EQ "true">
      <div id="liveAlertPlaceholder" class="message mx-3">
      <div class="alert alert-success" role="alert">
       "Your WFH request has been successfully submitted!"
      </div>
    </div>
  </cfif>
    </section>
  </main>
</cfoutput>

<!--- <script>

  function formSubmit(){
    document.getElementById("submitButton").disabled=true;
    document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
    document.getElementById("submitButton").innerHTML="Sending, please wait...";
    document.getElementById("wfh_form").submit();

  }
  </script> --->

 <script>
  (() => {
  'use strict'


  const forms = document.querySelectorAll('.needs-validation')

  // Loop over them and prevent submission
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
      }

      form.classList.add('was-validated')
    }, false)
  })
})()
</script>
<script>
     // If the alert is shown (based on server-side response), fade it out after 3 seconds
    document.addEventListener('DOMContentLoaded', function() {
        var alertPlaceholder = document.getElementById('liveAlertPlaceholder');
        console.log(alertPlaceholder);
        if (alertPlaceholder) {
            // Set timeout for 3 seconds to fade out the alert slowly
            setTimeout(function() {
                alertPlaceholder.style.transition = "opacity 1s";
                alertPlaceholder.style.opacity = 0;

                // After fadeout, hide the alert
                setTimeout(function() {
                    alertPlaceholder.style.display = "none"; // Hide the alert completely
                }, 1000); // 1 second fade-out delay
            }, 1000); // Show the alert for 3 seconds
        }
    });
</script>
<script>
        function validateLeave() {
            // Get the From Date and To Date as Date objects
            var fromDateValue = document.getElementById("WFHfromdate").value;
            var toDateValue = document.getElementById("WFHtodate").value;

            // Ensure both dates are selected
            if (toDateValue < fromDateValue) {
                document.getElementById("errorMessage").innerHTML = "To date cannot be earlier than From date. Please select a valid date.";
                 document.getElementById("WFHfromdate").value="";
                    document.getElementById("WFHtodate").value="";
      
                return false;
            }

            var fromDate = new Date(fromDateValue);
            var toDate = new Date(toDateValue);

            // Get the From Session (FN/AN) and To Session (FN/AN)
            var fromSession = document.getElementById("WFHstart_period").value;
            var toSession = document.getElementById("WFHend_period").value;
    
            // Check if the dates are the same and if the session logic is invalid
            if (fromDate.getTime() === toDate.getTime()) {
                // If From Session is AN and To Session is FN, it's an invalid selection on the same day
                if (fromSession === "AN" && toSession === "FN") {
                    document.getElementById("errorMessage").innerHTML = "You cannot apply for leave on the same day from AN to FN.";
                    document.getElementById("WFHstart_period").value="";
                    document.getElementById("WFHend_period").value="";

                    return false; 
                }
            }
            // Clear the error message if all conditions pass
            document.getElementById("errorMessage").innerHTML = "";
            return true;
        }

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
