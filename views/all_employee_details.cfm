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
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
  <cfinvoke component="models.employee" method="getAllEmployees" returnvariable="employeeDetails"/>
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
        <div class="m-3" data-aos="fade-up">
          <div class="section-title pt-5" >
            <h2 class="mt-5">Employees Details</h2>
            <p>Employee List</p>
          </div>
          <div class="row justify-content-between">
            <div class="row mt-1">
              <div class="col-6"></div>
              <div class="col-6 d-flex justify-content-end">
                <a class="btn btn-outline-light custom-btn btn-sm me-2" href="add_user.cfm" role="button">New Employee</a>
                <!--- <a class="btn btn-outline-light custom-btn btn-sm me-2" href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&employee=&today" role="button">View Timesheet</a> --->
                <!--- <a class="btn btn-outline-light custom-btn btn-sm me-2" href="admin_weeklyreport_listing.cfm?emp_id=&year=&month=&FSdate=#dateFormat(dateAdd('d', -5, now()), 'yyyy-mm-dd')#&FEdate=#dateFormat(now(), 'yyyy-mm-dd')#" role="button">View Log Sheet</a> --->
                <!--- <form action="../views/resigned_employee_list.cfm" method="post"> --->
                <!--- <div style="margin-left: 53%; margin-top:-5%" class="mb-5 pb-5"> --->
                  <a type="submit" class="btn btn-outline-light custom-btn btn-sm me-3" href="resigned_employee_list.cfm">Resigned Employees</a>
                <!--- </div> --->
              <!--- </form>  --->
              </div>
            </div>
              <!--- <form action="../views/resigned_employee_list.cfm" method="post">
                <div style="margin-left: 75%;">
                  <input type="submit" style="background: ##7d66e3;border: 0;padding: 10px 24px;color: ##fff;transition: 0.4s;border-radius: 4px;" value="Resigned Employees">
                </div>
              </form>  --->                      
              <div class="container px-5 py-3">
                  <style>
                      table{
                        border: 2px solid black;
                        border-radius: 20px;
/*                        margin: 2px;*/
                        /*padding: 2px;
                        margin-right: auto;*/
                      }
                    </style>
                    <div class="shadow card p-2">
                     <div class="mb-2 ms-2 mt-3 fs-7 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                        <label>EMPLOYEE DETAILS</label>
                     </div>
                     <hr> 
                  <table class="table table-striped border-dark" style="overflow: hidden;"  id="employee_list">
                    <thead style="background-color:##31394F;">
                      <tr class="justify-content-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <th>NO</th>
                        <th>NAME</th>
                        <th>DESIGNATION</th>
                        <th>MOBILE</th>
                        <th>EMAIL</th>
                        <!--- <th>AADHAAR</th> --->
                        <th>ADDRESS</th>
                        <th style="width: 15%">DATE OF JOINING</th>
                        <th style="width: 10%">ACTION</th>
                      </tr>
                    </thead>
                    <tbody style="background-color:##FEF7F5">
                      <cfset k=1>
                        <cfloop query="employeeDetails">
                        <tr class="justify-content-center">
                          <td>#k#</td>
                          <td>#employeeDetails.first_name# #employeeDetails.last_name#</td>
                          <td>#employeeDetails.designation#</td>
                          <td>#employeeDetails.mobile#</td>
                          <td>#employeeDetails.email#</td>
                          <!--- <td>#employeeDetails.aadhaar_number#</td> --->
                          <td>#employeeDetails.current_address#</td>
                          <td>#dateformat(employeeDetails.employee_joining_date, 'mm-dd-yyyy')#</td>
                          <td>
                            <div class="row">
                              <div class="col-lg-4">
                                <button data-toggle="tooltip" data-placement="bottom" title="Edit" class="btn btn-sm btn-outline-primary" onclick="editEmpDetails('#encrypt(employeeDetails.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#')"><i class="bi bi-pencil-square"></i></button>
                              </div>
                              <!--- <div class="col-1"></div> --->
                              <div class="col-lg-4">
                                <button data-toggle="tooltip" data-placement="bottom" title="See More Details" class="btn btn-sm btn-outline-success" onclick="EmpDetails('#encrypt(employeeDetails.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#')"><i class="bi bi-eye"></i></button>
                              </div>
                            </div>
                          </td>
                        </tr>
                        <cfset k++>
                        </cfloop>
                    </tbody>
                  </table>
                  <div class="row">
               <div class="col-4 me-0 "></div>
               <div class="col-8 d-flex align-items-center" style="height: 40px; padding-left: 332px; font-family: Inter, sans-serif;">
                <!-- Pagination Button -->
                <div class="pagination-container d-flex align-items-center pt-0 mt-0 mx-1 mb-2 pb-0" style="border: 1px solid ##ddd; border-radius: 5px; padding: 5px; padding-bottom: -21px; padding-top: 0px; width: 130px;">
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
                <input type="text" class="form-control ms-1 mb-4 mt-3 pe-5" id="record-info" value="Total Record: #queryRecordCount(employeeDetails)#" readonly  
                    style="border: 1px solid ##ccc; padding: 5px; width: 225px; text-align: left; background-color: ##f9f9f9; font-size: 0.875rem; font-family: Inter, sans-serif; padding-right: 0rem !important; padding-left:3px;">
                </div>
            </div>
          </div>
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

              let pageSize = 10; // Default number of records per page
               let currentPage = 1;
               const rows = document.querySelectorAll("#employee_list tbody tr");
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


