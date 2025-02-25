<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>RORIRI -Employee Management</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
        <link rel="stylesheet" href="assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
      <!-- Favicons -->
        
        
      <!-- Google Fonts -->
        <!--- <link href="../views/TimeSheet_files/css" rel="stylesheet"> --->
      <!-- Vendor CSS Files -->
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
<!--- modal --->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            .button{
                align-items: center;
            }
            .clockin_button{
                margin-left: 15px;
            }
            @media(max-width: 991px) {
              .button{
                width: 80px;
                height: 38px;
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
                font-weight: 500;
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
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    
    <body data-aos-easing="ease-in-out" data-aos-duration="1000" data-aos-delay="0" data-new-gr-c-s-check-loaded="14.1095.0" data-gr-ext-installed="">
        <cfoutput>
            <cfif NOT structKeyExists(session, "employee")>
                <cflocation url="logout.cfm">
            </cfif>

        <cfif structKeyExists(url, "id" )>
            <cfinvoke method="getform" id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="get" component="models.timesheet">
        </cfif>

        <cfif structKeyExists(form, "project") AND form.project GTE 1>
            <cfinvoke  component="models.timesheet" method="modulelist" returnvariable="m" pro_id="#form.project#"/>
        <cfelseif structKeyExists(url, "id")>
            <cfinvoke  component="models.timesheet" method="modulelist" returnvariable="m" pro_id="#get.project_id#"/>
        </cfif>

        <cfif structKeyExists(session, "employee") AND session.employee.role_id NEQ "1">
            <cflocation url="logout.cfm">
        </cfif>
        <cfinvoke component="models.employee" method="getemployee" id="#session.EMPLOYEE.ID#" returnvariable="employeeList"/>
        <cfinvoke component="models.login" role_id="4" method="getuser" returnvariable="user">
        <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
        <cfinvoke component="models.employee" method="getEmployeeBirthdays" returnVariable="employeeBirthdays"/>
        <cfinvoke component="models.employee" method="getEmployeeAnniversaries" returnVariable="employeeAnniversaries"/>
        <cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
        <cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>

<!--- header --->
        <cfinclude template="../includes/header/admin_home_header.cfm" runonce="true">
<!--- header ends --->

<section id="hero" class="d-flex align-items-center" style="margin-bottom: 160px; height: 90vh;">

            <div class="container">
                <div class="row">
                    <div class="col-lg-6 order-2 order-lg-1  flex-column justify-content-center">
                        <center><img src="../images/logo-black.jpeg.png" class="my-3" alt="" style="width: 55%;"></center>
                        <center><h1 class="mx-1" style="color: ##1A1254;font-size:xx-large;">Welcome!</h1></center>
                        <center><h4 class="my-1">to</h4></center>
                        <center><h2 class="mx-1" style="font-size: large;">Employee Management System</h2></center>
                        
                        <div class="mx-5">
                            <center>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <a href="task_listing.cfm" class="btn-get-started scrollto w-100 px-1 my-3">Update Timesheet</a>
                                    </div>
                                    <div class="col-sm-6">
                                        <a href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&today" class="btn-get-started scrollto w-100 px-1 my-3">View Timesheet</a>
                                    </div>
                                    <center>
                                        <cfset currentDate = Now()>
                                        <cfset startOfMonth = CreateDate(Year(currentDate), Month(currentDate), 1)>
                                        <cfset formattedCurrentDate = DateFormat(currentDate, "yyyy-mm-dd")>
                                        <cfset formattedStartOfMonth = DateFormat(startOfMonth, "yyyy-mm-dd")>
                                        <div class="col-sm-6">
                                            <a href="admin_employees_log.cfm?Emp_id=&startDate=#formattedStartOfMonth#&endDate=#formattedCurrentDate#" class="btn-get-started scrollto  w-100 px-1 my-3">View Log Sheet</a>
                                        </div>
                                    </center>
                                </div>
                            </center>
                        </div>
                    </div>
                    <div class="col-lg-6 order-1 order-lg-2 hero-img">
                        <img src="assets/img/hero-img.svg" class="img-fluid animated" alt="">
                    </div>
                </div>
            </div>

        </section>
<!--- employee list --->
        <!--- <main id="emp_list" class="pt-5">
            <div class="p-5 text-center" style="background-color:##FEF7F5" class="container aos-init" data-aos="zoom-in">
                <CENTER><h1 style="color:##4C4C78">EMPLOYEES LIST</h1></CENTER>
            </div>
            <section id="update" class="update">
                <div class="container">
                    <div class="row justify-content-between ">
                        <div class="col-lg-6 d-flex align-items-center justify-content-center about-img">
                            <img src="assets/img/about-img.svg" class="img-fluid aos-init" alt="" data-aos="zoom-in">
                        </div>
                        <div class="col-lg-6 pt-5 pt-lg-0">
                            <section id="contact" class="contact">
                                <div class="container aos-init" data-aos="fade-up">
                                    <div class="container">
                                        <div class="col-lg-12 mt-5 mt-lg-0 d-flex align-items-stretch aos-init" data-aos="fade-up" data-aos-delay="200">
                                        </div>
                                        <div class="row">
                                            <cfloop query="user">
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <!--- <img src="..." class="card-img-top" alt="..."> --->
                                                  <div class="card-body">
                                                    <h5 class="card-title">#user.first_name#</h5>
                                                    <p class="card-text"></p>
                                                    <div class="d-flex justify-content-between">
                                                        <a href="admin_timesheet_listing.cfm?emp_id=#user.id#&project=&year=&month=&module=&status=&req=" class="getstarted scrollto">Time Sheet</a>
                                                         <a href="attendance_log.cfm?userid=#user.id#" class="getstarted scrollto">Log Sheet</a>
                                                     </div>
                                                  </div>
                                                </div>
                                            </div>
                                        </cfloop>
                                        </div>  
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </section>
        </main> ---> 

        <main id="update_timesheet">
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
                                        <cfif structKeyExists(url, "id" )>
                                            <h2>Edit Time Sheet</h2>
                                            <p>#get.first_name# #get.last_name#</p>
                                        <cfelse>
                                            <h2>Time Sheet</h2>
                                            <p>Update your Time Sheet Here!</p>
                                        </cfif>
                                    </div>

                                    <div class="container">
                                        <div class="col-lg-12 mt-5 mt-lg-0 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
                                            <form id="form1"<cfif structKeyExists(url, "id" )> action="../controller/_timesheet.cfm?id=#get.id#" method="post" enctype="multipart/form-data"</cfif> action="../controller/_timesheet.cfm" method="post" onsubmit="check()">
                                            
                                                <div class="row">
                                                    <div class="col-lg-4">
                                                        <cfinvoke component="models.timesheet" method="getAllProject" returnvariable="getAllProject">
                                                        <label for="project">Project</label>
                                                        <input type="hidden" name="update">
                                                        <select class="form-select border-dark" name="project" id="project"  onchange="module_list()">
                                                            <option class="dropdown-item" value="">Project</option>
                                                        <cfloop query="getAllProject">
                                                           <option class="dropdown-item" value="#getAllProject.id#" <cfif structKeyExists(form, "project") AND form.project EQ getAllProject.id> selected <cfelseif (structKeyExists(url, "id") AND get.project_id EQ getAllProject.id OR structKeyExists(form, "project") AND form.project EQ getAllProject.id) AND (NOT (structKeyExists(form, "project") AND len(form.project)))> selected</cfif>>#getAllProject.name#</option>
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
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label for="stime">Start Time</label>
                                                        <cfset minday= dateTimeFormat(dateAdd("d", -1, now()),"yyyy-mm-dd HH:nn")>
                                                        
                                                            <input type="datetime-local" name="stime" class="form-control rounded border border-dark" id="stime" <cfif structKeyExists(url, "id")>value="#dateTimeFormat(get.start_time,'yyyy-mm-dd HH:nn:ss')#"</cfif>>
                                                        
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="etime">End Time</label>
                                                        
                                                            <input type="datetime-local" class="form-control rounded border border-dark" name="etime" id="etime"<cfif structKeyExists(url, "id")> value="#dateTimeFormat(get.end_time,'yyyy-mm-dd HH:nn:ss')#"</cfif>/>
                                                        
                                                    </div>
                                                </div>
                                                <br>
                                                <div class="row">    
                                                    <div class="col-lg-6">
                                                        <cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>
                                                        <label for="assgn">Assigned By</label>
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
                                                <div class="row">
                                                    <div class="form-group">
                                                        
                                                            <label for="desc">Description</label>
                                                            <textarea class="form-control rounded border-dark" name="desc" rows="2" placeholder="Description" id="desc"><cfif structKeyExists(url, "id")>#get.description#</cfif></textarea>
                                                        
                                                    </div>
                                                </div>
                                                <cfif structKeyExists(form, "url_data")>
                                                    <input type="hidden" name="url_data" value='#form.url_data#'>
                                                </cfif>
                                                <br>
                                                <center><button class="btn-get-started scrollto border-light" id="submitButton" <cfif structKeyExists(url, "id")> onclick="edit()"<cfelse> onclick="return update1()"</cfif> >Update</button></center>
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
                <div class="modal fade " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h6 class="modal-title" id="exampleModalLabel" ><span style="color:orangered;">Alert !</span></h6>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                      </div>
                      <div class="modal-body">
                         <center><span id="alert1" style="font-size:large;"></span></center>
                      </div>
                     <!---  <div class="modal-footer">
                    <br><br>
                      </div> --->
                    </div>
                  </div>
                </div>
                <!--- /modal --->
        </main>
        <!--- <main id="main" class="pt-lg-5">
            <div class="p-5 text-center" style="background-color:##FEF7F5" class="container aos-init" data-aos="zoom-in">
                <CENTER><h1 style="color:##4C4C78">ASSET MANAGEMENT</h1></CENTER>
            </div>
<!-- Assets Section -->
            <section id="asset" class="update">
                <div class="container">
                    <div class="row justify-content-between ">
                        <div class="col-lg-6 d-flex  justify-content-center about-img">
                            <img src="assets/img/about-img.svg" class="img-fluid aos-init" alt="" data-aos="zoom-in">
                        </div>
                        <div class="col-lg-6 pt-5 pt-lg-0">
                            <section id="contact" class="contact">
                                <div class="container aos-init" data-aos="fade-up">
                                    <div class="container">
                                        <div class="col-lg-6 mt-4 mt-lg-0 d-flex align-items-stretch aos-init" data-aos="fade-up" data-aos-delay="200">
                                        </div>
                                        <div class="row">
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <div class="card-body">
                                                    <center><h5 class="card-title">Add Device</h5><center>
                                                    <p class="card-text"></p>
                                                    <div class="row">
                                                        <a href="asset_registration_form.cfm" class="getstarted scrollto">Click Here</a>
                                                    </div>
                                                  </div>
                                                </div>
                                            </div>
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <div class="card-body">
                                                    <center><h5 class="card-title">View Assets</h5><center>
                                                    <p class="card-text"></p>
                                                    <div class="row">
                                                        <a href="asset_list.cfm" class="getstarted scrollto">Click Here</a>
                                                    </div>
                                                  </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row"> 
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <div class="card-body">
                                                    <center><h5 class="card-title">Assign Assets</h5><center>
                                                    <p class="card-text"></p>
                                                    <div class="row">
                                                        <a href="asset_assign.cfm?asset_id=" class="getstarted scrollto">Click Here</a>
                                                        </div>
                                                  </div>
                                                </div>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </section>
        </main> --->

        <!--- <main id="main" class="pt-lg-5">
            <div class="p-5 text-center" style="background-color:##FEF7F5" class="container aos-init" data-aos="zoom-in">
                <CENTER><h1 style="color:##4C4C78">EMPLOYEE MANAGEMENT</h1></CENTER>
            </div>
<!-- Assets Section -->
            <section id="Emp_asset" class="update">
                <div class="container">
                    <div class="row justify-content-between ">
                        <div class="col-lg-6 d-flex  justify-content-center about-img">
                            <img src="assets/img/about-img.svg" class="img-fluid aos-init" alt="" data-aos="zoom-in">
                        </div>
                        <div class="col-lg-6 pt-5 pt-lg-0">
                            <section id="contact" class="contact">
                                <div class="container aos-init" data-aos="fade-up">
                                    <div class="container">
                                        <div class="col-lg-6 mt-4 mt-lg-0 d-flex align-items-stretch aos-init" data-aos="fade-up" data-aos-delay="200">
                                        </div>
                                        <div class="row">
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <div class="card-body">
                                                    <center><h5 class="card-title">Add Employee</h5><center>
                                                    <p class="card-text"></p>
                                                    <div class="row">
                                                        <a href="add_user.cfm" class="getstarted scrollto">Click Here</a>
                                                    </div>
                                                  </div>
                                                </div>
                                            </div>
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <div class="card-body">
                                                    <center><h5 class="card-title">Employee Details</h5><center>
                                                    <p class="card-text"></p>
                                                    <div class="row">
                                                        <a href="all_employee_details.cfm" class="getstarted scrollto">Click Here</a>
                                                    </div>
                                                  </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row"> 
                                            <div class="col-6 mb-3">
                                                <div class="card">
                                                  <div class="card-body">
                                                    <center><h5 class="card-title">Assigned Assets</h5><center>
                                                    <p class="card-text"></p>
                                                    <div class="row">
                                                        <a href="admin_assigned_asset_details.cfm" class="getstarted scrollto">Click Here</a>
                                                    </div>
                                                  </div>
                                                </div>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </section>
        </main>  --->
         <!--- Timer --->
    
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
  <a href="#"class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <script>
  function check(){
    document.getElementById("submitButton").disabled=true;
    document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
    document.getElementById("submitButton").innerHTML="Sending, please wait...";
  }
  </script>

  <!-- Vendor JS Files -->
  <script src="../assets/vendor/aos/aos.js"></script>
  <script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="../assets/js/main.js"></script>
<script>
    window.onload = function() {
      // Function to get a URL parameter
      function getUrlParameter(name) {
        var url = new URL(window.location.href);
        var paramValue = url.searchParams.get(name);
        return paramValue;
      }

      // Function to remove a URL parameter
      function removeUrlParameter(param) {
        var url = new URL(window.location.href);
        url.searchParams.delete(param);
        window.history.replaceState({}, document.title, url.toString());
      }

      // Check if 'success' exists in the URL
      if (getUrlParameter('s') !== null) {
        // Display the overlay and alert
        // document.getElementById('overlay').style.display = 'block';
        // document.getElementById('successAlert').style.display = 'block';
        showSuccessAlert();
        
        // Remove 'success' key from the URL
          removeUrlParameter('s');
        // Reload the page without the 'success' parameter in the URL
          location.reload();

        // Remove 'success' from the URL after a short delay
        setTimeout(function() {
          // Hide the overlay and alert after 3 seconds
          // document.getElementById('overlay').style.display = 'none';
          // document.getElementById('successAlert').style.display = 'none';
          hideSuccessAlert();

        }, 3000); // Adjust the timeout duration as needed
      }
    };
     function update1(){
        var project = document.getElementById("project").value;
        var mod = document.getElementById("module").value;
        var req = document.getElementById("req").value;
        var stime = document.getElementById("stime").value;
        var etime = document.getElementById("etime").value;
        var assgn= document.getElementById("assgn").value;
        var status = document.getElementById("status").value;
        var desc = document.getElementById("desc").value;
        var startTime=new Date(stime);
        var endTime=new Date(etime);
        if (project==""){
            $("#alert1").html("Project is required");
            $("#exampleModal1").modal("show");
            // alert("Project is required");
            return false;
        }else if(mod==""){
            $("#alert1").html("Module is required");
            $("#exampleModal1").modal("show");
            // alert("Module is required");
            return false;
        }
        else if(req==""){
            $("#alert1").html("Requirement is required");
            $("#exampleModal1").modal("show");
            // alert("Requirement is required");
            return false;
        }
        else if(stime==""){
            $("#alert1").html("Start Time is required");
            $("#exampleModal1").modal("show");     
            // alert("Start Time is required");
            return false;
        }
        else if(etime==""){
            $("#alert1").html("End Time is required");
            $("#exampleModal1").modal("show");
            // alert("End Time is required");
            return false;
        }
        else if(assgn==""){
            $("#alert1").html("Assigned by is required");
            $("#exampleModal1").modal("show");
            // alert("Requirement is required");
            return false;
        }
        else if(status==""){
            $("#alert1").html("Status is required");
            $("#exampleModal1").modal("show");
            // alert("Status is required");
            return false;
        }
        else if(desc==""){
             $("#alert1").html("Description is required");
            $("#exampleModal1").modal("show");
            // alert("Description is required");
            return false;
        }
        else if(startTime.getTime()>endTime.getTime()){
            document.getElementById("etime").focus();
            $("#alert1").html("End Date must be after ("+stime+")");
            $("#exampleModal1").modal("show");
             // alert("End Date must be after ("+stime+")");
            return false;
        }
        else{
            var today = new Date(); 
            today.setDate(today.getDate()-1);
            var dd = today.getDate(); 
            var startdate = new Date(stime);
            var sdd = startdate.getDate(); 
            var enddate = new Date(etime);
            var edd = enddate.getDate();
            console.log(dd);
            console.log(sdd); 
            console.log(edd);
            <cfif structKeyExists(url, "id")>
                document.getElementById("form1").action="../controller/_timesheet.cfm?id=#get.id#"
                document.getElementById("form1").submit();
            <cfelse>
                document.getElementById("form1").action="../controller/_timesheet.cfm"
                document.getElementById("form1").submit();
            </cfif>
        }
    }
    function module_list(){
        // console.log("test")
         document.getElementById("form1").action="dashboard.cfm?##contact"
         document.getElementById("form1").submit();
    }
    function checkClock() {
        // let dateFormat = require('dateformat');
        var ip=document.getElementById("ip").value;
        if (ip==""){
            $("#alert1").html("Please turn off your Ad blocker and refresh the browser or try another browser");
            $("#exampleModal1").modal("show");
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
<cfoutput>
<script>
    
    function module_list(){
        // console.log("test")
         document.getElementById("form1").action="admin_dashboard.cfm?##update_timesheet"
         document.getElementById("form1").submit();
    }
<cfif structKeyExists(url, "id")>
    function edit(){
       document.getElementById("form1").action="../controller/_timesheet.cfm?id=#get.id#&emp_id=#get.emp_id#"
       document.getElementById("form1").submit();
    }
</cfif>
    function update(){
        document.getElementById("form1").action="../controller/_timesheet.cfm"
        document.getElementById("form1").submit();
    }
    
</script>
</cfoutput>

    
</body><grammarly-desktop-integration data-grammarly-shadow-root="true"></grammarly-desktop-integration></html>