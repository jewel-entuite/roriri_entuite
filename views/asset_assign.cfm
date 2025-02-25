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
    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
</head>
<body>
<cfoutput>
  <cfif NOT structKeyExists(session, "employee")>
      <cflocation url="logout.cfm">
  </cfif>
<!-- invoke -->
<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
<cfinvoke component="models.login" method="getuser" returnvariable="user">

<cfif structKeyExists(url, "asset_type")>
<cfinvoke component="models.asset" method="assign_emp" ae="#url.asset_type#" returnvariable="assign"/>
</cfif>
<!-- header -->
  <cfset active_status="asset_management">
  <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
<!--- header ends --->


  <main id="main">
    <section id="contact" class="contact">
      <div class="container my-1" data-aos="fade-up">
          <div class="section-title">
            <h2>Asset Management</h2>
            <p>Assign Assets</p>
          </div>
          <div class="row mb-2 me-5" style="margin-right: -1.5rem !important; margin-bottom: 0.5rem !important;">
           <div class="col-10"></div>
              <div class="col-2 d-flex justify-content-end">
                <a class="btn custom-btn btn-sm mb-2" href="admin_assigned_asset_details.cfm" role="button">Assigned Assets</a>
              </div>
           </div>
           <div class="row mb-2">
          <div class="card shadow container">
            <div class="mb-2 ms-2 mt-4 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
              <label>ASSIGN ASSETS</label>
            </div>
            <hr>
            <div class="row justify-content-between">
<!-- form -->
          <form <cfif structKeyExists(URL, "asset_type") AND structKeyExists(URL, "e")> action="../controller/_asset.cfm?asset_type=#URL.asset_type#&e=#URL.e#"</cfif> onsubmit="return validation()" method="post">
            <input type="hidden" name="abc">
                  <div class="row p-1 ms-3">
