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

    <title>RORIRI -Employee Management : Add Employee</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  
    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <style>
      .pointer {
            cursor: pointer;
      }
       @media(max-width: 500px){
        section {
            overflow: scroll;
        }
      }
        .tag .remove {
            margin-left: 5px;
            color: #333;
            cursor: pointer;
           /*display: none;*/
        }
        .tag {
            display: inline-flex;
            align-items: center;
            background-color: #e0e0e0;
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 14px;
            color: #333;
        }
        .selected-tags {
/*          margin-top: 10px;*/
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .clear-all {
            margin-top: 1px;
            color: gray;
            cursor: pointer;
            font-size: 16px;
            display: none; /* Hide initially */
            text-decoration: underline; /* Adds underline */
        }
        select {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px;
        }
        .selected-count {
            margin-top: 1px;
            font-size: 16px;
            color: dimgray;
            font-weight: bold;
            display: none; /* Hide initially */
        }
        .selected-filter{
            padding: 1px 165px 1px 30px;
            margin-top:-5px;
            margin-bottom:-8px;
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
        #loader {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999;
        }
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
            z-index: 1000; /* Lower z-index */
        }
         .page-item {
            margin: 0 4px;
          }

          /* Default button styling */
          .page-link {
              background-color: #fff;
              color: #7d66e3;
              border: 1px solid #7d66e3;
              border-radius: 4px;
              padding: 5px 10px;
              text-decoration: none;
          }

          /* Hover effect */
          .page-link:hover {
              background-color: #7d66e3;
              color: #fff;
              border-color: #7d66e3;
          }

          /* Active page styling */
          .page-item.active .page-link {
              background-color: #7d66e3;
              border-color: #7d66e3;
              color: #fff;
          }

          /* Disabled button styling */
          .page-item.disabled .page-link {
              background-color: #7d66e3;
              color: #fff;
              pointer-events: none;
              cursor: not-allowed;
              opacity: 0.3;
          }

          /* Styling for enabled Previous and Next buttons */
          .page-item .page-link {
              pointer-events: auto;
              cursor: pointer;
              opacity: 1;
          }
    </style>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
    
  </head>

  <body>
    <cfoutput>

      <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm"/>
      </cfif>
<!--- header --->
    <cfset active_status="employee_management">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true"/>
<!--- header ends --->
        <cfinvoke component="models.timesheet" method="getTimesheetEmployees" returnvariable="employeeList"/>
        <cfinvoke component="models.logsheet" method="admin_leave_history" sd="#url.Sdate#" ed="#url.Edate#" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="emp_leave"/>
      <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>


    <section id="contact" class="contact">
      <div class="container my-5">
        <div class="section-title">
          <h2>Leave Management</h2>
          <p>Employee Leave Requests</p>
        </div>
      </div>
      <div class="row me-4">
      <div class="col-7"></div>
          <div class="col-5 d-flex justify-content-end">
            <a class="btn btn-sm custom-btn me-2" href="leave_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" role="button">Apply Leave</a>
            <a class="btn btn-sm me-3 custom-btn" href="employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" role="button">Leave History</a>
          </div>  
    </div>
<!--- <filter> --->
  <!--- <center> --->
    <div class="shadow card m-5 my-3">
    <div class="ms-3 mt-4 my-2 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
        <label>LEAVE REQUESTS</label>
    </div>
    <hr>
    <div id="overlay" style="display: none;"></div>
        <div id="loader" style="display: none;">
            <img src="../assets/img/loader.gif" width="50" height="50" alt="Loading...">
        </div>
  <div class="my-5 ms-3">
    <div class="row mb-1 me-5 ms-1 justify-content-start">         
      <div class="col-lg-3">
        <label for="filter_start_Date" class="mb-1">Start Date</label>
        <input type="date" class="form-control" name="admin_filter_start_Date" id="filter_start_Date" onchange="filter('#url.emp_id#')" <cfif structKeyExists(url, "Sdate") AND url.Sdate NEQ  ""> value="#URL.Sdate#"</cfif>>
      </div>
  
      <div class="col-lg-3">
        <label for="admin_filter_end_Date" class="mb-1">End Date</label>
        <input type="date" class="form-control" name="admin_filter_end_Date" id="filter_end_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "edate") AND url.edate NEQ  ""> value="#URL.edate#"</cfif>>
      </div>

      <div class="col-lg-3">
          <label for="empid" class="mb-1">Choose Employee</label>
          <select class="form-select show-selected-tags" name="empid" id="leave_emp_id" onchange="getEmpl(this.value)">
            <option class="dropdown-item" value="">All Employees</option>
            <cfloop query="#employeeList#">
            <option class="dropdown-item" value="#encrypt(employeeList.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" <cfif structKeyExists(url, "emp_id") AND decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX') EQ employeeList.id> selected </cfif>>#employeeList.first_name#</option>
            </cfloop>
          </select>
        </div>
      </div>
  </div>
  <div class="row selected-filter ">
                <div id="selected-count" class="col-2 selected-count">Filter's Selected:0</div>
                <div class="col-1 clear-all" onclick="clearAll()">Clear All</div>
                <div id="selected-tags" class="col-9 selected-tags "></div>
                <!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
                <!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
         </div>
  </center>
  <br><br>  
