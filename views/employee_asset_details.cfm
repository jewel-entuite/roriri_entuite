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

    <!--- <link rel="stylesheet" href="style.css"> --->
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
      @media(max-width: 500px){
        section {
          overflow: scroll;
        }
      }
    </style>
    <!-- Template Main CSS File -->
    <!--- <link href="style.css" rel="stylesheet"> --->
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
</head>

<body>
  <cfoutput>
    <cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
  <!-- header -->
    <cfset active_status="profile">
    <cfinclude template="../includes/header/user_header.cfm" runonce="true">
  <!-- End Header -->

  <section id="contact" class="contact">
    <div class="container my-5">
      <div class="section-title pt-5">
        <h2>Asset Management</h2>
        <p>Employee Asset Details</p>
      </div>
    </div>
<cfif structKeyExists(url, "id")>
  <cfinvoke component="models.asset" method="emp_asset" id=#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')# returnvariable="emp_asset"/>
    <div class="container">
      <!--- <div class="card shadow p-5 mb-5 bg-white rounded my-5" width="100%"> --->
        <style>
            table{
              border: 2px solid black;
              border-radius: 20px;
            }
          </style>
          <div class="shadow card p-4">
            <div class="ms-0 mb-2 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
              <label>ASSET DETAILS</label>
           </div>
           <hr> 
          <table class="table table-striped border-dark" style="overflow: hidden;">
            <thead class="text-center" style="background-color:##31394F;">
              <tr class="text-left" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                <th>SL.NO</th>
                <th>ASSET CODE</th>
                <th>TYPE</th>
                <th>MAKE</th>
                <th>MODEL</th>
                <th>ASSIGNED ON</th>
              </tr>
            </thead>
            <cfset k=1>
            <cfloop query = "emp_asset">
            <tbody style="background-color:##FEF7F5" class="text-center">
            <tr>
              <td>#k#</td>
              <td>#emp_asset.asset_code#</td>
              <td>#emp_asset.asset_name#</td>
              <td>#emp_asset.make#</td>
              <td>#emp_asset.model_number#</td>
              <td>#dateFormat(emp_asset.assigned_on,"dd-mmm-yyyy")#</td>
            </tr>
            <cfset k++>
            </cfloop>
            <cfelse>
              <tr>
                <td colspan="6" align="center">No records found</td>
              </tr>
            </tbody>       
          </table>
      </div>
    </div>
    </cfif>
  </section>

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