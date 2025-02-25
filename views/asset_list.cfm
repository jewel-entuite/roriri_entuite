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

     <!--- <modal> --->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!--- </modal> --->
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Add icon library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!--- <link rel="stylesheet" href="style.css"> --->
    <title>RORIRI -Employee Management</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  
    <script src="assets/js/JsBarcode.all.min.js"></script>  
    <style>
      .pointer {
        cursor: pointer;
      }
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
    <!--- <link href="assets/css/style.css" rel="stylesheet"> --->
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
</head>

<body>
  <cfif NOT structKeyExists(session, "employee")>
      <cflocation url="logout.cfm">
  </cfif>

  <cfoutput>
<!--- <cfinvoke component="models.employee" method="getemployee" id="#session.EMPLOYEE.ID#" returnvariable="employeeList"/> --->
  <!-- header -->
  <cfset active_status="asset_management">
   <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
  <!-- End Header -->
    <main>
      <section id="contact" class="contact">
        <div class="m-5 pt-5" data-aos="fade-up">
          <div class="section-title">
            <h2>Asset Management</h2>
            <p>Asset List</p>
          </div>
          <div class="row mb-3">
              <div class="col-10"></div>
              <div class="col-2 d-flex justify-content-end">
                <a class="btn custom-btn btn-sm mb-0.5" href="asset_registration_form.cfm" role="button">New Asset</a>
              </div>
           </div>
           <div class="shadow card">
            <div class="ms-3 mt-3 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
            <label>ASSET LIST</label>
            </div>
            <hr> 
            <div class="row">
            <form action="asset_list.cfm?##list" method="post">
              <input type="hidden" name="a">
              <div class="row ms-3">
                <!--- <center> --->
                <div class="col-3 ms-3">
                <cfinvoke component="models.asset" method="get_asset_type" returnvariable="asset_type">
                <label for="asset_type" class="mb-1">Asset</label>
                <select class="form-select" name="asset_type" id="asset_type" onchange="submit()">
                  <option value="">All ASSET</option>
                  <cfloop query="asset_type">
                    <option value="#asset_type.id#" <cfif structKeyExists(form, "asset_type") AND form.asset_type EQ asset_type.id> selected </cfif>>#uCase(asset_type.name)#</option>
                  </cfloop>
                </select>
                </div>
              </div>
                  <!--- </center> --->
            </form>
            <cfinvoke component="models.asset" method="get_assets" returnvariable="asset"/>
            <cfif structKeyExists(form, "asset_type") AND form.asset_type NEQ "">
              <cfinvoke component="models.asset" method="get_asset" returnvariable="asset" argumentcollection="#form#"/> 
            <center><p style="margin: 0px; padding: 15px 0px; font-size: 32px;font-weight: 700;color: ##4e4039;">Device - #uCase(asset.name)#</p></center>
            <cfelse>
              <div style="padding:30px 0px"></div>
            </cfif>
            <div class="px-5">
                  <section id="list" class="demo m-0 p-0">
                    <style>
                      table{
                        border: 2px solid black;
                        border-radius: 20px;
                      }
                    </style>
                    <cfset warranty_end_date=false>
                    <cfloop query="asset">
                      <cfif asset.warranty_end_date NEQ "">
                        <cfset warranty_end_date=true>
                      </cfif>
                    </cfloop>
                  <table class="table table-striped border-dark" style="overflow: hidden;">
                    <thead style="background-color:##31394F;">
                      <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <th>SL.NO</th>
                        <cfif NOT structKeyExists(form, "asset_type") OR structKeyExists(form, "asset_type") AND form.asset_type EQ "">
                          <th>ASSET TYPE</th>
                        </cfif>
                        <th>MAKE</th>
                        <th>MODEL NUMBER</th>
                        <th width="125">ASSET CODE</th>
                        <th>VENDOR</th>
                        <!--- <cfif warranty_end_date EQ true>
                          <th>WARRANTY END DATE</th>
                        </cfif> --->
                        <th>BARCODE</th>
                        <th>ASSET IMAGES</th>
                        <th>MORE DETAILS</th>
                        <th>EDIT</th>
                      </tr>
                    </thead>
                    <tbody style="background-color:##FEF7F5">
                      <cfset k=1>
                      <cfif asset.asset_code NEQ "">
                        <cfloop query="asset">
                        <tr class="text-center">
                          <td>#k#</td>
                          <cfif NOT structKeyExists(form, "asset_type") OR structKeyExists(form, "asset_type") AND form.asset_type EQ "">
                            <td>#uCase(asset.asset_name)#</td>
                          </cfif>
                          <td>#uCase(asset.make)#</td>
                          <td>#uCase(asset.model_number)#</td>
                          <td>#uCase(asset.asset_code)#</td>
                          <td>
                            <cfif asset.ven_name NEQ "">
                              #uCase(asset.ven_name)#
                            <cfelse>
                              --
                            </cfif>
                          </td>
                          <!--- <cfif asset.warranty_end_date NEQ "">
                            <td>#dateFormat(asset.warranty_end_date,"dd-mmm-yyyy")#</td>
                          <cfelseif asset.warranty_end_date EQ "" AND structKeyExists(form, "asset_type") AND form.asset_type NEQ "" AND warranty_end_date EQ false>
                          <cfelseif asset.warranty_end_date EQ "" AND structKeyExists(form, "asset_type") AND form.asset_type NEQ "" AND warranty_end_date EQ true>
                            <td>--</td>
                          <cfelse>
                            <td>--</td>
                          </cfif> --->
                          <td>
                          <img src="../images/barcode/#asset.asset_code#.png" width="180" >
                          </td>
                          <cfdirectory action="list" directory="#expandPath("../assets/Asset_files")#/#asset.id#" recurse="false" name="myList">
                          <cfset imagefiles = queryFilter(myList, function(obj){
                             return listFindNoCase(obj.name,"jpg",".")||listFindNoCase(obj.name,"jpeg",".")||listFindNoCase(obj.name,"png",".")||listFindNoCase(obj.name,"gif",".") ;
                          })>
                          <!--- <cfdump var="#asset.image#"><cfabort> --->
                          <td>
                            <cfif imagefiles.recordCount GT 0>
                              <a href="display_assets_img.cfm?id=#asset.id#" target="_blank"><i class="bi bi-images fs-3"></i></a>
                            <cfelse>
                              <a><i class="bi bi-images fs-3"></i></a>
                            </cfif>
                          </td>
                          <td>
                            <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="##myModal#k#"> <i class="fa fa-eye"></i>
                            </button>
                            <div class="modal" id="myModal#k#">
                              <div class="modal-dialog modal-xl">
                                <div class="modal-content">
                                  <!-- Modal Header -->
                                  <div class="d-flex justify-content-between mt-4">
                                    <div></div>
                                    <div>
                                      <h4 class="modal-title">#asset.asset_name#</h4>
                                    </div>
                                    <div>
                                      <button type="button" class="btn-close float-end mx-3" data-bs-dismiss="modal"></button>
                                    </div>
                                  </div>
                                  <!-- Modal body -->
                                  <div class="modal-body">
                                    <table class="table table-striped border-dark" style="overflow: hidden;">
                                      <thead style="background-color:##31394F;">
                                        <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                                          <th>SERIAL NUMBER</th>
                                          <cfif asset.processor NEQ "">
                                            <th>PROCESSOR</th>
                                          </cfif>
                                          <cfif asset.processor_type NEQ "">
                                            <th>PROCESSOR TYPE</th>
                                          </cfif>
                                          <cfif asset.processor_gen NEQ "">
                                            <th>GENERATION</th>
                                          </cfif>
                                          <th>BRANCH</th>
                                          <cfif asset.warranty_start_date NEQ "" OR asset.warranty_end_date NEQ "">
                                            <th>WARRANTY</th>
                                          </cfif>
                                          <cfif asset.extended_warranty NEQ "">
                                            <th>EXTENDED WARRANTY</th>
                                          </cfif>
                                         <!---  <cfif asset.image NEQ "">
                                          <th>IMAGE 1</th>
                                        </cfif> --->
                                          <!--- <cfif asset.images NEQ "">
                                          <th>IMAGE 2</th>
                                        </cfif> --->
                                        </tr>
                                      </thead>
                                      <tbody style="background-color:##FEF7F5">
                                        <tr>
                                          <td>#uCase(asset.serial_number)#</td>
                                          <cfif asset.processor NEQ "">
                                            <td>#uCase(asset.Pro_name)#</td>
                                          </cfif>
                                          <cfif asset.processor_type NEQ "">
                                            <td>#uCase(asset.Pro_type_name)#</td>
                                          </cfif>
                                          <cfif asset.processor_gen NEQ "">
                                            <td>#uCase(asset.gen)#</td>
                                          </cfif>
                                          <cfif asset.branch NEQ "">
                                            <td>#uCase(asset.branch)#</td>
                                          <cfelse>
                                            <td>--</td>
                                          </cfif>
                                          <cfif asset.warranty_start_date NEQ "" OR asset.warranty_end_date NEQ "">
                                            <td>
                                                <cfif asset.warranty_start_date NEQ "">
                                                 <b>Start Date</b> <br> 
                                                #dateFormat(asset.warranty_start_date,"dd-mmm-yyyy")# <br>
                                              </cfif>
                                              <cfif asset.warranty_end_date NEQ "">
                                              <b>End Date</b> <br> 
                                              #dateFormat(asset.warranty_end_date,"dd-mmm-yyyy")#
                                              </cfif>
                                           </td>
                                          </cfif>
                                          <cfif asset.extended_warranty NEQ "">
                                            <td>#dateFormat(asset.extended_warranty,"dd-mmm-yyyy")#</td>
                                          </cfif>
                                          <!--- <cfif asset.image NEQ "">
                                           <td><a href="asset_image.cfm?img=#asset.image#" target="_blank"><button class="btn btn-sm border-dark"> <svg   xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-card-image" viewBox="0 0 16 16">
                                                <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                                <path d="M1.5 2A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13zm13 1a.5.5 0 0 1 .5.5v6l-3.775-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12v.54A.505.505 0 0 1 1 12.5v-9a.5.5 0 0 1 .5-.5h13z"/>
                                              </svg></button></a>
                                            </td>
                                            <cfif asset.images NEQ "">
                                        <td><a href="asset_image.cfm?img=#asset.images#"target="_blank"><button class="btn btn-sm border-dark"> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red  " class="bi bi-card-image" viewBox="0 0 16 16">
                                                <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                                <path d="M1.5 2A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13zm13 1a.5.5 0 0 1 .5.5v6l-3.775-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12v.54A.505.505 0 0 1 1 12.5v-9a.5.5 0 0 1 .5-.5h13z"/>
                                              </svg></button></a></td>
                                        </cfif>
                                        </cfif> --->
                                        </tr>
                                    </table>
                                    <table class="table table-striped border-dark" style="overflow: hidden;"><thead style="background-color:##31394F;">
                                          <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                                       
                                        </tr></thead>
                                        <tbody>
                                        <tr>
                                        
                                       
                                        </tr></tbody>
                                        </table>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </td>
                          <td> 
                            <form name="editasset" method="post" action="asset_registration_form.cfm?id=#asset.id#">
                              <button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"><i class="bi bi-pencil-square"></i></button> 
                            </form>
                         </td>
                        </tr>
                        <cfset k++>
                        </cfloop>
                      <cfelse>
                        <tr>
                          <cfif structKeyExists(form, "asset_type") AND form.asset_type NEQ "">
                            <td colspan="12" class="text-center "><h3 class="my-5">No Records Found!</h3></td>
                          <cfelse>
                            <td colspan="12" class="text-center "><h3 class="my-5">No Records Found!</h3></td>
                          </cfif>
                        </tr>
                      </cfif>
                      </tbody>
                    </tbody>
                  </table>
                </div>
              </div>
               </section>
              </main>
          </cfoutput>
          </div>
        </div>
      </section>
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