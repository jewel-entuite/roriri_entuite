<cfdump var="test"><cfabort>
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
      .loading-container {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        height: 100px;
      }

      .spinner {
        border: 4px solid #f3f3f3; /* Light gray background */
        border-top: 4px solid #7d66e3; /* Blue spinner */
        border-radius: 50%;
        width: 30px;
        height: 30px;
        animation: spin 1s linear infinite;
        margin-bottom: 10px;
      }

      @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
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
      <div class=" d-flex align-items-center justify-content-between" style="margin-top:100px;">
        <div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-5">
          <section id="contact" class="contact">
            <div class="" data-aos="fade-up">
              <div class="section-title">
                  <h2 style="font-size: 24px;font-weight: 1000;padding-bottom: 0;line-height: 1px;margin-bottom: 15px;color: ##b3a6ed;">Project Management</h2>
                  <p>Task Details</p>
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
                 <cfinvoke component="models.timesheet" method="getTaskDetails" returnvariable="tasks">
                <cfinvoke component="models.timesheet" method="getAllProject" returnvariable="projectList"/>
                <cfinvoke component="models.timesheet" method="getStatus" returnvariable="getStatus">
                <cfinvoke component="models.employee" method="getAllemployeeForTask" returnvariable="allemployee">
                  <cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>

                  <!--- <cfdump var="#tasks#"><cfabort> --->
                <div class="d-flex justify-content-end">
                  <form action="add_task.cfm"  enctype="multipart/form-data" method="post">
                     <a type="submit" class="btn-outline-light mb-2 me-1 custom-btn sm btn mb-3" href="add_task.cfm" role="button" style="font-size: 0.9rem;">Add New Task</a>
                      <a type="submit" class="btn-outline-light mb-2 me-1 custom-btn sm btn mb-3" href="inactive_task_details.cfm" role="button" style="font-size: 0.9rem;">Inactive Tasks</a>
                  </form>
                </div>
                 <div class="shadow card p-3 ">
                  <div class="mb-2 ms-2 mt-2 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                      <label>TASK DETAILS</label>
                  </div>
                  <hr>
              <table class="table table-striped border-dark table-responsive-sm" id="assigned_task_details" style="overflow: hidden;">
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
                    <th style="width:5%">ACTION</th>
                  </tr>
                </thead>
                <tbody style="background-color:##FEF7F5" id="taskTable">
                   <tr class="filter-row">
                        <td colspan="2">
                          <input type="text" id="filter-taskId" class="form-control form-control-sm custom-background" placeholder="Search Task ID" onkeyup="filterTable()">
                        </td>
                        <td>
                          <select id="filter-project" class="form-select form-select-sm custom-background" onchange="filterTable()">
                            <option value="">All</option>
                            <cfloop query="projectList">
                              <option value="#projectList.name#">#projectList.name#</option>
                            </cfloop>
                          </select>
                        </td>
                        <td>
                          <input type="text" id="filter-module" class="form-control form-control-sm custom-background" placeholder="Search Module" onkeyup="filterTable()">
                        </td>
                        <td>
                          <input type="text" id="filter-scope" class="form-control form-control-sm custom-background" placeholder="Search Scope" onkeyup="filterTable()">
                        </td>
                        <td>
                          <select id="filter-priority" class="form-select form-select-sm custom-background" onchange="filterTable()">
                            <option value="">All</option>
                            <option value="High">High</option>
                            <option value="Medium">Medium</option>
                            <option value="Low">Low</option>
                          </select>
                        </td>
                        <td>
                          <div class="filter-container">
                            <select id="filter-assigner" class="form-select form-select-sm custom-background" onchange="filterTable()">
                              <option value="">All</option>
                              <cfloop query="assgnBy">
                                <option value="#assgnBy.id#">#assgnBy.first_name# #assgnBy.last_name#</option>
                              </cfloop>
                            </select>
                            <input type="date" id="filter-assigneddate" class="form-control form-control-sm custom-background mt-2" onchange="filterTable()">
                          </div>
                        </td>
                        <td>
                          <select id="filter-taskstatus" class="form-select form-select-sm custom-background" onchange="filterTable()">
                            <option value="">All</option>
                            <cfloop query="getStatus">
                              <option value="#getStatus.id#">#getStatus.status#</option>
                            </cfloop>
                          </select>
                        </td>
                        <td>
                          <select id="filter-handler" class="form-select form-select-sm custom-background" onchange="filterTable()">
                            <option value="">All</option>
                            <cfloop query="allemployee">
                              <option value="#allemployee.id#"<cfif structKeyExists(url, "task_id") AND getTaskDetail.assignTo NEQ "" AND getTaskDetail.assignTo EQ allemployee.id>selected</cfif>>#allemployee.first_name# #allemployee.last_name#</option>
                            </cfloop>
                          </select>
                        </td>
                        <td>
                          <select id="filter-handlerStatus" class="form-select form-select-sm custom-background" onchange="filterTable()">
                            <option value="">All</option>
                            <cfloop query="getStatus">
                              <option value="#getStatus.id#">#getStatus.status#</option>
                            </cfloop>
                          </select>
                        </td>
                        <td colspan="2">
                          <input type="date" id="filter-eta" class="form-control form-control-sm custom-background" onchange="filterTable()">
                        </td>
                        <td></td>
                      </tr>
                  <cfif queryRecordCount(tasks) GT 0>
                    <cfset index = 1>
                    <cfloop query="tasks">
                      <cfinvoke component="models.timesheet" taskId="#tasks.task_id#" emp_id="#tasks.assignTo#" method="getWorkedHours" returnvariable="workedHours">
                      <cfinvoke component="models.tasks" method="getTaskData" taskId="#tasks.task_id#" needfulltasks="true" returnvariable="userTaskData" />
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
                      <!--- <cfset userDataStruct = deserializeJSON(userTaskData)[tasks.project_name][tasks.module_name][1]/> --->
                      <!--- <cfif queryRecordCount(userTaskData) GT 0>
                        <cfset userDataStruct = deserializeJSON(userTaskData)[tasks.project_name][tasks.module_name][1]/>
                      <cfelse>
                        <cfset userDataStruct = {} />
                      </cfif> --->
                      <tr class="text-center">
                        <td class="custom-font-size align-middle"><b>#index#</b></td>

                        <td class="custom-font-size align-middle"><b><a href="##" class="task-link" data-task-hex="#tasks.task_id#" data-task-id="#encrypt(tasks.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" data-bs-toggle="modal" data-bs-target="##taskTimelineModal">#tasks.task_id#</a></b></td>

                        <td class="custom-font-size text-sm-start align-middle"><b>#UCase(tasks.project_name)#</b></td>
                        <td class="custom-font-size text-sm-start align-middle">#uCase(tasks.module_name)#</td>
                        <td class="custom-font-size text-sm-start align-middle">
                          <cfset taskWords = ListToArray(tasks.taskDescription, " ")>
                          <cfif ArrayLen(taskWords) GT 10>
                              <!-- Display first 10 words and show full description in popover -->
                              <span 
                                  data-bs-toggle="popover" 
                                  data-bs-trigger="hover focus" 
                                  data-bs-content="#EncodeForHtmlAttribute(tasks.taskDescription)#" 
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
                        <div class="d-flex align-items-center ">
                         <form method="post" action="add_task.cfm?task_id=#encrypt(tasks.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"class="me-1">
                          <span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="Disabled">
                              <button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit">
                                  <i class="bi bi-pencil-square"></i>
                              </button>
                            </span>
                              <input type="hidden" name="url_data" value='#serializeJSON(URL)#'> 
                         </form>
                         <form action="../controller/_task.cfm" method="post">
                              <button 
                                type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" data-task-id="#tasks.task_id#" onclick="openDeleteModal(this,#index#)">
                                <i class="bi bi-trash"></i>
                              </button>
                          </div>
                          <div class="modal fade" id="deleteModal#index#" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                              <div class="modal-content">
                                <form action="../controller/_task.cfm" method="post">
                                  <div class="modal-header">
                                      <h5 class="modal-title" id="deleteModalLabel"><strong>Confirm Deletion</strong></h5>
                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                  </div>
                                  <div class="modal-body">
                                    Are you sure you want to delete this Task?
                                  </div>
                                  <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" style="background-color: ##31394F; color: ##ffffff;" data-bs-dismiss="modal">Cancel</button>
                                       <button type="submit" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                                  </div>
                                  <input type="hidden" name="action" value="delete">
                                  <input type="hidden" name="task_id" value="#task_id#">
                                </form>
                              </div>
                          </div>
                      </div>
                    </form>
                    </td>
                  </tr>
                  <cfset index++>
                  </cfloop>
                <cfelse>
                  <tr>
                    <td colspan="12" align="center">No records found</td>
                  </tr>
                  </cfif>
                </tbody>
              </table>
              <div class="row">
                <div class="col-3 me-5" style="align-self: flex-end;"></div>
                    <div class="col-6 d-flex align-items-center" style="height: 40px; padding-left: 250px; font-family: Inter, sans-serif;">
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
                    <input type="text" class="form-control ms-1 mb-4 mt-3 pe-5" id="record-info" value="Total Record: #queryRecordCount(tasks)#" readonly  
                        style="border: 1px solid ##ccc; padding: 5px; width: 225px; text-align: left; background-color: ##f9f9f9; font-size: 0.875rem; font-family: Inter, sans-serif; padding-right: 0rem !important; padding-left:3px;">
                    </div>
                </div>
             </div>
         
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
      <!-- Task Timeline Modal -->
      <div class="modal fade" id="taskTimelineModal" tabindex="-1" aria-labelledby="taskTimelineModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" >
          <div class="modal-content" >
            <div class="modal-header">
              <h5 class="modal-title" id="taskTimelineModalLabel">Task History</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
              </button>
            </div>
            <div class="modal-body" id="modalTaskDetails">
              <div class="loading-container">
                <div class="spinner"></div>
                <p style="font-weight: bold; font-family: Raleway, sans-serif;">Loading task details...</p>
              </div>
            </div>
           </div>
      </div>
    </div>
    </cfoutput>
    <script>
        // const deliverBefore = document.getElementById("deliverBefore");
        // const estimatedHoursInput = document.getElementById("estimatedHours");

        // const BUSINESS_START_HOUR = 9.5; // 9:30 AM in decimal
        // const BUSINESS_END_HOUR = 18.5;  // 6:30 PM in decimal
        // const WORK_HOURS_PER_DAY = BUSINESS_END_HOUR - BUSINESS_START_HOUR; // Total business hours in a day

        // function calculateBusinessDate(hoursToAdd) {
        //     let current = new Date();

        //     // If current time is outside business hours, adjust to the next business day start time
        //     if (current.getHours() + current.getMinutes() / 60 < BUSINESS_START_HOUR) {
        //         current.setHours(9, 30, 0, 0); // Set to 9:30 AM today
        //     } else if (current.getHours() + current.getMinutes() / 60 >= BUSINESS_END_HOUR) {
        //         // Move to the next day at 9:30 AM
        //         current.setDate(current.getDate() + 1);
        //         current.setHours(9, 30, 0, 0);
        //     }

        //     while (hoursToAdd > 0) {
        //         const currentHour = current.getHours() + current.getMinutes() / 60;

        //         if (currentHour >= BUSINESS_START_HOUR && currentHour < BUSINESS_END_HOUR) {
        //             const remainingBusinessHoursToday = BUSINESS_END_HOUR - currentHour;

        //             if (hoursToAdd <= remainingBusinessHoursToday) {
        //                 // Add hours within today's business hours
        //                 current.setHours(current.getHours() + Math.floor(hoursToAdd), current.getMinutes() + (hoursToAdd % 1) * 60);
        //                 hoursToAdd = 0;
        //             } else {
        //                 // Use up all business hours for today and move to the next business day
        //                 hoursToAdd -= remainingBusinessHoursToday;
        //                 current.setDate(current.getDate() + 1);
        //                 current.setHours(9, 30, 0, 0); // Start at 9:30 AM the next business day
        //             }
        //         } else {
        //             // If outside business hours, move to the next business day
        //             current.setDate(current.getDate() + 1);
        //             current.setHours(9, 30, 0, 0);
        //         }

        //         // Skip weekends
        //         if (current.getDay() === 6) { // Saturday
        //             current.setDate(current.getDate() + 2); // Move to Monday
        //         } else if (current.getDay() === 0) { // Sunday
        //             current.setDate(current.getDate() + 1); // Move to Monday
        //         }
        //     }

        //     // Format the calculated date for the datetime-local input
        //     const year = current.getFullYear();
        //     const month = String(current.getMonth() + 1).padStart(2, '0');
        //     const day = String(current.getDate()).padStart(2, '0');
        //     const hours = String(current.getHours()).padStart(2, '0');
        //     const minutes = String(current.getMinutes()).padStart(2, '0');

        //     return `${year}-${month}-${day}T${hours}:${minutes}`;
        // }

        // function updateDeliverBefore() {
        //     const hoursToAdd = parseFloat(estimatedHoursInput.value);
        //     if (!isNaN(hoursToAdd) && hoursToAdd > 0) {
        //         deliverBefore.value = calculateBusinessDate(hoursToAdd);
        //     }
        // }

        // // Set initial calculated business date based on default hours
        // updateDeliverBefore();

        // // Listen for changes on the estimated hours input
        // estimatedHoursInput.addEventListener("input", updateDeliverBefore);

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

  function openDeleteModal(button, index) {
    // Get the task ID from the button's data attribute
    const taskId = button.getAttribute('data-task-id');
    console.log('Task ID:', taskId);
    window.deleteTaskId = taskId; // Store task ID globally for form submission

    // Update the modal's body content with the specific task ID
    const modalBody = document.querySelector(`#deleteModal${index} .modal-body`);
    modalBody.innerHTML = `Are you sure you want to delete the Task <strong style="color: #eb5d1e;">${taskId}</strong>?`;

    // Show the modal
    const deleteModal = new bootstrap.Modal(document.getElementById(`deleteModal${index}`));
    deleteModal.show();
}

