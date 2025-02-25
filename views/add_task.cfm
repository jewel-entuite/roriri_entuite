<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <title>RORIRI -Employee Management : Project Management</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet"> 
    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
    <style>
      .unclickable {
          pointer-events: none;
          opacity: 0.5;
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
      #selectedAssignTo {
        white-space: normal;
        word-wrap: break-word;
        overflow-wrap: break-word;
      }
      .custom-dropdown-btn {
        background-color: transparent; /* No background color */
        border: 1px solid #ced4da; /* Neutral border similar to input */
        border-radius: 0.375rem; /* Smooth corners */
        padding: 0.375rem 0.75rem; /* Padding for alignment */
        box-shadow: none; /* No default shadow */
        color: #495057; /* Text color */
    }
      /* Dropdown Menu Items */
    .dropdown-menu li {
          padding: 0.3rem;
      }
   .dropdown-menu li:hover {
          background-color: #f8f9fa;
    }
   .dropdown-menu {
    max-height: 300px;
    overflow-y: auto;
  }

  .dropdown-menu .btn {
    margin: 5px;
  }
  .is-invalid {
      border: 1px solid red;
      
  }
</style>
  </head>
  <body>
    <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
    <!--- header --->
    <cfset active_status="project_management">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
    <!--- header ends --->
    <cfoutput>

      <cfinvoke component="models.timesheet" method="getAllProject" returnvariable="getAllProject">
      <cfinvoke component="models.timesheet" method="getStatus" returnvariable="getStatus">
      <cfinvoke component="models.timesheet" method="getrequirement" returnvariable="getrequirement">
      <cfinvoke component="models.employee" method="getAllemployeeForTask" returnvariable="allemployee">
     <!---  <cfif structKeyExists(url, "task_id")>
        <cfdump var="#url.task_id#"><cfabort>
        <cfinvoke component="models.timesheet" method="getTaskDetail" task_id="#decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" returnvariable="taskDetails">
          <cfdump var="#taskDetails#">
      </cfif> --->
      <div class="container d-flex align-items-center justify-content-between" style="margin-top:100px;">
        <div class="col-sm-12 col-md-12 col-lg-12 page-heading">
          <section id="contact" class="contact" style="padding: 20px;">
            <div class="container" data-aos="fade-up">
              <div class="section-title pt-5">
                  <h2 style="font-size: 24px;font-weight: 1000;padding-bottom: 0;line-height: 1px;margin-bottom: 15px;color: ##b3a6ed;">Project Management</h2>
                  <cfif structKeyExists(url, "task_id")><p>Update Task</p><cfelse><p>Add Task</p></cfif>
              </div>
              <div class="row mb-2 me-5" style="margin-right:-1.0rem!important; margin-bottom: 0.5rem !important;">
                  <div class="col-8"></div>
                    <div class="col-4 d-flex justify-content-end">
                      <a class="btn btn-outline-light custom-btn btn-sm mb-2 me-1" href="assigned_task_details.cfm" role="button">Task Details</a>
                      <a class="btn btn-outline-light custom-btn btn-sm mb-2 me-2" href="inactive_task_details.cfm" role="button">Inactive Tasks</a>
                    </div>
              </div>
              <div class="shadow card p-5 mb-5">
                <cfif structKeyExists(url, "task_id") AND len(trim(url.task_id)) GT 0>
                    <div class="mb-4 me-5 fw-bold" style="font-size: 0.9rem; color: ##7d66e3;">
                        <label>EDIT TASK</label>
                    </div>
                <cfelse>
                    <div class="mb-4 me-5 fw-bold" style="font-size: 0.9rem; color: ##7d66e3;">
                        <label>ADD TASK</label>
                    </div>
                </cfif>
                <hr>
                  <!--- <div id="overlay" style="display: none;"></div>
                  <div id="loader" style="display: none;"><img src="../assets/img/loader.gif" width="50" height="50" alt="Loading..."></div>
                  <div class="alert alert-success" style="display:none;" role="alert" id="successAlert">Task added successfully!</div> --->
                
                <cfif structKeyExists(url, "task_id") AND url.task_id NEQ "">
                   <cfinvoke component="models.timesheet" method="getTaskDetail" task_id="#url.task_id#" returnvariable="getTaskDetail">
                    <!--- <cfdump var="#getTaskDetail#"> --->
                     <cfset splittedHours = {}> 
    
                    <!-- Check if splittedHours exists and is a valid JSON string -->
                    <cfif structKeyExists(getTaskDetail, "splittedHours") AND isJSON(getTaskDetail.splittedHours)>
                        <cfset splittedHours = deserializeJSON(getTaskDetail.splittedHours)>
                    <cfelseif structKeyExists(getTaskDetail, "splittedHours") AND getTaskDetail.splittedHours NEQ "">
                        <!-- If it's a comma-separated string, convert it to an array -->
                        <cfset splittedHours = listToArray(getTaskDetail.splittedHours, ",")>
                    </cfif>
                    <script>
                        // Serialize splittedHours to JSON and pass to JavaScript
                        const splittedHours = <cfoutput>#serializeJSON(splittedHours)#</cfoutput>;
                        console.log("Splitted Hours:", splittedHours); 
                    </script>
                </cfif>
                <!--- <cfdump var="#getTaskDetail#"> --->
                <form action="../controller/_timesheet.cfm" id="taskForm" class="needs-validation" novalidate method="post">
                  <cfif structKeyExists(url, "task_id") AND url.task_id NEQ "">
                    <input type="hidden" name="update_task" value="#getTaskDetail.id#">
                    <input type="hidden" name="first_assign" value="#getTaskDetail.assignTo#">
                  <cfelse>
                    <input type="hidden" name="task">
                  </cfif>
                 <!-- First Page -->
                  <div id="firstPage">
                    <div class="row">
                      <!-- Project Name -->
                      <div class="col-md-4 mb-3">
                        <label style="font-size: medium;" for="project" class="my-2">Project</label>
                        <select style="font-size: medium; padding: 10px;" class="form-select" id="project" name="project" required onchange="getModules()">
                          <option value="" selected disabled>Choose Project</option>
                          <cfloop query="getAllProject">
                            <option value="#getAllProject.id#" <cfif structKeyExists(url, "task_id") AND (getTaskDetail.project EQ getAllProject.id)>selected</cfif>>#getAllProject.name#</option>
                          </cfloop>
                        </select>
                        <div class="invalid-feedback">Please select a project.</div>
                      </div>

                      <!-- Task Module -->
                      <div class="col-md-4 mb-3">
                        <label style="font-size: medium;" for="module" class="my-2">Task Module</label>
                        <select style="font-size: medium; padding: 10px;" class="form-select" id="module" name="module" required disabled onchange="setModuleName()">
                          <option value="" selected disabled>Choose Module</option>
                        </select>
                        <div class="invalid-feedback">Please select a task module.</div>
                      </div>

                      <!-- Task Type -->
                      <div class="col-md-4 mb-3">
                        <label style="font-size: medium;" for="task_type" class="my-2">Task Type</label>
                        <select style="font-size: medium; padding: 10px;" class="form-select" id="task_type"  name="task_type" required >
                          <option value="" selected>Choose Task Type</option>
                          <cfoutput query="getrequirement">
                            <option value="#getrequirement.id#" <cfif structKeyExists(url, "task_id") AND getTaskDetail.task_type EQ getrequirement.id>selected</cfif>>#getrequirement.type#</option>
                          </cfoutput>
                        </select>
                        <div class="invalid-feedback">Please select a task type.</div>
                      </div>

                      <!-- Task Description -->
                      <div class="col-md-12 mb-3">
                        <label style="font-size: medium;" for="taskDescription" class="my-2">Task Description</label>
                        <textarea style="font-size: medium; padding: 10px;" class="form-control" id="taskDescription"name="taskDescription" rows="3" required ><cfif structKeyExists(url, "task_id")>#getTaskDetail.taskDescription#</cfif></textarea>
                        <div class="invalid-feedback">Please provide a task description.</div>
                      </div>

                      <!-- Priority -->
                      <div class="col-md-6 mb-3">
                        <label style="font-size: medium;" for="priority" class="my-2">Priority</label>
                        <select style="font-size: medium; padding: 10px;" class="form-select" id="priority" name="priority" required>
                          <option value="" selected>Choose Task Priority</option>
                          <option value="High" <cfif structKeyExists(url, "task_id") AND getTaskDetail.priority EQ "High">selected</cfif>>High</option>
                          <option value="Medium" <cfif structKeyExists(url, "task_id") AND getTaskDetail.priority EQ "Medium">selected</cfif>>Medium</option>
                          <option value="Low" <cfif structKeyExists(url, "task_id") AND getTaskDetail.priority EQ "Low">selected</cfif>>Low</option>
                        </select>
                        <div class="invalid-feedback">Please select the task priority.</div>
                      </div>

                      <!-- Status -->
                      <div class="col-md-6 mb-3">
                        <label style="font-size: medium;" for="status" class="my-2">Status</label>
                        <select style="font-size: medium; padding: 10px;" class="form-select" id="status" name="status" required >
                          <option value="" selected>Choose Task Status</option>
                          <cfoutput query="getStatus">
                            <option value="#getStatus.id#" <cfif structKeyExists(url, "task_id") AND getTaskDetail.status_id EQ getStatus.id>selected</cfif>>#getStatus.status#</option>
                          </cfoutput>
                        </select>
                        <div class="invalid-feedback">Please select the task status.</div>
                      </div>
                    </div>

                    <!-- Next Button -->
                    <div class="form-group row justify-content-end me-1 mt-4">
                      <button type="button" class="btn col-2 btn-outline-light custom-btn" onclick="validateFirstPage()">Next</button>
                    </div>
                  </div>

                  <!-- Second Page -->
                  <div id="secondPage" style="display: none;">
                    <div class="row">
                     <!-- Assign To -->
                      <div class="col-md-4 mb-3">
                        <label style="font-size: medium;" for="assignTo" class="my-2">Assign To</label>
                        <div class="dropdown" id="assigntoDropdown">
                          <button class="dropdown w-100 d-flex justify-content-between align-items-center form-select custom-dropdown-btn"
                                  style="font-size: medium; padding: 10px;" type="button" id="assignToDropdownButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <span id="selectedAssignTo">Choose Employee</span>
                          </button>
                          <ul class="dropdown-menu w-100 p-3" aria-labelledby="assignToDropdownButton" style="max-height: 300px; overflow-y: auto;">
                            <cfloop query="allemployee">
                              <li>
                                <div class="form-check">
                                  <input class="form-check-input assign-to-checkbox" type="checkbox" id="assignTo_#allemployee.id#" name="assignTo[]"
                                         value="#allemployee.id#" <cfif structKeyExists(url, "task_id") AND ListFind(getTaskDetail.assignTo, allemployee.id)>checked</cfif>>
                                  <label class="form-check-label" for="assignTo_#allemployee.id#">#allemployee.first_name# #allemployee.last_name#</label>
                                </div>
                              </li>
                            </cfloop>
                          </ul>
                        </div>
                        <div class="invalid-feedback" id="assigntoError" style="display:none;"> Please select at least one employee to assign.</div>
                      </div>

                      <!-- Estimated Hours -->
                      <div class="col-md-4 mb-3">
                        <label style="font-size: medium;" for="estimatedHours" class="my-2">Estimated Hours</label>
                        <input style="font-size: medium; padding: 10px;" type="number" class="form-select" id="estimatedHours" name="estimatedHours" min="0.5" step="0.5" required
                               <cfif structKeyExists(url, "task_id") AND getTaskDetail.estimatedHours NEQ "">value="#getTaskDetail.estimatedHours#"</cfif>>
                        <div class="invalid-feedback">Please enter estimated hours.</div>
                      </div>

                      <!-- Deliver Before -->
                      <div class="col-md-4 mb-3">
                        <label style="font-size: medium;" for="deliverBefore" class="my-2">Deliver Before</label>
                        <input style="font-size: medium; padding: 10px;" type="date" class="form-select" id="deliverBefore" name="deliverBefore" required
                               <cfif structKeyExists(url, "task_id") AND getTaskDetail.deliverBefore NEQ "">value="#dateformat(getTaskDetail.deliverBefore,'yyyy-mm-dd')#"</cfif>>
                        <div class="invalid-feedback">Please provide a delivery date.</div>
                      </div>
                       <div class="col-12 py-5"></div>
                    </div>

                    <div id="assignedEmployeeInputs" class="mt-3"></div>

                    <!-- Navigation Buttons -->
                    <div class="form-group row justify-content-center mt-4">
                      <button type="button" class="btn col-2 btn-outline-light custom-btn" onclick="showFirstPage()">Back</button>
                      <input type="submit" class="btn col-2 btn-outline-light custom-btn ms-3" value="Submit" id="submitBtn">
                    </div>
                  </div>

                  <input type="hidden" name="project_name" id="project_name">
                  <input type="hidden" name="module_name" id="module_name">
                  <cfif structKeyExists(url,"task_id")>
                    <input type="hidden" name="task_id" value="#decrypt(url.task_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
                    <cfloop query="getTaskDetail">
                    <input type="hidden" name="hextask_id" value="#getTaskDetail.task_id#">
                    </cfloop>
                  </cfif>

                 </form>
              </div>
            </div>
          </section>
        </div>
   
    </cfoutput>
  <script>

  <cfoutput> 
    <cfif structKeyExists(url, "task_id") AND url.task_id NEQ "">
      getModules(#getTaskDetail.module#);
    </cfif>
  </cfoutput>
    function getModules(selected_id = null) {
    var project_name = document.getElementById("project").options[document.getElementById("project").selectedIndex].text;
    const projectNameField = document.getElementById("project_name");
    projectNameField.value = project_name;

    var p_id = document.getElementById("project").value;
    document.getElementById('overlay').style.display = 'block';
    document.getElementById('loader').style.display = 'block';
    // showLoading();
    
    $.ajax({
        type: 'POST',
        url: '../models/timesheet.cfc',
        dataType: 'json',
        data: {
            method: 'modulelist',
            pro_id: p_id
        },
        success: function(response) {
          document.getElementById('overlay').style.display = 'none';
          document.getElementById('loader').style.display = 'none';
            // hideLoading();
            var moduleDropdown = document.getElementById("module");
            moduleDropdown.removeAttribute("disabled");
            moduleDropdown.innerHTML = '<option value="" selected disabled>Choose Module</option>';

            if (response && response.DATA && Array.isArray(response.DATA)) {
                response.DATA.forEach(function(row) {
                    var moduleId = row[0];
                    var moduleName = row[2];

                    var option = document.createElement("option");
                    option.value = moduleId;
                    option.text = moduleName;

                    // Check if the selected_id (from update) matches moduleId
                    if (selected_id && selected_id == moduleId) {
                        option.selected = true;
                        document.getElementById("module_name").value = moduleName;
                    }

                    moduleDropdown.appendChild(option);
                });
            } else {
                console.error("Unexpected response format:", response);
            }
        },
        error: function(xhr, status, error) {
            console.error("Error fetching modules:", error);
        }
    });
}

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
      if (getUrlParameter('success') !== null) {
        // Display the overlay and alert
        // document.getElementById('overlay').style.display = 'block';
        // document.getElementById('successAlert').style.display = 'block';
        showSuccessAlert();
        
        // Remove 'success' key from the URL
          removeUrlParameter('success');
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
    function setModuleName() {
        const moduleDropdown = document.getElementById("module");
        const moduleNameField = document.getElementById("module_name");
        const module_name = moduleDropdown.options[moduleDropdown.selectedIndex].text;
        moduleNameField.value = module_name;
        console.log(document.getElementById("module_name").value);
    }


  document.addEventListener('DOMContentLoaded', () => {
      // Update the selected employees label on page load
      updateSelectedLabel();

      // Update the displayed selected employees on checkbox change
      document.querySelectorAll('.assign-to-checkbox').forEach((checkbox) => {
          checkbox.addEventListener('change', updateSelectedLabel);
      });

      function updateSelectedLabel() {
          const selectedLabels = Array.from(document.querySelectorAll('.assign-to-checkbox:checked'))
              .map((checkbox) => document.querySelector(`label[for=${checkbox.id}]`).textContent)
              .join(', ');
          
          // Update the display with selected employees or fallback to default text
          document.getElementById('selectedAssignTo').textContent = selectedLabels || 'Choose Employee';
      }
  });
    // Show First Page
     function showFirstPage() {
      document.getElementById('firstPage').style.display = 'block';
      document.getElementById('secondPage').style.display = 'none';
    }

    // Show Second Page
    function showSecondPage() {
      document.getElementById('firstPage').style.display = 'none';
      document.getElementById('secondPage').style.display = 'block';
    }

    // Validate First Page and Show Second Page only if valid
    function validateFirstPage() {
      const firstPage = document.getElementById('firstPage');
      const form = document.getElementById('taskForm');
      
      // Only validate the first page fields
      const firstPageFields = firstPage.querySelectorAll('input, select, textarea');
      let isValid = true;
      firstPageFields.forEach((field) => {
        if (!field.checkValidity()) {
          isValid = false;
        }
      });

      if (isValid) {
        form.classList.remove('was-validated'); // Clear validation state
        showSecondPage(); // Show second page if validation is passed
      } else {
        form.classList.add('was-validated'); // Add validation state
      }
    }

   // Validate Second Page
 function validateSecondPage() {
    const secondPage = document.getElementById('secondPage');
    const form = document.getElementById('taskForm');
    
    // Validate Assign To checkboxes
    const assignToCheckboxes = secondPage.querySelectorAll('.assign-to-checkbox');
    const dropdown = document.getElementById('assigntoDropdown');
    const dropdownButton = dropdown.querySelector('button');
    const errorDiv = document.getElementById('assigntoError');
    let atLeastOneChecked = false;

    // Check if any checkbox is selected
    assignToCheckboxes.forEach(checkbox => {
      if (checkbox.checked) {
        atLeastOneChecked = true;
      }
    });

    // Apply styles to dropdown button immediately
    if (atLeastOneChecked) {
      dropdownButton.classList.remove('is-invalid');
      dropdownButton.classList.add('is-valid');
      errorDiv.style.display = "none"; // Hide error message
    } else {
      dropdownButton.classList.remove('is-valid');
      dropdownButton.classList.add('is-invalid');
      errorDiv.style.display = "block"; // Show error message
      form.classList.add('was-validated');
      return false;
    }

    // Validate Estimated Hours
    const estimatedHours = secondPage.querySelector('input[name="estimatedHours"]');
    if (!estimatedHours.checkValidity()) {
      estimatedHours.classList.add('is-invalid');
      form.classList.add('was-validated');
      return false;
    } else {
      estimatedHours.classList.remove('is-invalid');
      estimatedHours.classList.add('is-valid');
    }

    // Validate Deliver Before
    const deliverBefore = secondPage.querySelector('input[name="deliverBefore"]');
    if (!deliverBefore.checkValidity()) {
      deliverBefore.classList.add('is-invalid');
      form.classList.add('was-validated');
      return false;
    } else {
      deliverBefore.classList.remove('is-invalid');
      deliverBefore.classList.add('is-valid');
    }

    return true;
  }

  // Attach the validation function to checkbox clicks
  document.querySelectorAll('.assign-to-checkbox').forEach(checkbox => {
    checkbox.addEventListener('change', function() {
      validateSecondPage(); // Revalidate whenever a checkbox is clicked
    });
  });

  // Attach validation and button disabling to form submission
  document.getElementById('taskForm').onsubmit = function(event) {
    // Prevent form submission if validation fails
    if (!validateSecondPage()) {
      event.preventDefault();
    } else {
      // If validation passes, disable the submit button and show "Submitting..."
      disableSubmitButton();
    }
  };

  function disableSubmitButton() {
    var submitButton = document.getElementById('submitBtn');
    submitButton.classList.add("unclickable");
     
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
  </body>