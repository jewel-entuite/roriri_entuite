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
      .popover {
          background-color: #fffaf7 !important; 
          border: 1px solid #7d66e3;           
          font-color: #7d66e3 !important;   
          border-radius: 5px;
      }

      .popover .popover-arrow {
         --bs-popover-arrow-color: #7d66e3 !important;
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
      <cfinvoke component="models.employee" method="getAllemployeeForTask" returnvariable="allemployee">
      <cfinvoke component="models.pagination" method="PaginationScript" tableId="inactive_TaskDetails" returnvariable="PaginationScript">
      <cfinvoke component="models.pagination" method="Pagination" returnvariable="paginationNav">
      <cfinvoke component="models.pagination" method="RowCount" returnvariable="paginationRowcount">
      <cfinvoke component="models.pagination" method="PageInfo" returnvariable="totalRowcount">
      <cfinvoke component="models.pagination" method="GoToPagination" returnvariable="gotopage">  
      <div class=" d-flex align-items-center justify-content-between" style="margin-top:100px;">
        <div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-5">
          <section id="contact" class="contact">
            <div class="" data-aos="fade-up">
              <div class="section-title">
                  <h2 style="font-size: 24px;font-weight: 1000;padding-bottom: 0;line-height: 1px;margin-bottom: 15px;color: ##b3a6ed;">Project Management</h2>
                  <p>Inactive Task Details</p>
              </div>
              <div class="m-5 my-0">
                <style>
                  table{
                    border: 5px solid black;
                    border-radius: 20px;
                  }
                  .custom-font-size{
                    font-size: small;
                  }
                </style>
                 <cfinvoke component="models.timesheet" method="inactiveTaskDetails" returnvariable="tasks"> 
                <div class="d-flex justify-content-end">
                  <form action="add_task.cfm"  enctype="multipart/form-data" method="post">
                    <!--- <button type="submit" class="btn btn-outline-white mb-3" style="font-size:small; vertical-align: middle; background-color: ##ee7843; Color:white;">Add New Task</button> --->
                     <a type="submit" class="btn-outline-light mb-2 me-1 custom-btn sm btn mb-3" href="add_task.cfm" role="button" style="font-size: 0.9rem;">New Task</a>
                     <a type="submit" class="btn-outline-light mb-2 me-1 custom-btn sm btn mb-3" href="assigned_task_details.cfm" role="button" style="font-size: 0.9rem;">Task Listing</a>
                  </form>
                </div>
                 <div class="shadow card p-3 ">
                  <div class="mb-2 ms-2 mt-2 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                      <label>INACTIVE TASK DETAILS</label>
                  </div>
                  <hr>
              <table class="table table-striped border-dark table-responsive-sm" style="overflow: hidden;">
                <thead style="background-color:##31394F;">
                  <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                    <th>SL.N0</th>
                    <th style="width: 10%;">TASK ID</th>
                    <th style="width: 8%;">PROJECT</th>
                    <th style="width:4%">MODULE</th>
                    <th>SCOPE</th>
                    <th style="width: 5%;">PRIORITY</th>
                    <th style="width: 7%;">ASSIGNER</th>
                    <th style="width: 7%;">STATUS</th>
                    <th style="width:8%">HANDLERS</th>
                    <th style="width: 6%;">HANDLER'S STATUS</th>
                    <th style="width:8%">ETA</th>
                    <th style="width:6%">WORKED HOURS</th>
                    <th style="width:5%">REVOKE</th>
                    <!--- <th style="width:5%">ACTION</th> --->
                  </tr>
                </thead>
                <tbody style="background-color:##FEF7F5">
                  <cfif queryRecordCount(tasks) GT 0>
                    <cfset index = 1>
                    <cfoutput query="tasks">
                      <cfinvoke component="models.timesheet" taskId="#tasks.task_id#" emp_id="#tasks.assignTo#" method="getWorkedHours" returnvariable="workedHours">
                      <cfinvoke component="models.tasks" method="getTaskData" taskId="#tasks.task_id#" needfulltasks="true" returnvariable="userTaskData" />
                      <!--- <cfdump var="#userTaskData#"><cfabort> --->
                      <cfif structKeyExists(url, "debug")>
                        <cfdump var="#deserializeJSON(userTaskData)#">
                      </cfif>
                      <cfif NOT isJSON(userTaskData) OR structIsEmpty(deserializeJSON(userTaskData))>
                        <cfset userDataStruct = {} />
                      <cfelse>
                        <cfset jsonResData = deserializeJSON(userTaskData)>
                        <cfset jsonData = jsonResData.fullData />
                        <cfif structKeyExists(jsonData, tasks.project_name) AND structKeyExists(jsonData[tasks.project_name], tasks.module_name)>
                          <cfset userDataStruct = jsonData[tasks.project_name][tasks.module_name][1]>
                        <cfelse>
                          <cfset userDataStruct = {} />
                        </cfif>
                      </cfif>
                     
                      <tr class="text-center">
                        <td class="custom-font-size align-middle"><b>#index#</b></td>
                        <td class="custom-font-size align-middle"><b><a href="add_task.cfm?task_id=#encrypt(tasks.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">#tasks.task_id#</a></b></td>
                        <td class="custom-font-size text-sm-start align-middle"><b>#UCase(tasks.project_name)#</b></td>
                        <td class="custom-font-size text-sm-start align-middle">#uCase(tasks.module_name)#</td>
                        <td class="custom-font-size text-sm-start align-middle">
                          <cfset taskWords = ListToArray(tasks.taskDescription, " ")>
                          <cfif ArrayLen(taskWords) GT 10>
                              <!-- Display first 10 words and show full description in popover -->
                              <span 
                                  data-bs-toggle="popover" 
                                  data-bs-trigger="hover focus" 
                                  data-bs-content="#tasks.taskDescription#" 
                                  title="Scope"
                                  style="cursor: pointer;">
                                  #ArrayToList(ArraySlice(taskWords, 1, 10), " ")#...
                              </span>
                          <cfelse>
                              <!-- Show the full description if it's 10 words or fewer -->
                              #tasks.taskDescription#
                          </cfif>
                        </td>
                        <td class="custom-font-size align-middle" <cfif tasks.priority EQ "High">style="color: red;"<cfelseif tasks.priority EQ "Medium">style="color: ##e3c541;"<cfelse>style="color: seagreen;"</cfif>><b>#tasks.priority#</b></td>
                         <cfif tasks.assignor NEQ "" AND tasks.assigned_on NEQ "">
                          <td class="custom-font-size align-middle">
                              #tasks.assignor#<br>
                              <b style="color: crimson;">
                                  #dateformat(tasks.assigned_on, 'dd-mmm-yy')#
                              </b>
                          </td>
                      <cfelse>
                          <td class="custom-font-size align-middle">-</td>
                      </cfif>

                          <cfset statusColor = "">

                          <cfif tasks.status == "Completed">
                              <cfset statusColor = "##6C9F6E">
                          <cfelseif tasks.status == "In Progress">
                              <cfset statusColor = "##5A8AB1">
                          <cfelseif tasks.status == "Re-opened">
                              <cfset statusColor = "##FF7D5B">
                          <cfelseif tasks.status == "R&D">
                              <cfset statusColor = "##9E4F9F">
                          <cfelseif tasks.status == "In Testing">
                              <cfset statusColor = "##E3C57E">
                          <cfelseif tasks.status == "QA">
                              <cfset statusColor = "##6CA8A7">
                          <cfelseif tasks.status == "Delivered">
                              <cfset statusColor = "##8C9F7B">
                          <cfelseif tasks.status == "To Do">
                              <cfset statusColor = "##F1A36B">
                          <cfelseif tasks.status == "Yet to Start">
                              <cfset statusColor = "##F49393">
                          <cfelseif tasks.status == "Not Assigned">
                              <cfset statusColor = "##F07474">
                          <cfelseif tasks.status == "Assigned">
                              <cfset statusColor = "##76B7C7">
                          <cfelseif tasks.status == "Re-Assigned">
                              <cfset statusColor = "##D190D7">
                          </cfif>
                        <td class="custom-font-size align-middle" style="color: #statusColor#;"><b>#tasks.status#</b></td>
                        <cfif tasks.first_name NEQ "">
                          <td class="custom-font-size align-middle">#tasks.first_name#</td>
                        <cfelse>
                          <td data-bs-toggle="tooltip" title="Assign Task">
                            <button type="button" class="btn btn-outline-dark btn-sm assign-task-button" data-bs-toggle="modal" data-bs-target="##staticBackdrop" data-task-id="#tasks.task_id#">
                              <i class="bi bi-person-fill-add"></i>
                            </button>
                          </td>
                        </cfif>
                        <cfif structKeyExists(userDataStruct, "status") AND len(userDataStruct["status"])>
                          <td class="custom-font-size align-middle"><b>#userDataStruct["status"]#</b></td>
                        <cfelse>
                          <td>-</td>
                        </cfif>
                        <cfif tasks.deliverBefore NEQ "" AND tasks.estimatedHours NEQ "">
                          <td class="custom-font-size align-middle"><b style="color: crimson;">#dateformat(tasks.deliverBefore, 'dd-mmm-yy')#</b><br>#tasks.estimatedHours# Hr(s)</td>
                        <cfelse>
                          <td class="custom-font-size align-middle">-</td>
                        </cfif>

                        <cfset workedHoursInMinutes = 0>
                        <cfif find("hour", workedHours)>
                            <cfset workedHoursInMinutes = workedHoursInMinutes + (Val(replace(workedHours, " hours", "")) * 60)>
                        </cfif>
                        <cfif find("minute", workedHours)>
                            <cfset workedHoursInMinutes = workedHoursInMinutes + Val(replace(workedHours, " minutes", ""))>
                        </cfif>
                        <cfif workedHoursInMinutes EQ 0>
                          <td class="custom-font-size align-middle">-</td>
                        <cfelse>
                          <td class="custom-font-size align-middle" style="<cfif workedHoursInMinutes GT (tasks.estimatedHours * 60)>background-color: ##edb4b9;<cfelse>background-color: ##d4edda;</cfif>">#workedHours#</td>
                        </cfif>
                        <td class="align-middle">
                            <div class="d-flex justify-content-center">
                                <!-- Form for Revoke Action -->
                                <form action="../controller/_task.cfm" method="post" class="me-1">
                                  <span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="Revoke">
                                        <button type="button"  class="btn btn-outline-success btn-sm"  data-task-id="#task_id#"data-bs-toggle="tooltip" data-bs-placement="top" title="Revoke" onclick="openRevokeModal(this, #index#)">
                                            <i class="bi bi-reply"></i>
                                        </button>
                                    </span>
                                </form>
                            </div>
                                <!-- Revoke Modal -->
                                <div class="modal fade" id="revokeModal#index#" tabindex="-1" aria-labelledby="revokeModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                           <!---  <form action="../controller/_task.cfm" method="post">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="revokeModalLabel"><strong>Revoke Task</strong></h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure you want to revoke this task?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">No</button>
                                                    <button type="submit" class="btn btn-outline-success" id="confirmRevokeBtn">Yes</button>
                                                </div>
                                                <input type="hidden" name="action" value="revoke">
                                                <input type="hidden" name="task_id" value="#task_id#">
                                            </form> --->
                                            <form action="../controller/_task.cfm" method="post">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="revokeModalLabel"><strong>Revoke Task</strong></h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure you want to revoke this Task?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">No</button>
                                                    <button type="submit" class="btn btn-outline-success">Yes</button>
                                                </div>
                                                <input type="hidden" name="action" value="revoke">
                                                <input type="hidden" name="task_id" value="">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                          </td>  
                  </tr>
                  <cfset index++>
                  </cfoutput>
                <cfelse>
                  <tr>
                    <td colspan="12" align="center">No records found</td>
                  </tr>
                  </cfif>
                </tbody>
              </table>
              <div class="row ms-5 ps-5">

                <div class="col-3"></div>
                <div class="col-3">
                  <cfoutput>#gotopage#</cfoutput>
                </div>
                <div class="col-3">
                  <cfoutput>#paginationNav#</cfoutput>
                </div>
                <div class="col-3 ps-5 pe-1">
                  <cfoutput>#totalRowcount#</cfoutput>
                </div>
              </div>
                <!-- Modal -->
                <form action="../controller/_timesheet.cfm" method="post">
                  <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title" id="staticBackdropLabel" style="color:##7d66e3;">Assign Handler</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                          <input type="hidden" name="assignEmp">
                          <input type="hidden" name="task_id" id="modalTaskId">
                          <cfloop query="allemployee">
                            <div class="row">
                              <div>
                                <input type="checkbox" value="#allemployee.id#" name="Employee">
                                <label for="employee" class="custom-font-size">#allemployee.first_name#</label>
                              </div>
                            </div>
                          </cfloop>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                          <button type="submit" class="btn btn-primary">Assign Task</button>
                        </div>
                      </div>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </section>
          </div>
        </div>
      </div>
    </cfoutput>
    <cfoutput>#PaginationScript#</cfoutput>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
          // Attach event listener to each "Assign Task" button
          document.querySelectorAll(".assign-task-button").forEach(button => {
            button.addEventListener("click", function() {
              const taskId = this.getAttribute("data-task-id");
              document.getElementById("modalTaskId").value = taskId;
            });
          });
        });

        document.addEventListener("DOMContentLoaded", function () {
          var popoverTriggers = document.querySelectorAll('[data-bs-toggle="popover"]');
          popoverTriggers.forEach(function (popoverTrigger) {
              new bootstrap.Popover(popoverTrigger);
          });
        });

        function openDeleteModal(button) {
          const taskId = button.getAttribute('data-task-id');
           console.log('Task ID:', taskId);  
          window.deleteTaskId = taskId; 
          

          const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal')); // Open modal
          deleteModal.show();
      }
        document.getElementById('confirmDeleteBtn').onclick = function () {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'assigned_task_details.cfm';

        // Create hidden input for action
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        form.appendChild(actionInput);

        // Create hidden input for task_id
        const taskIdInput = document.createElement('input');
        taskIdInput.type = 'hidden';
        taskIdInput.name = 'task_id';
        taskIdInput.value = window.deleteTaskId;
        form.appendChild(taskIdInput);

        document.body.appendChild(form);
        form.submit();
    };
      //  function openRevokeModal(button, index) {
      //   const modalId = `revokeModal${index}`;
      //   const modal = new bootstrap.Modal(document.getElementById(modalId));
      //   modal.show();
      // }
      function openRevokeModal(button, index) {
          // Get the task ID from the button's data attribute
          const taskId = button.getAttribute('data-task-id');
          console.log('Task ID:', taskId);

          // Show task ID in the modal confirmation body
          const modalBody = document.querySelector(`#revokeModal${index} .modal-body`);
          modalBody.innerHTML = `Are you sure you want to revoke the Task <strong style="color: #7d66e3;">${taskId}</strong>?`;

          // Set the task ID in the hidden input inside the form
          const hiddenTaskIdInput = document.querySelector(`#revokeModal${index} input[name="task_id"]`);
          hiddenTaskIdInput.value = taskId;

          // Show the modal
          const modal = new bootstrap.Modal(document.getElementById(`revokeModal${index}`));
          modal.show();
      }

  </script>
  </body>
</html>