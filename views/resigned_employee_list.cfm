<!--- <cfdump var="test1"> --->
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

    <title>RORIRI -Employee Management</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  
     <style>
       @media(max-width: 500px){
        section {
          overflow: scroll;
        }
      }
      .custom-btn {
          background: #fff;
          color: #7d66e3;
          border: 1px solid #7d66e3;
          border-radius: 5px;
          text-decoration: none;
          width: 150px;
          padding:4px ;
          display: flex;
          justify-content: center;
      }
       .custom-btn:hover {
          background: #7d66e3;
          color: #fff;
      }
    </style>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
</head>

<body>
  <cfoutput>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
  <cfinvoke component="models.employee" method="ResignedEmployees" returnvariable="employeeDetails"/>
  <!--- <cfdump var="#employeeDetails#"> --->
  <cfif NOT structKeyExists(session, "employee")>
      <cflocation url="logout.cfm">
  </cfif>  
  <!-- header -->
    <cfset active_status="employee_management">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
  <!-- End Header -->
    <main>
      <section id="contact" class="contact">
        <div class="container" data-aos="fade-up" style="margin-top: 80px; max-width: 1700px;">
          <div class="section-title" >
            <h2 class="mt-5">Employees Details</h2>
            <p> Resigned Employee List</p>
          </div>
            <div class="row mb-3">
              <div class="col-5"></div>
              <div class="col-7 d-flex justify-content-end">
                <a class="custom-btn btn-sm me-2" href="add_user.cfm" role="button">New Employee</a>
                <!--- <a class="custom-btn btn-sm me-2" href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&employee=&today" role="button">Timesheet</a> --->
                <!--- <a class="custom-btn btn-sm me-2" href="admin_weeklyreport_listing.cfm?emp_id=&year=&month=&FSdate=#dateFormat(dateAdd('d', -5, now()), 'yyyy-mm-dd')#&FEdate=#dateFormat(now(), 'yyyy-mm-dd')#" role="button">Log Sheet</a> --->
                <!--- <form action="../views/resigned_employee_list.cfm" method="post"> --->
                <!--- <div style="margin-left: 53%; margin-top:-5%" class="mb-5 pb-5"> --->
                  <a class="custom-btn btn-sm me-4" style="margin-right: 2.5rem!important" type="submit" href="all_employee_details.cfm">Employee List</a>
                <!--- </div> --->
              <!--- </form>  --->
              </div>
            </div>
          <div class="row justify-content-between">            
              <div class="px-5">
                  <style>
                      table{
                        border: 2px solid black;
                        border-radius: 20px;
/*                        margin: 2px;*/
/*                        padding: 2px;*/
                        margin-right: auto;
                      }
                    </style>
                    <div class="shadow card p-2">
                      <div class="mb-2 ms-2 mt-3 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                          <label>RESIGNED EMPLOYEE</label>
                      </div>
                  <hr>
                  <table class="table table-striped border-dark" style="overflow: hidden;">
                    <thead style="background-color:##31394F;">
                      <tr class="justify-content-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <th>NO</th>
                        <th>NAME</th>
                        <th>DESIGNATION</th>
                        <th>MOBILE</th>
                        <th>EMAIL</th>
                        <!--- <th>AADHAAR</th> --->
                        <th>ADDRESS</th>
                        <th style="width: 14%">DATE OF JOINING</th>
                        <th style="width: 10%">ACTION</th>
                      </tr>
                    </thead>
                    <tbody style="background-color:##FEF7F5">
                      <cfset k=1>
                        <cfloop query="employeeDetails">
                        <tr class="justify-content-center">
                          <td>#k#</td>
                          <td>#employeeDetails.first_name# #employeeDetails.last_name#</td>
                          <td>#employeeDetails.name#</td>
                          <td>#employeeDetails.mobile#</td>
                          <td>#employeeDetails.email#</td>
                          <!--- <td>#employeeDetails.aadhaar_number#</td> --->
                          <td>#employeeDetails.current_address#</td>
                          <td>#dateformat(employeeDetails.employee_joining_date, 'mm-dd-yyyy')#</td>
                          <td>
                            <div class="row">
                              <!--- <div class="col-lg-4">
                                <button data-toggle="tooltip" data-placement="bottom" title="Edit" class="btn btn-sm btn-outline-primary" onclick="editEmpDetails('#encrypt(employeeDetails.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#')"><i class="bi bi-pencil-square"></i></button>
                              </div> --->
                              <!--- <div class="col-1"></div> --->
                              <div class="col-lg-4">
                                <button data-toggle="tooltip" data-placement="bottom" title="See More Details" class="btn btn-sm btn-outline-success" onclick="EmpDetails('#encrypt(employeeDetails.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#')"><i class="bi bi-eye"></i></button>
                              </div>
                            </div>
                          </td>
                        </tr>
                        <cfset k++>
                        </cfloop>
                        <tr></tr>
                    </tbody>
                  </table>
                </div>
              </div>
              </div>
              </div>
               </section>
              </main>
          
            </cfoutput>
            <script>
              function editEmpDetails(eId){
                location.href="employee_profile.cfm?id="+eId;
              }

              function EmpDetails(Id){
                location.href="admin_all_employee_details.cfm?token=&id="+Id;
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


