<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>RORIRI -Employee Management</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
     <!--- <modal> --->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!--- </modal> --->
    <!-- Add icon library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    /*.pointer {
      cursor: pointer;
    }*/
       #output.image-grid {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          grid-gap: 30px; /* Optional: Add some spacing between images */
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
</head>

<body>
  <cfif NOT structKeyExists(session, "employee")>
      <cflocation url="logout.cfm">
  </cfif>
  <cfoutput>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>


  <!-- ======= Header ======= -->
  <cfset active_status="asset_management">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
 <!-- End Header --> 
  <main>
    <section id="contact" class="contact">
      <div class="container my-5" >
        <div class="section-title">
          <h2>Asset Management</h2>
          <p>Add Devices</p>
        </div>
        <div class="row justify-content-between">
          <div class="col-lg-5 d-flex align-items-center justify-content-center about-img">
            <img src="assets/img/about-img.svg" class="img-fluid" alt="" data-aos="zoom-in">
          </div>
          <div class="col-lg-6 pt-5 pt-lg-0">
            <div class="row">
              <div class="row ms-3">
              <div class="col-9"></div>
                <div class="col-3 d-flex justify-content-end">
                  <a class="btn custom-btn btn-sm" href="asset_list.cfm" role="button">Assets List</a>
                </div>
            </div>
              <div class="col-lg-12 mt-5 mt-lg-0 d-flex align-items-stretch">
                <form class="my-4"  <cfif structKeyExists(url, "id")>action="../controller/_asset.cfm?id=#url.id#"<cfelse>action="../controller/_asset.cfm"</cfif>  method="post" enctype="multipart/form-data" onsubmit="check()">
                  <input type="hidden" name="asset_hidden">
                    <div class="row">
                      <div class="col-md-4 mt-3 mt-md-0 my-4">
                        <label for="asset_type" class="m-1">Asset Type</label>
                        <cfinvoke component="models.asset" method="get_asset_type" returnvariable="get_asset_type">
                          <cfif structKeyExists(url, "id" )>
                          <cfinvoke component="models.asset" method="get_assets" id="#URL.id#"  returnvariable="
                          assets"/>
                          </cfif>
                        <select style="font-size: small;" class="form-select col-md-3 mt-3 mt-md-0 my-4" name="asset_type" id="asset_type" onchange="asset_code()" required>
                          <option value="">Asset Type</option>
                          <cfloop query="get_asset_type">
                            <option value="#get_asset_type.id#" <cfif (structKeyExists(url, "asset_type") AND url.asset_type EQ get_asset_type.id) or (structKeyExists(url, "id" )  AND assets.asset_type_id EQ get_asset_type.id)>selected</cfif>>#get_asset_type.name#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="col-md-4 mt-3 mt-md-0 my-4">
                        <label for="vendor" class="m-1">Vendor</label>
                        <cfinvoke component="models.asset" method="get_vendor_details" returnvariable="vendor_details">
                        <select style="font-size: small;" class="form-select col-md-3 mt-3 mt-md-0 my-4" name="vendor" id="vendor" required>
                          <option value="">Choose vendor</option>
                          <cfloop query="vendor_details">
                            <option value="#vendor_details.id#" <cfif (structKeyExists(url, "vendor") AND url.vendor EQ vendor_details.id) OR (structKeyExists(url, "id") AND assets.vendor_id EQ vendor_details.id)>selected</cfif>>#vendor_details.name#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="col-md-4 mt-3 mt-md-0 my-4">
                        <label for="vendor" class="m-1">Branch</label>
                        <cfinvoke component="models.asset" method="get_branch_details" returnvariable="branch_details">
                        <select style="font-size: small;" class="form-select col-md-3 mt-3 mt-md-0 my-4" name="branch" id="branch" required>
                          <option value="">Choose branch</option>
                          <cfloop query="branch_details">
                            <option value="#branch_details.id#" <cfif (structKeyExists(url, "branch") AND url.branch EQ branch_details.id) OR (structKeyExists(url, "id") AND assets.branch_id EQ branch_details.id)>selected</cfif>>#branch_details.name#</option>
                          </cfloop>
                        </select>
                      </div>
                      <cfif (structKeyExists(url, "asset_type") AND (url.asset_type EQ 1 OR url.asset_type EQ 7 OR url.asset_type EQ 11)) or (structKeyExists(url, "id") AND assets.processor NEQ "")>
                        <div class="col-md-4 mt-3 mt-md-0 my-4">
                           <label for="processor" class="m-1">Processor</label>
                           <cfinvoke component="models.asset" method="get_processor" returnvariable="processor">
                          <select style="font-size: small;" class="form-select col-md-3 mt-3 mt-md-0 my-4" name="processor" id="processor" onchange="asset_code()">
                            <option>Choose Processor</option>
                            <cfloop query="processor">
                              <option value="#processor.id#"<cfif (structKeyExists(url, "process") AND url.process EQ processor.id) OR (structKeyExists(url, "id") AND assets.processor EQ processor.id)> selected </cfif>>#processor.name#</option>
                            </cfloop>
                          </select>
                        </div>
                        <div class="col-md-4 mt-3 mt-md-0 my-4">
                           <label for="get_processor_type" class="m-1">Processor Type</label>
                           <cfif structKeyExists(url, "process") AND URL.process NEQ "">
                            <cfinvoke component="models.asset" method="get_processor_type" process="#url.process#" returnvariable="processor_type"/>
                            </cfif>
                          <select style="font-size: small;" class="form-select col-md-3 mt-3 mt-md-0 my-4" name="processor_type" id="processor_type">
                            <option>Choose Processor Type</option>
                            <cfif structKeyExists(url, "process") AND URL.process NEQ "">
                              <cfloop query="processor_type">
                                <option value="#processor_type.id#"<cfif (structKeyExists(url, "pro_type") AND url.pro_type EQ processor_type.id) OR (structKeyExists(url, "id") AND assets.processor_type EQ processor_type.id)> selected </cfif>>#processor_type.name#</option>
                              </cfloop>
                            </cfif>
                          </select>
                        </div>
                        <div class="col-md-4 mt-3 mt-md-0 my-4">
                           <label for="generation" class="m-1">Generation</label>
                           <cfinvoke component="models.asset" method="get_processor_generation" returnvariable="generation">
                          <select style="font-size: small;" class="form-select col-md-3 mt-3 mt-md-0 my-4" name="generation" id="generation">
                            <option value="">Choose Generation</option>
                            <cfloop query="generation">
                              <option value="#generation.id#"<cfif structKeyExists(url, "gen") AND url.gen EQ generation.id> selected </cfif>>#generation.genaration#</option>
                            </cfloop>
                          </select>
                        </div>
                      </cfif>
                      <div class="col">
                        <!--- <label style="font-size: small;" for="a_code">Asset Code</label> --->
                        <input type="hidden" name="b_code" id="b_code">
                        <!--- <input style="font-size: small;" type="text" class="col-md-6 mt-3 mt-md-4 my-4" disabled name="a_code" id="a_code"> --->
                      </div>
                    </div>

                  <div class="row">
                    <div class="form-group col-md-4 mt-3 mt-md-0 my-4">
                      <label for="name"  class="m-1">Make</label>
                      <input style="font-size: small;" type="text" class="form-control" name="make" id="make" placeholder="Make" required <cfif structKeyExists(url, "id")> value="#assets.make#"</cfif>>
                    </div>
                    <div class="form-group col-md-4 mt-3 mt-md-0 my-4">
                      <label for="name"  class="m-1">Model Number</label>
                      <input style="font-size: small;" type="text" class="form-control" name="ModelNo" id="ModelNo" placeholder="Model Number" required <cfif structKeyExists(url, "id")> value="#assets.model_number#"</cfif>>
                    </div>
                    <div class="form-group col-md-4 mt-3 mt-md-0 my-4">
                      <label for="slno"  class="m-1">Serial Number</label>
                      <input style="font-size: small;" type="text" class="form-control" name="slno" id="slno" placeholder="Serial Number" required <cfif structKeyExists(url, "id")> value="#assets.serial_number#"</cfif>>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-12">
                        <h5 class="text-center">Warranty</h5>
                        <div class="row my-4">
                          <div class="col-md-4">
                            <div class="form-group">
                              <label for="name"  class="m-1">Start Date</label>
                              <input style="font-size: small;" type="date" class="form-control" name="start_warranty" id="start_warranty" placeholder="Warranty" <cfif structKeyExists(url, "id")> value="#datetimeFormat(assets.warranty_start_date,'yyyy-mm-dd')#"</cfif>>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-group">
                              <label for="end_warranty"  class="m-1">End Date</label>
                              <input style="font-size: small;" type="date" class="form-control" name="end_warranty" id="end_warranty" placeholder="Warranty" <cfif structKeyExists(url, "id")> value="#datetimeFormat(assets.warranty_end_date,'yyyy-mm-dd')#"</cfif>>
                            </div>
                          </div>
                          <div class="col-md-4">
                            <div class="form-group">
                              <label for="ex_warranty"  class="m-1">Extended Warranty</label>
                              <input style="font-size: small;" type="date" class="form-control" name="ex_warranty" id="ex_warranty" placeholder="Extended Warranty" <cfif structKeyExists(url, "id")> value="#datetimeFormat(assets.extended_warranty,'yyyy-mm-dd')#"</cfif>>
                            </div>
                          </div>
                        </div>
                        <div class="row my-12">
                           <div class="col-md-5 my-4">
                            <div class="form-group">
                              <label for="file"  class="m-1">Upload Images</label>
                              <input style="font-size: small;" type="file" class="form-control" name="file" id="file" multiple="multiple">
                            </div>
                          </div>

                                <!--- <cfdump var="#assets.image#"> --->
                                <!--- <cfif structKeyExists(url,"id") AND assets.image NEQ "">
                                   <img src="../images/Asset/#assets.image#" id="output"/ style="width:50px;height: 50px;">
                                <cfelse>
                                    <img id="output"/ style="width:50px;height: 50px;">
                                </cfif> --->
                                 

                                  <!--- <button  class="form-control" style="font-size:10px ">view image</button> --->
                                  <!---List all files in a directory--->
                                  <cfif structKeyExists(url,"id")>
                                      <cfdirectory action="list" directory="#expandPath("../assets/Asset_files")#/#url.id#" recurse="false" name="myList">
                                      <div class="col-2 my-5 py-2">
                                          <cfset pdffiles = queryFilter(myList, function(obj){
                                           return listFindNoCase(obj.name,"pdf",".");
                                        })>

                                        <cfset imagefiles = queryFilter(myList, function(obj){
                                           return listFindNoCase(obj.name,"jpg",".")||listFindNoCase(obj.name,"jpeg",".")||listFindNoCase(obj.name,"png",".")||listFindNoCase(obj.name,"gif",".") ;
                                        })>
                                      <button type="button" class="btn btn-sm btn-primary ms-3" data-bs-toggle="modal" data-bs-target="##myModal" > <i class="fa fa-eye"></i>
                                      </button>
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
                                               <!---<img src="../assets/Asset_files/#url.id#/#imagefiles.name#" width="300px" height="300px">
                                                    <button style="background: ##7d66e3;border: 0;padding: 3px 2px;color: ##fff;border-radius: 4px;" id="conformation"><i class="fa fa-trash fa-1x mx-3"></i></button> --->
                                                <div class="card" style="width: 300px; height: 250px">
                                                  <img class="card-img-top" src="../assets/Asset_files/#url.id#/#imagefiles.name#">
                                                  <div class="card-body text-center">
                                                    <button style="background: ##7d66e3;border: 0;padding: 3px 2px;color: ##fff;border-radius: 4px;" id="conformation" onclick="showConfirmation(event,'#listlast(imagefiles.directory,"\")#','#imagefiles.name#')" ><i class="fa fa-trash fa-1x mx-3"></i></button>
                                                  </div>
                                                </div>
                                              </div>

                                                </cfloop>
                                            </div>
                                               
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                  <cfelse>
                                      <div class="col-2 my-5 py-2">
                                       <button type="button" class="btn btn-sm btn-primary ms-3" data-bs-toggle="modal" data-bs-target="##myModal" > <i class="fa fa-eye"></i>
                                      </button>
                                      <div class="modal" id="myModal">
                                        <div class="modal-dialog modal-xl">
                                          <div class="modal-content">
                                            <!-- Modal Header -->
                                            <div class="d-flex justify-content-between mt-4">
                                              <div></div>
                                              <div>
                                                <h5 class="modal-title">Uploading Images</h5>
                                              </div>
                                              <div>
                                                <button type="button" class="btn-close float-end mx-3" data-bs-dismiss="modal"></button>
                                              </div>
                                            </div>
                                            <!-- Modal body -->
                                            <div class="modal-body">
                                              <div class="row m-3">
                                                <div class="col-4 my-3">
                                               <!--- 
                                                    <img src="../assets/Asset_files/#url.id#/#imagefiles.name#" width="300px" height="300px">
                                                    <button style="background: ##7d66e3;border: 0;padding: 3px 2px;color: ##fff;border-radius: 4px;" id="conformation"><i class="fa fa-trash fa-1x mx-3"></i></button> --->
                                                <div id="output">
                                                  </div>
                                                </div>
                                              </div>
                                            </div>    
                                      </div>
                                    </div>
                                   </div>
                                  </cfif>
                            </div>
                           <div class="col-md-5 my-4">
                            <div class="form-group">
                              <label for="documents"  class="m-1">Upload Files</label>
                              <input style="font-size: small;" type="file" class="form-control" name="documents" id="documents" multiple="multiple">
                              <!--- <cfdump var="#assets.images#"> --->
                              <!--- <cfif structKeyExists(url, "id") AND assets.images NEQ "">
                                <img src="../images/Asset/#assets.images#" id="outputs"/ style="width:50px;height: 50px;">
                              <cfelse>
                                <img id="outputs"/ style="width:50px ;height: 50px;">
                              </cfif> --->
                                   <cfset k=1>
                                  
                               <cfif structKeyExists(url,"id")>
                                <cfloop query="pdffiles">
                                  <cfset pdfdate = pdffiles.name>
                                  <cfset sl = k>
                                <cfset k++>

                                  <cfset combinedValue = sl & "." & pdfdate>
                                   <div>
                                        <a href="../assets/Asset_files/#url.id#/#pdffiles.name#" style="font-size: 9px;" target="blank">#combinedValue#</a><button style="border: 0;padding: 1px 0px;background-color: ##fcfffd;border-radius: 4px;" id="conform" onclick="showConfirmation(event,'#listlast(pdffiles.directory,"\")#','#pdffiles.name#')" ><i class="fa fa-trash-o mx-3" style="color: ##7d66e3;"></i></button>
                                    </div>
                                    </cfloop>
                                <cfelse>
                                   <div id="outputs"></div>
                                </cfif>     
                          </div>
                        </div><br>
                        <center><label class="mb-3"><input type="checkbox" id="checkbox" onclick="checkboxcheck()"><span class="mx-1">Personal Asset</span></label></center>
                        <input type="hidden" id="personal" name="personal" value="0">
                    </div>
                  </div>
                  <center><div class="text-center"><button style="background: ##7d66e3;border: 0;padding: 10px 24px;color: ##fff;transition: 0.4s;border-radius: 4px;"  type="submit" class="update_button" id="submitButton"><cfif structKeyExists(URL, "id")>Update Device<cfelse>Add Device</cfif></button></div></center>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</cfoutput>
  <!-- End #main -->
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  <cfoutput>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script>
    function showConfirmation(e,id,name) {
      e.preventDefault();
        var confirmation = confirm("Are you sure to delete?");
        
        if (confirmation) {
            // User clicked OK
            $.ajax({
              url:"../models/asset.cfc",
              type:"get",
              data:{
                method:"deletefiles",
                filename: name,
                folderid:id
              },
              success:(res)=>{
                alert(res);
                location.reload();
              }
            });
            // alert("Deleted successfully");
            // You can add further actions for when the user clicks OK
        }
    }
   
    function check(){
      document.getElementById("submitButton").disabled=true;
      document.getElementById("submitButton").style.background="rgba(240, 92, 28, 0.7)";
      document.getElementById("submitButton").innerHTML="Sending, please wait...";
    }
  </script>


