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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <title>RORIRI -Employee Management</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
      .pointer {
        cursor: pointer;
      }
      table{
        border: 2px solid black;
        border-radius: 20px;
      }
      .danger-hover {
        transition: background-color 0.3s, border-color 0.3s; /* Smooth transition */
       }
      .danger-hover:hover {
        background-color: ##dc3545 !important; /* Danger red on hover */
        border-color: ##dc3545 !important; /* Match border color */
        color: white; /* Ensure text remains white */
      }
      input.invalid {
        border: 2px solid red;
      }
      .page-heading {
         border-bottom: 1px solid rgba(0, 0, 0, .125);
         padding-bottom: 8px;
      }
       .page-heading .page-heading__container {
          display: block;
          padding: 15px 20px;
          float: left;
          position: relative;
      }
      /* Hidden style */
    .hidden {
        display: none;
    }
    </style>
    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
</head>
<body>
  <cfoutput>
<!-- invokes -->
          <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
          <cfinvoke component="models.login" method="getuser" returnvariable="user"/>
          <cfif structKeyExists(url,"yearDropdown") AND url.yearDropdown NEQ "">
            <cfinvoke component="models.leaves" method="get_leaves" yearByValue="#url.yearDropdown#" returnvariable="getleaves"/>
          <cfelse>
            <cfinvoke component="models.leaves" method="get_leaves" returnvariable="getleaves"/>
          </cfif>

          <cfif structKeyExists(form, "input_edit")>
          <cfinvoke component="models.leaves" uid="#form.input_edit#" id="#form.input_id#" method="edit_Leaves" returnvariable="editLeaves"/>
          </cfif>
          
<!-- header -->
  <cfinclude template="../includes/header/admin_header.cfm" runonce="true"/>