<!-- choose employee -->
 <!--- <div class="col-lg-2"> --->
  <!--- </div> --->
                    <div class="col-lg-3">
                      <label for="employee" class="mb-1">Employee</label>
                      <select class="form-select col-md-6 mt-3 mt-md-0 my-4" onchange="CEmp(this.value)" name="employee" id="employee">
                        <option value="">Choose Employee</option>
                        <cfloop query="user">
                          <option value="#encrypt(user.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"<cfif structKeyExists(url, "e") AND url.e EQ encrypt(user.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>selected</cfif>>#user.first_name#</option>
                        </cfloop>
                      </select>
                    </div>
<!-- ends -->
<!-- choose asset -->
                    <div class="col-lg-3">
                      <label for="asset_type" class="mb-1">Asset</label>
                      <cfinvoke component="models.asset" method="get_asset_type" returnvariable="asset_type">
                      <select class="form-select col-md-6 mt-3 mt-md-0 my-4" name="asset_type" id="asset_type" onchange="asset_list()">
                        <option value="">Asset Type</option>
                        <cfloop query="asset_type">
                          <option value="#asset_type.id#" <cfif structKeyExists(url, "asset_type") AND url.asset_type EQ "#asset_type.id#">selected</cfif>>#asset_type.name#</option>
                        </cfloop>
                      </select>
                    </div>
                     <div class="col-lg-2">
                      </div>
<!-- ends -->
                  </div>
                  <input type="hidden" name="selected" id="selected" value="0">
              <cfif structKeyExists(url, "asset_type") AND url.asset_type GTE 1>
                 <style>
                      table{
                        border: 2px solid black;
                        border-radius: 20px;
                      }
                    </style>
                    <div>
              <div class="col-lg-12">
                  <div class="row ms-2">
                    <div class="col-lg-12">
                      <cfif structKeyExists(url, "asset_type") AND queryRecordCount(assign) GT 0>
  <!-- table -->        <table class="table table-striped border-dark" style="overflow: hidden;">
                    <thead style="background-color:##31394F;">
                      <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                              <th>Sl.No</th>
                              <th>Make</th>
                              <th>Model Number</th>
                              <th>Serial Number</th>
                              <th>Asset Code</th>
                              <th>Assign</th>
                              <th>Unassign</th>
                              <th>Assign to</th>
                            </tr>
                          </thead>
                          <tbody  style="background-color:##FEF7F5">
                            <cfset k=1>
                            <cfset re_count=queryRecordCount(assign)>
                            <cfloop query="assign">
                            <tr class="text-center">
                              <td>#k#</td>
                              <td>#uCase(assign.make)#</td>
                              <td>#uCase(assign.model_number)#</td>
                              <td>#uCase(assign.serial_number)#</td>
                              <td>#uCase(assign.asset_code)#</td>
                              <td>
                                <cfif assign.assigned_status EQ 1>
                                  <cfif assign.first_name NEQ "" AND assign.employee_id NEQ URL.e>
                                    <cfif assign.asset_type_id EQ 8 OR assign.asset_type_id EQ 9 OR assign.asset_type_id EQ 10>
                                      <input type="checkbox" value="#assign.asset_code#" name="assign" onclick="selectedcheck(#k#,#re_count#)" id="assign#k#">
                                    <cfelse>
                                      <input type="checkbox" value="" name="assign" id="assign#k#" disabled>
                                    </cfif>
                                  <cfelse>
                                    <input type="checkbox" value="" name="assign" id="assign#k#" disabled>
                                  </cfif>
                                <cfelse>
                                  <input type="checkbox" value="#assign.asset_code#" name="assign" onclick="selectedcheck(#k#,#re_count#)" id="assign#k#">
                                </cfif>
                              </td>
                              <td>
                                <cfif assign.assigned_status EQ 1>
                                  <input type="checkbox" value="#assign.aa_id#" name="unassign" onclick="selectedcheck(#k#,#re_count#)" id="unassign#k#">
                                <cfelse>
                                  <input type="checkbox" value="" name="unassign" id="unassign#k#" disabled>
                                </cfif>
                              </td>
                              <td>
                                <cfif assign.first_name NEQ "">
                                  #assign.first_name#
                                <cfelse>
                                  --
                                </cfif>
                              </td>
                            </tr>
                            <cfset k++>
                            </cfloop>
                          </tbody>
                        </table>
                      </div>
                      <cfelse>
                        <div style="padding: 82px 0;border: 1px solid rgba(0,0,0,.125);text-align: center; color:red;">No Devices found!</div>
                      </cfif>
<!-- table ends -->
                  </div>
                </div>
              </div>
            </cfif>
<!-- assign button -->
              <div class="p-5 col-lg-12">
                <center><button type="submit" style="background: ##7d66e3;border: 0;padding: 10px 24px; color: ##fff;transition: 0.4s;border-radius: 4px;">Assign</button></center>
              </div>
<!-- assign button ends -->
            </div>
          </form>
        </div>
      </div>
<!-- form ends -->
        </div>
      </div>
    </section>
  </main>

<script>
  <cfif structKeyExists(url, "e")>
  function asset_list(){
      var A = document.getElementById("asset_type").value;
      console.log(A)
      location.href="asset_assign.cfm?asset_type="+A+"&e="+"#url.e#";
    }

  <cfelse>
  function asset_list(){
      var A = document.getElementById("asset_type").value;
      console.log(A)
      location.href="asset_assign.cfm?asset_type="+A;
    }

  </cfif>

  function selectedcheck(k,count){
    var selectedcheck = false;
    for (let i = 1; i <= count; i++) {
      var assign=document.getElementById("assign"+i).checked;
      var unassign=document.getElementById("unassign"+i).checked;
      if (assign||unassign) {
        var selectedcheck = true;
      }
    }
    if(selectedcheck){
      document.getElementById("selected").value=1;
    }else{
      document.getElementById("selected").value=0;
    }
  }

  function validation(){
    var selected=document.getElementById("selected").value;
    if(selected==1){
      return true;
    }else{
      alert("Assign/Unassign is Required");
      return false;
    }
  }
  

  function CEmp(value){
    var assetType=document.getElementById("asset_type").value;
    location.href="asset_assign.cfm?asset_type="+assetType+"&e="+value;
  }


</script>
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