<script>
  $("##documents").on("change", function() {
    if ($("##documents")[0].files.length > 3) {
        alert("Please select up to three files and try again");
        $("##documents").val("");
    }
    else{
      loadFiles(event, "outputs");
    }
});
 $("##file").on("change", function(event) {
  console.log(event);
    if ($("##file")[0].files.length > 6) {
        alert("Please select up to six files and try again");
        $("##file").val("");
    }
    else{
      loadimages(event, "output");
    }
});
  function loadimages(event, outputId) {
  const output = document.getElementById(outputId);
  output.innerHTML = ""; // Clear existing content

  const files = event.target.files;
  for (let i = 0; i < files.length; i++) {
    const file = files[i];
    const imageElement = document.createElement("img");
    imageElement.style.width = "300px";
    imageElement.style.height = "250px";
    imageElement.style.marginRight = "45px"

    // Display each selected file
    const reader = new FileReader();
    reader.onload = function (e) {
      imageElement.src = e.target.result;
      output.appendChild(imageElement);
    };
    reader.readAsDataURL(file);
  }

  // Add a class to the output container for styling
  output.classList.add("image-grid");
}
// function loadFiles(event, outputId){
//   const output = document.getElementById(outputId);
//   output.innerHTML = "";
//   var
//   for (let i = 0; i < event.target.files.length; i++) {
//     var fileName = event.target.files[i].name;
//     var fileDiv = '<a href="##" style="font-size: 10px;"><ol><li>'+fileName+'</li></ol></a>';
//     console.log(fileName);
//     output.innerHTML+=fileDiv;
//   }