<!-- header ends -->

  <main id="main">
    <section id="contact" class="contact">
      <div data-aos="fade-up">
         <cfif structKeyExists(form, 'input_edit')>
            <div class="section-title p-0">
                <h2>Leave Management</h2>
                <p>Edit Yearly Holidays</p>
            </div>
         <cfelse>
            <div class="section-title p-0">
                <h2>Leave Management</h2>
                <p>Add Yearly Holidays</p>
            </div>
         </cfif>
        <center>
          <div style="width:600px; height: 50px;">
            <cfif structKeyExists(URL, "b")>
                <div  class="alert-success shadow custom-alert" style="width:300px; height: 50px;" role="alert">
                    <p style=" padding: 10px; text-align: center;">Details updated successfully</p>
                </div>
            <cfelseif structKeyExists(url, "s")>
                <div class="alert-success shadow custom-alert" style="width:300px; height: 50px;" role="alert">
                    <p style=" padding: 10px; text-align: center;">Details added successfully</p>
                </div>
            <cfelseif structKeyExists(url, "d")>
                 <div class="alert-success shadow custom-alert" style="width:300px; height: 50px;" role="alert">
                    <p style=" padding: 10px; text-align: center;">Details deleted successfully</p>
                </div>
            </cfif>
                <script>
                    function hideCustomAlert() {
                        console.log('Hiding custom alert...');
                        const alertElement = document.querySelectorAll(".custom-alert");
                        [...alertElement].forEach((element)=>{
                            $(element).addClass("hidden");
                        });
                    }

                    // Automatically hide the alert after 3 seconds
                    setTimeout(hideCustomAlert, 3000);
                </script>
          </div>
        </center>
        <div class="container-fluid">
            <div class="mx-5">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card shadow rounded my-4">
                            <div class="page-heading">
                                <div class="page-heading__container">
                                    <h6 class="my-3" style="font-weight: bold;">Yearly Holidays Listing</h6>
                                </div>
                            </div>
                             <!-- Set selectedYear to current year by default or to the year selected in the dropdown -->
                            <cfset currentYear = year(now())>
                            <cfset selectedYear = structKeyExists(url, "yearDropdown") AND len(url.yearDropdown) ? url.yearDropdown : currentYear>
                            <div class="my-3 px-3">
                                <cfset currentYear = year(now())>
                                <cfset years = ""> 
                                <!-- Generate years dynamically from the current year to 5 years ago -->
                                <cfloop from="#currentYear#" to="#currentYear - 5#" step="-1" index="year">
                                    <cfset years = listAppend(years, year)>
                                </cfloop>
                                <label for="yearDropdown" class="form-label">Years</label>
                                <select id="yearDropdown" class="form-select" style="width: 250px;" onchange="location.href='company_leave_days.cfm?yearDropdown=' + this.value;">
                                    <option value="">Select Year</option>
                                    <cfloop list="#years#" index="year">
                                        <option value="#year#"
                                            <cfif year EQ selectedYear>selected</cfif>>#year#</option>
                                    </cfloop>
                                </select>
                            </div>
                            <div class="card-body">
                            <table class="table table-striped border-dark px-5" style="overflow: hidden;">
                                    <thead style="background-color: ##31394F;">
                                        <tr class="justify-content-center" style="font-size: small; vertical-align: middle; color: white; height: 100%;">
                                            <th>NO</th>
                                            <th>DATE</th>
                                            <th>FESTIVAL/HOLIDAY</th>
                                            <th>ACTION</th> 
                                        </tr>
                                    </thead>
                                <tbody>
                            <!-- Check if there are records in getLeaves -->
                            <cfif queryRecordCount(getLeaves) GT 0>
                            <cfset rowCount = 1> 
                            <cfoutput query="getLeaves">
                            <cfset rid=encrypt(getLeaves.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>
                            <cfset jsonData = DeserializeJSON(company_leaves_JSON)>
                            <!-- Sort the JSON data by date in ascending order -->
                            <cfset sonData = arraySort(jsonData,function(a, b) {
                                        dateA = parseDateTime(replace(a["DATE"], "-", "/", "all"));
                                        dateB = parseDateTime(replace(b["DATE"], "-", "/", "all"));
                                        return compare(dateA, dateB);})/>
                                <cfloop array="#jsonData#" index="item">
                                <!-- Extract the year from the JSON item -->
                                <cfset holidayYear = year(item["DATE"])>
                                <!-- Only display holidays matching selectedYear -->
                                <cfif holidayYear EQ selectedYear>
                                    <tr>
                                        <td>#rowCount#</td> 
                                        <td>#dateFormat(item["DATE"], "dd-MM-yyyy")#</td>
                                        <td>#item["REASON"]#</td>
                                        <td>
                                <cfif isDefined("item.uniqueId")>
                                    <form action="company_leave_days.cfm" method="post">
                                        <!-- Edit Button -->
                                        <button class="btn btn-sm btn-outline-primary"
                                            title="Edit"type="submit" <cfif holidayYear NEQ currentYear>disabled</cfif>>
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <!--- <cfif NOT (structKeyExists(url, "yearDropdown") AND url.yearDropdown EQ currentYear)>disabled </cfif> --->
                                        <input type="hidden" name="input_edit" value="#item.uniqueId#" >
                                        <input type="hidden" name="input_id" value="#getLeaves.id#" >

                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                            data-toggle="tooltip" 
                                            data-placement="bottom" <cfif holidayYear NEQ currentYear>disabled</cfif>
                                            title="Delete" onclick="openDeleteModal('#rid#', '#URLEncodedFormat(item.uniqueId)#', '#item.DATE#', '#URLEncodedFormat(item.REASON)#')">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>
                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="deleteModalLabel"><strong>Confirm Deletion</strong></h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to delete this record?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" style="background-color: ##31394F; color: ##ffffff;" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </cfif>
                                    <!--- onclick="window.location.href='../controller/_leaves.cfm?id=#rid#&dlt=1&uid=#URLEncodedFormat(item.uniqueId)#&date=#item.DATE#&reason=#URLEncodedFormat(item.REASON)#'" --->
                                        </td>
                                    </tr>
                                    <cfset rowCount = rowCount + 1> 
                                </cfif>
                                </cfloop>
                            </cfoutput>
                            <cfelse>
                            <!-- No Records Found -->
                            <tr>
                                <td colspan="4" class="text-center">
                                    <h3 class="my-2">No Records Found!</h3>
                                </td>
                            </tr>
                        </cfif>
                    </tbody>
                </table>
              </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card shadow rounded my-4">
                <div class="row justify-content-between">
                    <div class="my-3">
                        <div>
                            <div class="row page-heading my-3 mx-0 px-0">
                                <div class="col-4">
                                    <h6 style="font-weight: bold;">Annual Leave Days</h6>
                                </div>
                                <div class="col-8 d-flex align-items-start justify-content-end ">
                                    <button id="addRowsBtn" class="btn btn-outline-success alert-success shadow mx-2 mb-3"  onclick="add(4,event)">Add 4 Rows</button>
                                    <button id="addRefBtn" class="btn btn-outline-success alert-success shadow mx-2 mb-3" onclick="location.reload();">Refresh</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <form action="../controller/_leaves.cfm" method="post" class="px-4">
                        <div class="row justify-content-center">
                            <cfset currentYearStart = dateFormat(CreateDate(year(now()), 01, 01),"yyyy-mm-dd") />
                            <cfset firstDayofLastMonth = CreateDate(year(now()), 12, 1) />
                            <cfset currentYearEnd = dateFormat(CreateDate(year(now()), 12, daysInMonth(firstDayofLastMonth)),"yyyy-mm-dd") />
                                <!-- Date Field -->
                                <div class="<cfif structKeyExists(form, 'input_edit')>col-lg-6<cfelse>col-lg-5 my-2</cfif>">
                                    <label for="date" class="label m-2">Date</label>
                                    <input type="date" name="date" id="date"  min="#currentYearStart#" max="#currentYearEnd#"<cfif structKeyExists(form, 'input_edit') >value="#editLeaves.date#"</cfif> class="form-control date" placeholder="dd-mm-yyyy">
                                        <small id="dateError" style="color: red; display: none;">Please select a date.</small>
                                </div>
                                <!-- Reason Field -->
                                <div class="<cfif structKeyExists(form, 'input_edit')>col-lg-6<cfelse>col-lg-5 my-2</cfif>">
                                    <label for="reason" class="label m-2">
                                        <span>Festival/Holiday</span>&nbsp;&nbsp;<span>Reason</span>
                                    </label>
                                    <input type="text" name="reason" id="reason" <cfif structKeyExists(form, 'input_edit')>value="#editLeaves.reason#</cfif>"
                                      class="form-control reason">
                                        <small id="reasonError" style="color: red; display: none;">Reason cannot be empty.</small>
                                </div>
                                <div class="col-lg-2 my-2 mt-5">
                                    <button  id="addSingleRowBtn" class="btn btn-outline-success alert-success shadow" onclick="add(1,event)">
                                        <i class="bi bi-plus"></i> <!-- Bootstrap Plus Icon -->
                                    </button>
                                </div>
                        </div>
                        <div id="row" >
                             <!--- <cfset currentYearStart = CreateDate(year(now()), 01, 01) />
                            <cfset firstDayofLastMonth = CreateDate(year(now()), 12, 1) />
                            <cfset currentYearEnd = CreateDate(year(now()), 12, daysInMonth(firstDayofLastMonth)) /> --->
                        </div>
                              <!-- Buttons -->
                            <div class="<cfif structKeyExists(form, 'input_edit')>text-center col-lg-12 my-2><cfelse>text-center col-lg-10 my-2</cfif>">
                                <cfif structKeyExists(form, "input_edit")>
                                    <a href="company_leave_days.cfm" 
                                        class="btn btn-outline-white mx-3 my-2" 
                                        style="background-color: ##ff0000; color: ##fff; transition: 0.4s; border: 0; text-decoration: none;">
                                        Cancel
                                    </a>
                                </cfif>
                                <button id="applyButton" style="background: <cfif structKeyExists(form, "input_edit")>##28a745<cfelse>##7d66e3</cfif>; color: ##fff; transition: 0.4s; border: 0;" class="btn btn-outline-white mx-3 my-2" type="submit">
                                    <cfif structKeyExists(form, "input_edit")>
                                          Update<cfelse>ADD</cfif>
                                </button>
                                <cfif structKeyExists(form, "input_edit")>
                                  <input type="hidden" name="edit">
                                  <input type="hidden" name="id" value="<cfoutput>#form.input_id#</cfoutput>">
                                  <input type="hidden" name="uid" value="<cfoutput>#form.input_edit#</cfoutput>">
                                </cfif>
                          </div>
                      </div>
                  </div>
            </form>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</cfoutput>
</body>
</html>
<script>
    const currentYearStart = "<cfoutput>#currentYearStart#</cfoutput>";
    const currentYearEnd = "<cfoutput>#currentYearEnd#</cfoutput>";

    console.log("Current Year Start:", currentYearStart); // Example output: "2024-01-01"
    console.log("Current Year End:", currentYearEnd); // Example output: "2024-12-31"

    function add(count) {
        event.preventDefault();
        console.log(currentYearStart,"currentYearStart");
        console.log(currentYearEnd,"currentYearEnd");

        // HTML structure for a pair of fields
        var form = `
            <div class="row">
                <div class="col-lg-5 my-2">
                    <label class="label m-2">Date</label>
                    <input type="date" name="date" class="form-control date" 
                        min="${currentYearStart}" 
                        max="${currentYearEnd}" 
                        >
                </div>
                <div class="col-lg-5 my-2">
                    <label class="label m-2">Festival/Holiday&nbsp;&nbsp;Reason</label>
                    <input type="text" name="reason" class="form-control reason">
                </div>
                <div class="col-lg-2 my-2 mt-5">
                    <button type="button" class="btn btn-danger delete-row">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            </div>
        `;
        // Append the specified number of rows
        for (var i = 1; i <= count; i++) {
            $("#row").append(form);
        }
    }

    $(document).ready(function() {
        $("#add").click(function() {
            add(1); // Add 1 row on click
        });

        // Delete a row when the bin button is clicked
        $("#row").on("click", ".delete-row", function () {
            $(this).closest(".row").remove();
        });
    });
        window.onload = function() {
        let deleteButtons = document.querySelectorAll('.delete-row');
        deleteButtons.forEach(function(button) {
        });
    };
     <cfif structKeyExists(form, "input_edit")>
        // Hide the buttons dynamically using JavaScript
        document.addEventListener("DOMContentLoaded", function() {
          document.getElementById('addRowsBtn').style.display = 'none';
          document.getElementById('addSingleRowBtn').style.display = 'none';
          document.getElementById('addRefBtn').style.display = 'none';
        });
      </cfif>
        
         document.getElementById('applyButton').addEventListener('click', function(event) {
        // Select all date and reason fields
        const dateFields = document.querySelectorAll('.date');
        const reasonFields = document.querySelectorAll('.reason');
        let isValid = true;

        // Clear previous validation errors
        document.querySelectorAll('.validation-error').forEach((error) => error.remove());
        dateFields.forEach((field) => field.classList.remove('invalid'));
        reasonFields.forEach((field) => field.classList.remove('invalid'));

        // Validate all date fields
        dateFields.forEach((dateField) => {
            if (!dateField.value) {
                const error = document.createElement('div');
                error.className = 'validation-error text-danger';
                error.innerText = 'Please select a date.';
                dateField.classList.add('invalid');
                dateField.parentElement.appendChild(error); // Append error to the parent
                isValid = false;
            }
        });

        // Validate all reason fields
        reasonFields.forEach((reasonField) => {
            if (!reasonField.value.trim()) {
                const error = document.createElement('div');
                error.className = 'validation-error text-danger';
                error.innerText = 'Reason cannot be empty.';
                reasonField.classList.add('invalid');
                reasonField.parentElement.appendChild(error); // Append error to the parent
                isValid = false;
            }
        });

        // Prevent form submission if validation fails
        if (!isValid) {
            event.preventDefault();
        }
    });

    // Live validation for date and reason fields
    document.addEventListener('input', function(event) {
        if (event.target.classList.contains('date')) {
            const dateField = event.target;
            if (dateField.value) {
                dateField.classList.remove('invalid');
                const error = dateField.parentElement.querySelector('.validation-error');
                if (error) error.remove();
            }
        }
        if (event.target.classList.contains('reason')) {
            const reasonField = event.target;
            if (reasonField.value.trim()) {
                reasonField.classList.remove('invalid');
                const error = reasonField.parentElement.querySelector('.validation-error');
                if (error) error.remove();
            }
        }
    });
     let deleteUrl = "";

    function openDeleteModal(rid, uid, date, reason) {
        deleteUrl = `../controller/_leaves.cfm?id=${rid}&dlt=1&uid=${uid}&date=${date}&reason=${reason}`;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        window.location.href = deleteUrl;
    });
</script>
                              