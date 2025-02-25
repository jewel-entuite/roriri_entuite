
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>RORIRI -Employee Management</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <!--- <link rel="stylesheet" type="text/css" href="css/style.css"> --->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
      <!-- MODAL -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js">
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js">
        </script>
      <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
      <!-- Vendor CSS Files -->
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <style>
            .logout_button{
                align-items: center;
            }
            .clockin_button{
                margin-left: 15px;
            }
            @media(max-width: 991px) {
              .logout_button{
                width: 67px;
                height: 32px;
              }
              .clockin_button{
                margin-left: 15px;
              }
            }
            .birthday-title h2 {
              font-size: 16px;
              font-weight: 700;
              padding-top: 10px;
              line-height: 1px;
              margin-bottom: 15px;
              color: #b3a6ed;
            }

            .br-data {
              position: relative;
              font-size: 16px;
              font-weight: 600;
              color: #817671;
              text-align: right;
            }
            .birthday-title p{
                margin-bottom: 10px;
                position: relative;
                font-size: 18px;
                font-weight: 550;
                color: #4e4039;
            }

            .card {
              border: 1px solid #ddd;
              box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
              margin-bottom:10px;
            }
        </style>
        <!-- Template Main CSS File -->
        <link href="assets/css/style.css" rel="stylesheet">
        <!--- <link href="signin.css" rel="stylesheet"> --->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    </head>
    
    <body>
<!--- current month timesheet --->
        <cfset currentDateTime = now()>
        <cfset currentMonth = createDateTime(year(currentDateTime),month(currentDateTime),1,0,0,0)>
        <cfset formattedCurrentMonth = dateFormat(currentMonth, "yyyy-mm-dd")>
        <cfset currentDate = now()>
        <cfset formattedCurrentdate = dateFormat(currentDate, "yyyy-mm-dd")>
<!--- /current month timesheet --->


     
        <cfif NOT structKeyExists(session, "employee")>
            <cflocation url="logout.cfm">
        </cfif>
        <cfinvoke component="models.timesheet" method="getAllProject" returnvariable="getAllProject">
        <cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
        <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
        <cfinvoke component="models.employee" method="getEmployeeBirthdays" returnVariable="employeeBirthdays"/>
        <cfinvoke component="models.employee" method="getEmployeeAnniversaries" returnVariable="employeeAnniversaries"/>
        <cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
        <cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>

        <cfif structKeyExists(url, "id" )>
            <cfinvoke method="getform" id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="get" component="../models/timesheet">
        </cfif>

        <cfif structKeyExists(form, "project") AND form.project GTE 1>
            <cfinvoke  component="../models/timesheet" method="modulelist" returnvariable="m" pro_id="#form.project#"/>
        <cfelseif structKeyExists(url, "id")>
            <cfinvoke  component="../models/timesheet" method="modulelist" returnvariable="m" pro_id="#get.project_id#"/>
        </cfif>
    <cfoutput>
        <!--- header --->