// }
function loadFiles(event, outputId) {
  const output = document.getElementById(outputId);
  output.innerHTML = "";

  const olElement = document.createElement("ol");

  for (let i = 0; i < event.target.files.length; i++) {
    const fileName = event.target.files[i].name;

    const liElement = document.createElement("ul");

    const aElement = document.createElement("a");
    aElement.href = "##";
    aElement.style.fontSize = "10px";
    aElement.textContent = fileName;
    liElement.style.padding ="0px";
    olElement.style.padding ="0px";
    liElement.style.margin ="0px";
    olElement.style.margin ="0px";

    // Create a text node for numbering and append it to the anchor tag
    const numberTextNode = document.createTextNode(i + 1 + '. ');
    aElement.insertBefore(numberTextNode, aElement.firstChild);

    liElement.appendChild(aElement);
    olElement.appendChild(liElement);
  }

  output.appendChild(olElement);
}

  function checkboxcheck(){
    var checkbox=document.getElementById("checkbox").checked;
    if (checkbox){
      console.log("true");
      document.getElementById("personal").value=1;
      document.getElementById("vendor").required=false;
      document.getElementById("vendor").parentElement.style.display="none";
      document.getElementById("branch").required=false;
      document.getElementById("branch").parentElement.style.display="none";
    }else{
      console.log("false");
      document.getElementById("personal").value=0;
      document.getElementById("vendor").required=true;
      document.getElementById("branch").required=true;
      document.getElementById("vendor").parentElement.style.display="";
      document.getElementById("branch").parentElement.style.display="";
    }
  } 

  function asset_code(){
    <cfif structKeyExists(url, "asset_type") AND (url.asset_type EQ 1 OR url.asset_type EQ 7 OR url.asset_type EQ 11 )>
    var Asset_type = document.getElementById("asset_type").value;
    var vendor = document.getElementById("vendor").value;
    var processor = document.getElementById("processor").value;
    var processor_type = document.getElementById("processor_type").value;
    var generation = document.getElementById("generation").value;
    var branch = document.getElementById("branch").value;
    location.href="asset_registration_form.cfm?asset_type="+Asset_type+"&process="+processor+"&pro_type="+processor_type+"&gen="+generation+"&vendor="+vendor+"&branch="+branch;
    <cfelse>
    var vendor = document.getElementById("vendor").value;
    var Asset_type = document.getElementById("asset_type").value;
    var branch = document.getElementById("branch").value;
    location.href="asset_registration_form.cfm?asset_type="+Asset_type+"&vendor="+vendor+"&branch="+branch;
    </cfif>
  }
  // var loadFile = function(event) {
  //   var output = document.getElementById('output');
  //   output.src = URL.createObjectURL(event.target.files[0]);
  //   output.onload = function() {
  //     URL.revokeObjectURL(output.src)
  //   }
  // };
  // var loadFiles = function(event) {
  //   var outputs = document.getElementById('outputs');
  //   outputs.src = URL.createObjectURL(event.target.files[0]);
  //   outputs.onload = function() {
  //     URL.revokeObjectURL(outputs.src)
  //   }
  // }
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