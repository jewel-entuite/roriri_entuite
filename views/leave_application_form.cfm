<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js">
  </script>       
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
  </script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


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
  /*.hidden {
    display: none;
  }*/

  .message{
    padding-left: 972px;
    padding-right: 350px;
    /*margin-right: 900px;*/   
  }
  .alert{
    padding-left: 63px;
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

  <cfif structKeyExists(url, "leaveid" )>
    <cfinvoke component="models.logsheet" method="getleaves" id="#URL.leaveid#" returnvariable="getleave" />        
  </cfif> 

  <!--- header --->
    <cfif session.employee.role_id EQ 1 OR session.employee.role_id EQ 2 OR session.employee.role_id EQ 3>
         <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
  <cfelse>
          <cfset active_status="more">
          <cfinclude template="../includes/header/user_header.cfm" runonce="true">
  </cfif>
<!--- header ends --->

  <main id="main">
    <section id="update" class="update">
      <div class="container">
        <div class="container-fluid" style="margin-left: 1000px;">
            <form action="employee_leave_history.cfm?id=#url.id#"  enctype="multipart/form-data" method="post">
              <!--- <button type="submit" class="btn btn-outline-white mx-3" style="font-size:small; vertical-align: middle; background-color: ##ee7843; Color:white;">View Leave History</button> --->
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
                    <h2>Leave Application Form</h2>
                    <p>Apply for leave here!</p>
                </div>
                <div class="row mb-3 me-4">
                    <div class="col-6"></div>
                    <div class="col-6 d-flex justify-content-end">
                        <cfif session.employee.role_id EQ 1>
                          <a class="btn btn-sm me-2 custom-btn" href="admin_employee_leave_management.cfm?emp_id=&Sdate=&Edate=" role="button">Leave Requests</a>
                        </cfif>
                          <a class="btn btn-sm me-3 custom-btn" href="employee_leave_history.cfm?id=#url.id#" role="button">Leave History</a>
                    </div>
                </div>
                <div class="container">
                  <div class="col-lg-12 mt-lg-0 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
                    <form id="form1" method="post" class="needs-validation" novalidate onsubmit="return validateLeave(event)"
    <cfif structKeyExists(url, "leaveid")>
        action="../controller/_logsheet.cfm?id=#url.id#&leaveid=#url.leaveid#"
    <cfelse> 
        action="../controller/_logsheet.cfm?id=#url.id#"
    </cfif> >

    <div class="row">
        <!-- From Date Input -->
        <div class="col-lg-3">
            <label for="fromdate" style="font-size:small;" class="p-2">From Date</label>
            <cfset minday= dateFormat(dateAdd("d", -10, dateFormat(now())),"yyyy-mm-dd")>
            <input style="font-size:small;" type="date" min="#minday#" class="form-control" id="fromdate" name="fromdate" required
                <cfif structKeyExists(url, "leaveid")> value="#dateFormat(getleave.from_date,'yyyy-mm-dd')#" </cfif> />
            <div class="invalid-feedback">From Date is required.</div>
        </div>

        <!-- From Session Input -->
        <div class="col-lg-3">
            <cfif structKeyExists(url, "leaveid")>
                <input type="hidden" id="urlLeaveId" value="#url.leaveid#">
                <input type="hidden" id="urlId" value="#url.id#">
            <cfelse>
                <input type="hidden" id="urlId" value="#url.id#">
            </cfif>
            <label for="start_period" style="font-size:small;" class="p-2">From Session</label>
            <select style="font-size:small;" class="form-select" name="start_period" id="start_period" required>
                <option value="" <cfif NOT structKeyExists(url, "id")>selected</cfif>>Session</option>
                <option value="FN" <cfif structKeyExists(url, "leaveid") AND getleave.start_period EQ "FN">selected</cfif>>FN</option>
                <option value="AN" <cfif structKeyExists(url, "leaveid") AND getleave.start_period EQ "AN">selected</cfif>>AN</option>
            </select>
            <div class="invalid-feedback">From Session is required.</div>
        </div>

        <!-- To Date Input -->
        <div class="col-lg-3">
            <label for="todate" style="font-size:small;" class="p-2">To Date</label>
            <cfset minday= dateFormat(dateAdd("d", -10, dateFormat(now())),"yyyy-mm-dd")>
            <input style="font-size:small;" type="date" min="#minday#" class="form-control" id="todate" name="todate" required
                <cfif structKeyExists(url, "leaveid")> value="#dateFormat(getleave.to_date,'yyyy-mm-dd')#" </cfif> />
            <div class="invalid-feedback">To Date is required.</div>
        </div>

        <!-- To Session Input -->
        <div class="col-lg-3">
            <label for="end_period" style="font-size:small;" class="p-2">To Session</label>
            <select style="font-size:small;" class="form-select" name="end_period" id="end_period" required>
                <option value="" <cfif NOT structKeyExists(url, "id")>selected</cfif>>Session</option>
                <option value="FN" <cfif structKeyExists(url, "leaveid") AND getleave.end_period EQ "FN">selected</cfif>>FN</option>
                <option value="AN" <cfif structKeyExists(url, "leaveid") AND getleave.end_period EQ "AN">selected</cfif>>AN</option>
            </select>
            <div class="invalid-feedback">To Session is required.</div>
        </div>
    </div>
    <br>
    <p id="errorMessage" style="color: red;" class="mx-5"></p>
    
    <div class="row mt-2">
        <div class="col-lg-12">
            <label for="reason" style="font-size:small;" class="p-2">Reason</label>
            <textarea style="font-size:small;" name="reason" id="reason" class="form-control" cols="12" rows="2" required><cfif structKeyExists(url, "leaveid")>#getleave.Reason#</cfif></textarea>
            <div class="invalid-feedback">Reason field is required.</div>
        </div>
    </div>

    <div class="mt-3">
        <!-- Submit Button -->
        <div class="text-center">
            <button style="font-size:small;" type="submit" id="submitButton"  class="apply_button">
                <cfif structKeyExists(URL, "leaveid")>Update<cfelse>Apply</cfif>
            </button>
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
            <div class="alert alert-success " role="alert">
                Your leave application has been successfully submitted!
            </div>
        </div>
    </cfif>
</div>
        
    </section>
  </main>
</cfoutput>
<script>
  (() => {
  'use strict'

  // Fetch all the forms we want to apply custom Bootstrap validation styles to
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
        // console.log(alertPlaceholder);
        if (alertPlaceholder) {
            // Set timeout for 3 seconds to fade out the alert slowly
            setTimeout(function() {
                alertPlaceholder.style.transition = "opacity 1s";
                alertPlaceholder.style.opacity = 0;

                // After fadeout, hide the alert
                setTimeout(function() {
                    alertPlaceholder.style.display = "none"; // Hide the alert completely
                }, 1000); // 1 second fade-out delay
            }, 2000); // 
        }
    });
</script>
<script>
        function validateLeave() {
            // e.preventDefault();
            // Get the From Date and To Date as Date objects
            var fromDateValue = document.getElementById("fromdate").value;
            var toDateValue = document.getElementById("todate").value;

            // Ensure both dates are selected
            if (toDateValue < fromDateValue) {
                document.getElementById("errorMessage").innerHTML = "To date cannot be earlier than From date. Please select a valid date.";
                 document.getElementById("fromdate").value="";
                 document.getElementById("todate").value="";
            
                 return false;
            }

            var fromDate = new Date(fromDateValue);
            var toDate = new Date(toDateValue);

            // Get the From Session (FN/AN) and To Session (FN/AN)
            var fromSession = document.getElementById("start_period").value;
            var toSession = document.getElementById("end_period").value;

            // Check if the dates are the same and if the session logic is invalid
           
            if (fromDate.getTime() === toDate.getTime()) {
                if (fromSession === "AN" && toSession === "FN") {
                    document.getElementById("errorMessage").innerHTML = "You cannot apply for leave on the same day from AN to FN.";
                    document.getElementById("start_period").value="";
                    document.getElementById("end_period").value="";
                    
                    return false;
                }
            }

            document.getElementById("errorMessage").innerHTML = "";
            return true; 

            check();
        }

</script>
<script>
  
    function check(){ 
    document.getElementById("submitButton").disabled=true;
    document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
    document.getElementById("submitButton").innerHTML="Sending, please wait...";
    document.getElementById("form1").submit();
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