<cfinclude template="../includes/header/user_home_header.cfm" runonce="true">
        <!-- End Header -->

        <!-- ======= Hero Section ======= -->
        <section id="hero" class="d-flex align-items-center" style="margin-bottom: 160px; height: 90vh;">
            <div class="container">
                <div class="row gy-4">
                    <div class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center">
                        <center><img src="../images/logo-black.jpeg" class="my-4" alt="" style="width: 55%;"></center>
                        <center><h1>Welcome!</h1></center>
                        <!-- <h2>to timesheet</h2> -->
                        <div>
                           <center> 
                                <a style=" text-decoration: none;" href="task_listing.cfm" class="btn-get-started scrollto">Update Time Sheet</a><cfoutput>
                                <a style=" text-decoration: none;" href="listing.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&project=&year=&month=&FSdate=#formattedCurrentMonth#&FEdate=#formattedCurrentdate#&module=&status=&req&assgn=&employeeid=" class="btn-get-started scrollto">View Time Sheet</a></cfoutput>
                            </center>
                            <center>
                                <a href="attendance_log.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" class="btn-get-started scrollto">View Log Sheet</a> 
                                <!--- <a style=" text-decoration: none;" href="leave_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" class="btn-get-started scrollto"> Apply Leave</a> --->
                            </center>
                        </div>
                    </div>
                    
                    <div class="col-lg-6 order-1 order-lg-2 hero-img">
                        <img src="assets/img/hero-img.svg" class="img-fluid animated" alt="">
                    </div>
                </div>
            </div>
        </section>
        <!-- End Hero -->
 
        <main id="main">
            <!-- ======= update Section ======= -->
            <section id="update" class="update">
                <div class="container">
                    <div class="row justify-content-between ">
                        <div class="col-lg-6 d-flex align-items-center justify-content-center about-img">
                            <img src="assets/img/about-img.svg" class="img-fluid" alt="" data-aos="zoom-in">
                        </div>
                        <div class="col-lg-6 pt-5 pt-lg-0">
                            <section id="contact" class="contact">
                                <div class="container" data-aos="fade-up">
                                    <div class="section-title">
                                        <h2>Time Sheet</h2>
                                        <p>Update your Time Sheet Here!</p>
                                    </div>

                                    <div class="container">
                                        <div class="col-lg-12 mt-5 mt-lg-0 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200"><cfoutput>
                                            <form id="form1" enctype="multipart/form-data" method="post"onsubmit="event.preventDefault(); check();">
                                            </cfoutput>
                                            </div>
                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <label for="project">Project</label>
                                                        <input type="hidden" name="update">
                                                        <select class="form-select border-dark" name="project" id="project" onchange="module_list()" >
                                                            <option class="dropdown-item" value="">Project</option>
                                                        <cfloop query="getAllProject">
                                                            <option class="dropdown-item" value="#getAllProject.id#" <cfif structKeyExists(url, "id") AND get.project_id EQ #getAllProject.id# OR structKeyExists(form, "project") AND form.project EQ #getAllProject.id#> selected</cfif>>#getAllProject.name#</option>
                                                        </cfloop>
                                                        </select>
                                                    </div>
                                                    <div class="col-lg-4">
                                                         <label for="module">Module</label>
                                                        <select class="form-select border-dark" name="module" id="module">
                                                            <option class="dropdown-item" value="">Module</option>
                                                            <cfif structKeyExists(form, "project") AND form.project GTE 1 OR structKeyExists(url, "id")>
                                                            <cfloop query="m">
                                                            <option class="dropdown-item" value="#m.name#"<cfif structKeyExists(url, "id") AND get.modules EQ m.name> selected</cfif>>#m.name#</option>
                                                            </cfloop>
                                                            </cfif>
                                                            
                                                        </select>
                                                    </div>
                                                    <div class="col-lg-4">
                                                        <label for="req">Requirement</label>
                                                        <select class="form-select border-dark" name="req" id="req">
                                                            <option class="dropdown-item" value="" <cfif NOT structKeyExists(url, "id")>Selected</cfif>>Requirement</option>
                                                            <option class="dropdown-item" value="1" <cfif structKeyExists(url, "id") AND get.requirement_id EQ "1"> selected</cfif>>New</option>
                                                            <option class="dropdown-item" value="3" <cfif structKeyExists(url, "id") AND get.requirement_id EQ "3"> selected</cfif>>Bug</option>
                                                            <option class="dropdown-item" value="2" <cfif structKeyExists(url, "id") AND get.requirement_id EQ "2"> selected</cfif>>Manual Error</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <br>
                                                <!--- <cfif structKeyExists(url, "id")> --->
                                                    <!--- <cfdump var="#dateTimeFormat(get.start_time,"yyyy-mm-dd HH:nn:ss")#"> --->
                                                    <!--- </cfif> --->
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="stime">Start Time</label>
                                                        <cfset minday= dateTimeFormat(dateAdd("d", -1, dateFormat(now())),"yyyy-mm-dd HH:nn")>
                                                        <cfoutput>
                                                            <input type="datetime-local" min="#minday#" name="stime" class="form-control rounded border border-dark" id="stime" <cfif structKeyExists(url, "id")>value="#dateTimeFormat(get.start_time,'yyyy-mm-dd HH:nn:ss')#"</cfif>>
                                                        </cfoutput>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="etime">End Time</label>
                                                        <cfoutput>
                                                            <input type="datetime-local" min="#minday#" class="form-control rounded border border-dark" name="etime" id="etime"<cfif structKeyExists(url, "id")> value="#dateTimeFormat(get.end_time,'yyyy-mm-dd HH:nn:ss')#"</cfif>/>
                                                        </cfoutput>
                                                    </div>
                                                    
                                                </div>
                                                <br>
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <label for="assgn">Assigned By</label>
                                                        <cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>
                                                        <select class="form-select border-dark" name="assgn" id="assgn" onchange="filter()">
                                                            <option class="dropdown-item" value="">Assigned By</option>
                                                            <cfloop query="assgnBy">
                                                                <option class="dropdown-item" value="#assgnBy.id#"<cfif  structKeyExists(url, "id") AND get.assignedby_id EQ assgnBy.id>selected</cfif>>#assgnBy.first_name# #assgnBy.last_name#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">  
                                                        <label for="status">Status</label>
                                                        <select class="form-select border-dark" name="status" id="status">
                                                            <option class="dropdown-item" value="" <cfif NOT structKeyExists(url, "id")>selected</cfif>>Status</option>
                                                            <option class="dropdown-item" value="1"<cfif structKeyExists(url, "id")AND get.status_id EQ "1">selected</cfif>>Completed</option>
                                                            <option class="dropdown-item" value="2"<cfif structKeyExists(url, "id")AND get.status_id EQ "2">selected</cfif>>In Progress</option>
                                                            <option class="dropdown-item" value="3" <cfif structKeyExists(url, "id")AND get.status_id EQ "3">selected</cfif>>Re-Opened</option>
                                                            <option class="dropdown-item" value="4" <cfif structKeyExists(url, "id")AND get.status_id EQ "4">selected</cfif>>R&D</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <br>
                                                <!--- <cfif structKeyExists(url, "id")> --->
                                                    <!--- <cfdump var="#dateTimeFormat(get.start_time,"yyyy-mm-dd HH:nn:ss")#"> --->
                                                    <!--- </cfif> --->
                                                
                                                <!--- <br> --->
                                                <div class="row">
                                                    <div class="form-group">
                                                        <cfoutput>
                                                            <label for="desc">Description</label>
                                                            <textarea class="form-control rounded border-dark" id="desc" name="desc" rows="2" placeholder="Description" required><cfif structKeyExists(url, "id")>#get.description#</cfif></textarea>
                                                        </cfoutput>
                                                    </div>
                                                </div>
                                                <cfif structKeyExists(form, "url_data")>
                                                    <input type="hidden" name="url_data" value='#form.url_data#'>
                                                </cfif>
                                                <br>
                                                <center><button class="btn-get-started scrollto border-light" id="submitButton" onclick="return validateMyForm()">Update</button></center>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </section>
            <section>
                <div class="container birthday-title">
                  <div class="row">
                    <div class="col-lg-3">
                      <div class="card">
                        <div class="card-body">
                          <h2 class="card-title">Birthdays</h2>
                          <hr>
                          <cfif employeeBirthdays.recordCount>
                            <cfoutput query="employeeBirthdays">
                              <div class="br-data"> #dateFormat(DOB, 'dd')# #monthAsString(month(DOB))#</div>
                               <p> #first_name# #last_name#</p>
                            </cfoutput>
                          <cfelse>
                            <p>No Birthday for the next 30 days.</p>
                          </cfif>
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-lg-3">
                      <div class="card">
                        <div class="card-body">
                          <h2 class="card-title">Work Anniversaries</h2>
                          <hr>
                          <cfif employeeAnniversaries.recordCount>
                            <cfoutput query="employeeAnniversaries">
                              <div class="br-data"> #dateFormat(employee_joining_date, 'dd')# #monthAsString(month(employee_joining_date))#</div>
                                <p> #first_name# #last_name#</p>
                            </cfoutput>
                          <cfelse>
                            <p>No Anniversary for the next 30 days.</p>
                          </cfif>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3">
                    <div class="card">
                        <div class="card-body">
                            <h2>Company Anniversary</h2>
                            <hr>
                            <cfset var businessStartDate = createDate(2018, 08, 23)>
                            <cfset var currentDate = now()>
                            <cfset var anniversaryDate = createDate(year(currentDate), month(businessStartDate), day(businessStartDate))>
                            <cfset var startDate = dateAdd("d", -30, anniversaryDate)>
                            <cfif currentDate LTE anniversaryDate AND currentDate GTE startDate>
                                <div class="br-data">#dateFormat(anniversaryDate, 'dd')# #monthAsString(month(anniversaryDate))#</div>
                                <p> Company Anniversary within 30 days</p>
                            <cfelse>
                                <p>No Anniversary for the next 30 days.</p>
                            </cfif>
                        </div>
                    </div>
                    </div>
                    <div class="col-lg-3">
                      <div class="card">
                        <div class="card-body">
                            <h2>Company Leaves</h2>
                            <hr>
                            <cfset currentDate = now()>
                            <cfset endDate = dateAdd("d", 30, currentDate)>
                            <cfset data = 0>
                                <cfloop from="#currentDate#"  to="#endDate#" step="#createTimespan(1, 0, 0, 0)#" index="d">
                                    <cfloop array="#calender#" index="cd">
                                        <cfif dateFormat(cd.DATE) EQ dateFormat(d)>
                                            <cfset data = 1>
                                           <div class="br-data">#dateFormat(cd.DATE, "dd-mmm-yyyy")#</div>
                                           <p> #cd.REASON#</p>
                                        
                                        </cfif>
                                    </cfloop>
                                </cfloop>
                                <cfif data EQ 0>
                                    <p>No Company Leaves for the next 30 days.</p>
                                </cfif>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </section>
             <!-- Modal -->
                <div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h6 class="modal-title" id="exampleModalLabel" ><span style="color:orangered;">Alert !</span></h6>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                         <center><span id="alert" style="font-size:large;"></span></center>
                      </div>
                     <!---  <div class="modal-footer">
                    <br><br>
                      </div> --->
                    </div>
                  </div>
                </div>
                <!--- /modal --->
        </main>
    </cfoutput>
    
        <!--- Timer --->
        <!--- <span id="colcktimer"></span> --->
    <cfoutput>
        <cfset totalsec = 0 />
        <cfloop query="userClock">
            <cfif userClock.checked_in_time NEQ "" AND userClock.checked_out_time NEQ "">
                <cfset totalsec += datediff("s", userClock.checked_in_time, userClock.checked_out_time) />
            </cfif>
        </cfloop>
        
        <cfif queryRecordCount(userClock) GT 0>
            <cfset cu_date = userClock.checked_in_time/>
        <cfelse>
            <cfset cu_date = now()/>
        </cfif>

        <cfset date_af = now()/>

        <cfset totalsec += datediff("s", cu_date, date_af) />

        <cfset days = int(totalsec /(24 * 60 * 60))  />

        <cfset secRemaining = totalsec - (days * 24 * 60 * 60) />

        <cfset hours = int(secRemaining / (60 * 60)) />

        <cfset secRemaining = secRemaining - (hours * 60 * 60) />

        <cfset minutes = int(secRemaining / 60) />

        <cfset seconds = secRemaining - (minutes * 60)>

        <cfset time = "#createTime(hours, minutes, seconds)#"/>
    <!--- #totalMinutes#--#days#--#hours#--#minutes# --->
        <script>
            setInterval(timer, 1000);

            var h = parseInt("#hour(time)#");

            var m = parseInt("#minute(time)#");

            var s = parseInt("#second(time)#");

            var hh;

            var mm;

            var ss;

            function timer(){
                if (s<59) {
                    s++;
                }else if(m<59){
                    s=0;
                    m++;
                }else{
                    s=0;
                    m=0;
                    h++;
                }
                if(h.toString().length==1){
                    hh="0"+h;
                }else{
                    hh=h;
                }
                if(m.toString().length==1){
                    mm="0"+m;
                }else{
                    mm=m;
                }
                if(s.toString().length==1){
                    ss="0"+s;
                }else{
                    ss=s;
                }
                $("##clocktimer").html(hh+":"+mm+":"+ss);
            }

            
        </script>

    </cfoutput>
        <!--- /Timer --->
  <!-- ======= Footer ======= -->
  <!--- <footer id="footer">
    <div class="container py-4">
      <div class="copyright">
        &copy; Copyright <strong><span>Ninestars</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer> ---><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <script>
  function check(){
    document.getElementById("submitButton").disabled=true;
    document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
    document.getElementById("submitButton").innerHTML="Sending, please wait...";
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
<cfoutput>
<script>

     function validateMyForm(){
        var project = document.getElementById("project").value;
        var mod = document.getElementById("module").value;
        var req = document.getElementById("req").value;
        var stime = document.getElementById("stime").value;
        var etime = document.getElementById("etime").value;
        var assgn = document.getElementById("assgn").value;
        var status = document.getElementById("status").value;
        var desc = document.getElementById("desc").value;
        var startTime=new Date(stime);
        var endTime=new Date(etime);
        if (project==""){
            $("##alert").html("Project is required");
            $("##exampleModal").modal("show");
            // alert("Project is required");
            return false;
        }else if(mod==""){
            $("##alert").html("Module is required");
            $("##exampleModal").modal("show");
            // alert("Module is required");
            return false;
        }else if(req==""){
            $("##alert").html("Requirement is required");
            $("##exampleModal").modal("show");
            // alert("Requirement is required");
            return false;
        }
        else if(stime==""){
            $("##alert").html("Start Time is required");
            $("##exampleModal").modal("show");
            // alert("Start Time is required");
            return false;
        }else if(etime==""){
            $("##alert").html("End Time is required");
            $("##exampleModal").modal("show");
            // alert("End Time is required");
            return false;
        }else if(assgn==""){
            $("##alert").html("Assigned by is required");
            $("##exampleModal").modal("show");
            // alert("Assigned by is required");
            return false;
        }else if(status==""){
            $("##alert").html("Status is required");
            $("##exampleModal").modal("show");
            // alert("Status is required");
            return false;
        }else if(desc==""){
            $("##alert").html("Description is required");
            $("##exampleModal").modal("show");
            // alert("Description is required");
            return false;
        }else if(startTime.getTime()>endTime.getTime()){
            document.getElementById("etime").focus();
            $("##alert").html("End Date must be after ("+stime+")");
            $("##exampleModal").modal("show");
             // alert("End Date must be after ("+stime+")");
            return false;
        }else{
            var today = new Date();
            <cfset previousDate=dateFormat(dateAdd("d", -2, now()),"yyyy-mm-dd")>
            var preDate= new Date("#previousDate#"); 
            if(preDate<=startTime&preDate<=endTime){
                console.log("TRUE");
                <cfif structKeyExists(url, "id")>
                    document.getElementById("form1").action="../controller/_timesheet.cfm?id=#get.id#"
                    document.getElementById("form1").submit();
                <cfelse>
                    document.getElementById("form1").action="../controller/_timesheet.cfm"
                    document.getElementById("form1").submit();
                </cfif>
                return true;
            }else{
                return false;
            }
        }
    }

    function module_list(){
        // console.log("test")
         document.getElementById("form1").action="dashboard.cfm?##contact"
         document.getElementById("form1").submit();
    }
    function materialsDropdown(value){
            document.getElementById("Project").value=value;
            submitForm()
        }
</script>
</cfoutput>
<cfoutput>
<script>
    function checkClock() {
        var ip=document.getElementById("ip").value;
        if (ip==""){
            $("##alert").html("Please turn off your Ad blocker and refresh the browser or try another browser");
            $("##exampleModal").modal("show");
            return false;
        }
        document.getElementById("clockBtn").disabled=true;
        document.getElementById("clockBtn").style.background="rgba(184, 184, 184, 0.4)";
        document.getElementById("clockBtn").innerHTML="Sending, please wait...";
        let time = new Date();       

        let sub_type = document.getElementById('clockBtn').value;

        console.log(time);
        document.getElementById('clockTime').value = time;

        if(sub_type == "Clock In"){
            document.clockSubmit.action = "../controller/_logsheet.cfm?clockout=0";
            document.clockSubmit.submit();
        }
        else{
            document.clockSubmit.action ="../controller/_logsheet.cfm?clockout=1";
            document.clockSubmit.submit();        
        }


    }


</script>
</cfoutput>
  <script src="assets/js/main.js"></script>
    </body>
</html>