// Form submission logic
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


        
function filterTable() {
  const table = document.getElementById("taskTable");
  const rows = table.getElementsByTagName("tr");

  // Task Status Mapping
  const taskStatusMap = {
    "1": "completed",
    "2": "in progress",
    "3": "re-opened",
    "4": "r&d",
    "5": "in testing",
    "6": "qa",
    "7": "delivered",
    "8": "to do",
    "9": "yet to start",
    "10": "not assigned",
    "11": "assigned",
    "12": "re-assigned",
  };

  // Handler ID Mapping (normalize all handler names to lowercase for easy lookup)
  const handlerIdMap = {
    "archana rd":"38",
    "askar k": "33",
    "entuite test": "37",
    "jerin john j": "27",
    "jewel john": "3",
    "mariselvam m": "29",
    "muraliram sankaran": "32",
    "naveen kumar": "5",
    "roger franson": "30",
    "santosh kumar s": "26",
    "thanumalayan iyappan": "1",
    "sooraj edwin": "2",
    "testing user": "36",
  };

  const handlerStatusMap = {
    "1": "completed",
    "2": "in progress",
    "3": "re-opened",
    "4": "r&d",
    "5": "in testing",
    "6": "qa",
    "7": "delivered",
    "8": "to do",
    "9": "yet to start",
    "10": "not assigned",
    "11": "assigned",
    "12": "re-assigned",
  };

  const filters = {
    taskId: document.getElementById("filter-taskId").value.trim().toLowerCase(),
    project: document.getElementById("filter-project").value.trim().toLowerCase(),
    module: document.getElementById("filter-module").value.trim().toLowerCase(),
    scope: document.getElementById("filter-scope").value.trim().toLowerCase(),
    priority: document.getElementById("filter-priority").value.trim().toLowerCase(),
    taskStatus: document.getElementById("filter-taskstatus").value.trim().toLowerCase(),
    assigner: [...document.getElementById("filter-assigner").querySelectorAll("option")]
      .filter(o => o.value === document.getElementById("filter-assigner").value)[0]
      ?.innerHTML.split(" ").shift().toLowerCase().trim() || "",
    handler: document.getElementById("filter-handler").value.trim().toLowerCase(),
    handlerStatus: document.getElementById("filter-handlerStatus").value.trim().toLowerCase(),
    eta: document.getElementById("filter-eta").value, 
    assignedDate: document.getElementById("filter-assigneddate").value,

  };

  filters.taskStatus = filters.taskStatus === "all" ? "" : filters.taskStatus;
  filters.assigner = filters.assigner === "all" ? "" : filters.assigner;
  filters.handlerStatus = filters.handlerStatus === "all" ? "" : filters.handlerStatus;

 function convertToDate(dateStr) {
  const months = {
    jan: 0, feb: 1, mar: 2, apr: 3, may: 4, jun: 5,
    jul: 6, aug: 7, sep: 8, oct: 9, nov: 10, dec: 11
  };

  
const cleanedDateStr = dateStr.replace(/\u00A0\d+\sHr\(s\)/, '').trim(); 
const parts = cleanedDateStr.split('-');

  if (parts.length === 3) {
    let day = parts[0].trim();
    let month = months[parts[1].toLowerCase().trim()];
    let year = "20" + parts[2].trim();

    if (month !== undefined) {
      year = year[0] + year[1] + year[2] + year[3];
      const formattedDate = new Date(year, month, day);

      const utcDate = new Date(Date.UTC(year, month, day));
      
      if (!isNaN(utcDate)) {
        return utcDate.toISOString().split('T')[0]; // Return in 'YYYY-MM-DD' format
      } else {
        // console.error("Invalid date:", formattedDate);
      }
    } else {
      // console.error("Invalid month:", parts[1]);
    }
  } else {
    // console.error("Invalid date format:", cleanedDateStr);
  }

  return '';
}
 const filterEta = filters.eta ? new Date(filters.eta).toISOString().split('T')[0] : ""; 
 const filterAssignedDate = filters.assignedDate ? new Date(filters.assignedDate).toISOString().split('T')[0] : ""; 


  for (let i = 1; i < rows.length; i++) {
    const row = rows[i];
    const cells = row.getElementsByTagName("td");

    const taskId = cells[1]?.textContent.trim().toLowerCase() || "";
    const project = cells[2]?.textContent.trim().toLowerCase() || "";
    const module = cells[3]?.textContent.trim().toLowerCase() || "";
    const scope = cells[4]?.textContent.trim().toLowerCase() || "";
    const priority = cells[5]?.textContent.trim().toLowerCase() || "";
    const taskStatus = cells[7]?.textContent.replace(/\s+/g, " ").trim().toLowerCase() || "";
    let assignerText  = cells[6]?.textContent.toLowerCase().trim() || ""; 
    let assigner = assignerText.split("\n").shift().toLowerCase().trim();
    let assignerDate = convertToDate(assignerText.split("\n").pop().toLowerCase().trim());
    const handler = cells[8]?.textContent.replace(/\s+/g, " ").trim().toLowerCase() || "";
    const handlerStatus = cells[9]?.textContent?.trim().toLowerCase() || "";
    const eta = cells[10]?.textContent.trim() || "";
    const formattedEta = convertToDate(eta);
     // const assignedDate = cells[11]?.textContent.trim() || "";


    const filterTaskStatusText = taskStatusMap[filters.taskStatus] || ""; 
    const isTaskStatusMatch = filterTaskStatusText === "" || taskStatus === filterTaskStatusText;

    const normalizedHandler = handler.split(" ")[0].toLowerCase();
    const handlerIdFromMap = Object.keys(handlerIdMap).find(key => key.toLowerCase().startsWith(normalizedHandler)); 
    const isHandlerMatch = filters.handler === "" || handlerIdFromMap && handlerIdMap[handlerIdFromMap] === filters.handler;

    const filterHandlerStatusText = handlerStatusMap[filters.handlerStatus] || "";
    const isHandlerStatusMatch = filterHandlerStatusText === "" || handlerStatus === filterHandlerStatusText;

    // Check matches
    const isMatch =
      (filters.taskId === "" || taskId.includes(filters.taskId)) &&
      (filters.project === "" || project.includes(filters.project)) &&
      (filters.module === "" || module.includes(filters.module)) &&
      (filters.scope === "" || scope.includes(filters.scope)) &&
      (filters.priority === "" || priority.includes(filters.priority)) &&
      isTaskStatusMatch &&
      (filters.assigner === "" || assigner.includes(filters.assigner)) &&
      isHandlerMatch &&
      isHandlerStatusMatch &&
      (filterEta === "" || formattedEta === filterEta) &&
      (filterAssignedDate === "" || assignerDate === filterAssignedDate);

       row.style.display = isMatch ? "" : "none";
  }
}