<!--- </filter> --->    

      <style>
            table{
              border: 2px solid black;
              border-radius: 20px;
            }
          </style> 
      <div class="container mb-5" style="max-width:1800px;">
        <!--- <div class="card shadow p-5"> --->
          <table class="table table-bordered table-striped border-dark mb-5" id="employee_leave" style=" overflow: hidden; max-height: 200px;">
            <thead style="background-color:##31394F;">
              <tr class="text-center" style="font-size:small; vertical-align: middle; color:white; height: 50px;">
                <th style="width:5%;">NO.</th> 
                <th style="width:13%;">EMPLOYEE NAME</th>
                <th style="width:12%;">FROM</th>
                <th style="width:13%;">TO</th>
                <th style="width:10%;">NO. OF DAYS</th>
                <th>REASON</th>
                <th>STATUS</th>
              </tr>
            </thead>
            <cfset k=1>
            <tbody style="background-color:##FEF7F5">
               <cfif queryRecordCount(emp_leave)GT 0>
              <cfloop query="emp_leave">
                <tr class="text-center" style="font-size:small; vertical-align: middle; height: 50px; ">
                  <td>#k#</td>
                  <td>#emp_leave.first_name# #emp_leave.last_name#</td>
                  <td>#datetimeformat(emp_leave.from_date, 'mm-dd-yyyy')# (#emp_leave.start_period#)</td>
                  <td>#datetimeformat(emp_leave.to_date, 'mm-dd-yyyy')# (#emp_leave.end_period#)</td>
                  <td> 
                    <cfif listlen(emp_leave.total_days,".") EQ 2>
                      <cfif listGetAt(#emp_leave.total_days#, 1,".") EQ 0 AND listGetAt(#emp_leave.total_days#, 2,".") EQ 5>
                        Half day
                      </cfif>
                      <cfif listGetAt(#emp_leave.total_days#, 1,".") GTE 1 AND listGetAt(#emp_leave.total_days#, 2,".") EQ 5>
                       #listGetAt(#emp_leave.total_days#, 1,".")# and Half days
                      </cfif>
                      <cfif emp_leave.total_days EQ 1>
                       1 Day
                      </cfif>
                    <cfelseif emp_leave.total_days LTE 1>
                       #emp_leave.total_days# Day
                    <cfelse>
                      #emp_leave.total_days# Days
                    </cfif>
                  </td>
                  <td style="text-align: justify;">#emp_leave.reason#</td>
                  <td><cfif emp_leave.approved_status EQ 1>Approved<cfelse>Pending</cfif></td>
                </tr>
              <cfset k++>
              </cfloop>
               <cfelse>
                <tfoot>
                <tr>
                  <td colspan="12" class="text-center"><h3 class="my-5">No Records Found!</h3></td>
                </tr>
              </tfoot>
              </cfif>
            </tbody>
          </table>
           <div class="row">
               <div class="col-3 me-4"></div>
               <div class="col-8 d-flex align-items-center" style="height: 40px; padding-left: 250px; font-family: Inter, sans-serif;">
                <!-- Pagination Button -->
                <div class="pagination-container d-flex align-items-center pt-0 mt-0 mx-1 mb-2 pb-0" style="border: 1px solid ##ddd; border-radius: 5px; padding: 5px; padding-bottom: -21px; padding-top: 0px; width: 200px;">
                  <button class="btn btn-sm btn-inline-light page-link mt-0 pb-1 pt-0 ms-1" style="height: 24px; font-size: 14px; line-height: 1.5; padding: 0.375rem 13px;" onclick="goToPagination()">Go</button>
                    <input id="goToPageInput" type="number" class="form-control form-control-sm" placeholder="1" min="1" 
                      style="width: 50px; padding: 5.5px 0.75rem; font-size: 0.875rem; line-height: 1.5; border: none;"/>
                </div>
                <!-- Pagination Navigation -->
                <nav aria-label="Page navigation" style="padding-left: 0px; height: 42px; padding-right: 0px;">
                    <ul 
                        id="pagination-controls" class="pagination d-flex justify-content-end" style="height: 36px; font-size: 0.875rem; line-height: 1.5; padding: 0;">
                    </ul>
                </nav>
                <!-- Total Records Display -->
                <div style="padding-left:0px;">
                <input type="text" class="form-control ms-1 mb-4 mt-3 pe-5" id="record-info" value="Total Record: #queryRecordCount(emp_leave)#" readonly  
                    style="border: 1px solid ##ccc; padding: 5px; width: 225px; text-align: left; background-color: ##f9f9f9; font-size: 0.875rem; font-family: Inter, sans-serif; padding-right: 0rem !important; padding-left:3px;">
                </div>
            </div>
          </div>
        </div>
      </div>
    </section>
</cfoutput>
</body>

<script>

  function filter(lid) {
  var sdate = document.getElementById("filter_start_Date").value;
  var Edate = document.getElementById("filter_end_Date").value; 
      location.href="admin_employee_leave_management.cfm?emp_id="+lid+"&Sdate="+sdate+"&Edate="+Edate;
  }

  function getEmpl(eid) {
     var sdate = document.getElementById("filter_start_Date").value;
     var Edate = document.getElementById("filter_end_Date").value; 
      location.href="admin_employee_leave_management.cfm?emp_id="+eid+"&Sdate="+sdate+"&Edate="+Edate;
      document.getElementById("loader").style.display = 'block';
      document.getElementById("overlay").style.display = 'block';
  }

  function addTag() {
          const selectedTagsDiv = document.getElementById("selected-tags");
          const allElements = document.querySelectorAll(".show-selected-tags");

          allElements.forEach(dropdown => {
              let valueText = dropdown.options[dropdown.selectedIndex].innerHTML;
              const selectedValue = dropdown.value;
              const dropdownId = dropdown.id;

              // Prevent adding empty or duplicate tags
              if (!selectedValue || Array.from(selectedTagsDiv.children).some(tag => tag.getAttribute("data-dropdown") === dropdownId)) {
                  return;
              }

              const labelText = getLabelForDropdown(dropdownId);

              // Create the tag with an identifier for the dropdown
              const tag = document.createElement("div");
              tag.id = `select-tags${dropdown.id}`;
              tag.className = "tag";
              tag.setAttribute("data-dropdown", dropdownId);
              tag.innerHTML = `<strong>${labelText}:</strong>&nbsp;${valueText}<span class="remove" onclick="removeTag(this)">&nbsp;&times;</span>`;

          function getLabelForDropdown(dropdownId) {
                  switch(dropdownId) {
                     case "leave_emp_id": return "Choose Employee";
                      default: return "Label";
                  }
              }

              // Add or update the tag in the selected tags area
              if (document.getElementById(`select-tags${dropdown.id}`) != null) {
                  if (dropdown.value != "") {
                      document.getElementById(`select-tags${dropdown.id}`).outerHTML = tag.outerHTML;
                  } else {
                      document.getElementById(`select-tags${dropdown.id}`).remove();
                  }
              } else {
                  if (dropdown.value != "") {
                      selectedTagsDiv.appendChild(tag);
                  }
              }

              showClearAllButton();
              updateSelectedCount();
          });
      }

          function removeTag(element) {
            console.log(element);
          const tag = element.parentElement;
          const dropdownId = tag.getAttribute("data-dropdown");

          // Reset the corresponding dropdown
          const dropdown = document.getElementById(dropdownId);
          if (dropdown) {
              dropdown.value = ""; // Reset dropdown to placeholder option
              dropdown.dispatchEvent(new Event('change'));
          }

          // Remove the tag
          tag.remove();

          // Hide the "Clear All" button if there are no selected tags
          hideClearAllButton();

          // Update selected count
          updateSelectedCount();
      }

          function clearAll() {
          // Reset all dropdowns to their placeholder options
          const dropdowns = document.querySelectorAll(".show-selected-tags");
          dropdowns.forEach(dropdown => {
              dropdown.value = ""; // Reset to empty
          });

          // Remove all tags
          const selectedTagsDiv = document.getElementById("selected-tags");
          selectedTagsDiv.innerHTML = "";

          // Hide the "Clear All" button after clearing
          hideClearAllButton();

          // Update selected count
          updateSelectedCount();
          document.getElementById("filter_start_Date").value = new Date().toISOString().split('T')[0];
          console.log(dropdowns[0]);

          // location.reload();
          dropdowns[0].dispatchEvent(new Event('change'));
      }

          function showClearAllButton() {
          const clearAllButton = document.querySelector(".clear-all");
          clearAllButton.style.display = "inline-block"; // Show the button
      }

          function hideClearAllButton() {
          const selectedTagsDiv = document.getElementById("selected-tags");
          const clearAllButton = document.querySelector(".clear-all");

          // Hide the "Clear All" button if there are no tags selected
          if (selectedTagsDiv.children.length === 0) {
              clearAllButton.style.display = "none";
          }
      }

          function updateSelectedCount() {
          const selectedTagsDiv = document.getElementById("selected-tags");
          const selectedCountDiv = document.getElementById("selected-count");

          // Update count and toggle visibility
          const count = selectedTagsDiv.children.length;
          selectedCountDiv.innerText = `Filter's Selected: (${count})`;
          selectedCountDiv.style.display = count > 0 ? "block" : "none";
      }

          document.addEventListener("DOMContentLoaded", function(e) {
          addTag();
      });

      let pageSize = 10; // Default number of records per page
     let currentPage = 1;
     const rows = document.querySelectorAll("#employee_leave tbody tr");
     const totalRows = rows.length;
    let totalPages = Math.ceil(totalRows / pageSize);

// Function to display a specific page
function showPage(page) {
    if (page < 1 || page > totalPages) return; // Ensure valid page number
    currentPage = page;

    const start = (page - 1) * pageSize;
    const end = page * pageSize;

    rows.forEach((row, index) => {
        row.style.display = index >= start && index < end ? '' : 'none';
    });

    updatePaginationControls();
    updateRecordCountDisplay(start, end, totalRows); // Update the record count display
}

// Update pagination controls (buttons)
function updatePaginationControls() {
    const paginationContainer = document.getElementById("pagination-controls");
    paginationContainer.innerHTML = '';

    // Previous Button
    const prevButton = document.createElement("li");
    prevButton.classList.add("page-item");
    if (currentPage === 1) prevButton.classList.add("disabled"); // Disable if on first page
    prevButton.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="previousPage()">Previous</a>`;
    paginationContainer.appendChild(prevButton);

    // Calculate page range for display
    const maxVisiblePages = 5; // Number of visible pages at a time
    let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
    let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

    // Adjust if near the end
    if (endPage - startPage + 1 < maxVisiblePages) {
        startPage = Math.max(1, endPage - maxVisiblePages + 1);
    }

    // Display page buttons
    for (let i = startPage; i <= endPage; i++) {
        const pageItem = document.createElement("li");
        pageItem.classList.add("page-item");
        if (i === currentPage) pageItem.classList.add("active");
        pageItem.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="showPage(${i})">${i}</a>`;
        paginationContainer.appendChild(pageItem);
    }

    // Ellipsis and Last Page
    if (endPage < totalPages) {
        const ellipsis = document.createElement("li");
        ellipsis.classList.add("page-item", "disabled");
        ellipsis.innerHTML = `<a class="page-link" href="javascript:void(0);">...</a>`;
        paginationContainer.appendChild(ellipsis);

        const lastPage = document.createElement("li");
        lastPage.classList.add("page-item");
        lastPage.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="showPage(${totalPages})">${totalPages}</a>`;
        paginationContainer.appendChild(lastPage);
    }

    // Next Button
    const nextButton = document.createElement("li");
    nextButton.classList.add("page-item");
    if (currentPage === totalPages) nextButton.classList.add("disabled"); // Disable if on last page
    nextButton.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="nextPage()">Next</a>`;
    paginationContainer.appendChild(nextButton);
}

// Change the number of rows per page
function changeRowCount() {
    const rowCountSelect = document.getElementById("rowCount");
    pageSize = parseInt(rowCountSelect.value, 10);
    totalPages = Math.ceil(totalRows / pageSize);
    currentPage = 1; // Reset to the first page
    showPage(currentPage);
}

// Navigate to a specific page using the "Go" button
function goToPagination() {
    const pageInput = document.getElementById("goToPageInput");
    const pageNumber = parseInt(pageInput.value, 10); // Convert input to a number

    // Validate the input page number
    if (!pageNumber || pageNumber < 1 || pageNumber > totalPages) {
        alert(`Please enter a valid page number between 1 and ${totalPages}.`);
        return;
    }

    // Navigate to the specified page
    showPage(pageNumber);
    pageInput.value = ''; // Clear the input field
}

// Navigate to the next page
function nextPage() {
    if (currentPage < totalPages) {
        showPage(currentPage + 1);
    }
}

// Navigate to the previous page
function previousPage() {
    if (currentPage > 1) {
        showPage(currentPage - 1);
    }
}

// Update the display of record counts
function updateRecordCountDisplay(start, end, total) {
    const recordInfo = document.getElementById("record-info");
    const actualEnd = end > total ? total : end; // Ensure we don't exceed the total records
    // Set the value of the input field to show the current record range
    recordInfo.value = `Showing ${start + 1} to ${actualEnd} of ${total} records`;
}

// Initialize by displaying the first page with disabled buttons
function initPagination() {
    updatePaginationControls(); // Initially disable previous and next buttons
    showPage(currentPage); // Display the first page
}

// Call initPagination to set everything up on page load
initPagination();
</script>

<script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <script src="../assets/js/main.js"></script>
</html>