//pagination
     let pageSize = 11; // Default number of records per page
     let currentPage = 1;
     const rows = document.querySelectorAll("#assigned_task_details tbody tr");
     const totalRows = rows.length;
    let totalPages = Math.ceil(totalRows / pageSize);

// Function to display a specific page
function showPage(page)
 {
    if (page < 1 || page > totalPages) return; // Ensure valid page number
    currentPage = page;

    const start = (page - 1) * pageSize;
    const end = page * pageSize;

    rows.forEach((row, index) => {
        // Keep the filter row always visible
        if (row.classList.contains('filter-row')) {
            row.style.display = '';
        } else {
            row.style.display = index >= start && index < end ? '' : 'none';
        }
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

document.addEventListener('DOMContentLoaded', function() {
    const taskLinks = document.querySelectorAll('.task-link');

    taskLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            event.preventDefault();

            // Get the encrypted task ID
            const taskId = link.getAttribute('data-task-id');
             const task_Id = link.getAttribute('data-task-hex');
            // Make an AJAX request to fetch task details
            fetch(`history.cfm?task_id=${task_Id}&popup=1`)
                .then(response => response.text())
                .then(data => {
                    // Inject the fetched data into the modal
                    const modalContent = document.getElementById('modalTaskDetails');
                    modalContent.innerHTML = data;
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Error fetching task details:', error);
                });
        });
    });
});


</script>
</body>
</html>