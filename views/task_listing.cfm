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
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
      }

      .sidebar {
        width: 300px;
        background-color: #ffffff;
        border-right: 1px solid #e0e0e0;
        position: fixed;
        height: 100%;
        overflow-y: auto;
        padding: 20px;
      }

      .sidebar h2 {
        font-size: 18px;
        color: #534980;
        margin-bottom: 10px;
      }

      .project {
        margin-bottom: 10px;
      }

      .project > ul {
        list-style: none;
        padding: 0;
      }

      .project > ul > li {
        cursor: pointer;
        padding: 5px 10px;
        background-color: #f5f5f5;
        margin: 5px 0;
        border-radius: 4px;
        color: #534980;
      }

      .project > ul > li:hover {
        background-color: #e0e0e0;
      }

      /* Main content styles */
      .main-content {
        margin-left: 320px;
        padding: 20px;
      }

      .note {
        text-align: center;
        font-size: 16px;
        color: #534980;
        margin-top: 50px;
      }

      
      .task-list {
          display: flex;
          justify-content: space-between; 
          height: calc(89vh - 40px);
          gap: 10px; 
          padding: 10px; 
          box-sizing: border-box;
      }

      .task-column {
          flex: 1; 
          min-width: 250px; 
          background-color: #ffffff;
          border: 1px solid #e0e0e0;
          border-radius: 8px;
          padding: 10px;
          box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
          overflow-y: auto; 
      }

      .task-column h3 {
          font-size: 18px;
          color: #534980;
          margin-bottom: 10px;
          text-align: center;
      }

      
      @media (max-width: 768px) {
          .task-list {
              flex-direction: column; / Stack columns vertically /
              height: auto; / Allow full content height /
          }

          .task-column {
              width: 100%; / Full width for each column /
              height: auto; / Adjust to content height /
          }
      }


      .task {
        padding: 10px;
        margin: 10px 0;
        background-color: #f5f5f5;
        border-radius: 4px;
        color: #534980;
        cursor: grab;
        display: flex;
        flex-direction: column;
      }

      .task:hover {
        background-color: #e0e0e0;
      }

      .task[draggable="true"] {
        cursor: grabbing;
      }

      .task-column.drop-zone {
        border: 2px #534980;
      }

      .task-column.drop-zone:hover {
        background-color: #f9f9f9;
      }

      .task span {
        font-size: 14px;
        margin: 4px 0;
      }

      .priority {
        color: red; 
        font-weight: bold;
      }
      .taskID {
        color: #a64e26;
        font-weight: bold;
      }

      .eta {
        color: #534980;
      }
      #loader {
          position: fixed;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          z-index: 9999;
          cursor: not-allowed;
        }
       #overlay {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
          z-index: 9999; /* Lower z-index */
          cursor: not-allowed;
        }

        #successAlert {
          position: fixed;
          top: 50%; /* Vertically center */
          left: 50%; /* Horizontally center */
          transform: translate(-50%, -50%); /* Adjust position by 50% of its own width and height */
          z-index: 2000; /* Higher z-index to appear above the overlay */
          display: none; /* Initially hidden */
        }
        .history_button{
          background: #7d66e3;
          border:0;
          padding:10px 24px;
          color:#fff;
          transition:0.4s;
          border-radius:4px;
          float: right;
        }
        .modal-custom-label{
          font-size: small; 
          font-family: 'Raleway', sans-serif;
          font-weight: bold;
        }
        .custom-font-size{
          font-size: small;
        }
        .custom-tooltip .tooltip-inner {
            background-color: #ffffff !important; 
            color: #7d66e3 !important;                  
            border: 1px solid #7d66e3;          
            padding: 8px;                      
            border-radius: 5px;                 
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); 
        }

        .custom-tooltip .tooltip-arrow {
            border-top-color: #7d66e3 !important;
            border-right-color: #7d66e3 !important;
            border-bottom-color: #7d66e3 !important;
            border-left-color: #7d66e3 !important;
        }
        .popover {
            background-color: #e6e4f2 !important; 
            border: 1px solid #7d66e3;           
            font-color: #7d66e3 !important;   
            border-radius: 5px;
        }

        .popover .popover-arrow {
           --bs-popover-arrow-color: #7d66e3 !important;
        }

        .highlighted {
            background-color: #d5cfe9; /* Light blue background */
            font-weight: bold;
            border: 1px solid #a988e3;
        }
        .disabled-task {
          pointer-events: none; /* Disable interactions */
          opacity: 0.8; /* Slight transparency */
          cursor: not-allowed; /* Show disabled cursor */
          background-color: #dae3dd; /* Light red background for highlighting */
        }
        .module-item.highlighted {
          background-color: #d5cfe9; 
          font-weight: bold;
          border: 2px solid #a988e3; 
          padding: 5px 10px; 
          border-radius: 5px;  
        }
        .module-item.highlighted:hover{
          background-color: #e7e3f3;
        }


  </style>
  </head>
 <body>
    <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
    <!--- header --->
    <cfset active_status="employee_management">
    <cfinclude template="../includes/header/user_header.cfm" runonce="true">
    <!--- header ends --->
    <!--- <div style="height:72px;">&nbsp;</div> --->
    <cfoutput>

        <div id="overlay" style="display: none;"></div>
        <div id="loader" style="display: none;">
          <img src="../assets/img/loader.gif" width="50" height="50" alt="Loading...">
        </div>
        <!-- Sidebar -->
        <div class="sidebar mt-4">
            <h2><b>Projects</b></h2>
            <div id="project-list"></div>
        </div>

        <!-- Main Content -->
        <div class="main-content pt-5 mt-5">
            <div id="task-container">
            </div>
        </div>
        <!-- Modal -->
        <form action="../controller/_task.cfm" class="needs-validation" novalidate onsubmit="return customValidation()" method="post">
          <input type="hidden" name="taskStatus">
          <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="staticBackdropLabel" style="color:##ee7843; font-family:Arial, sans-serif;">Update Status -</h1>&nbsp;&nbsp;<div id="taskIdDiv" style="color:##ee7843; font-weight: bold;" class="fs-5"></div>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <div class="row m-2">
                    <div class="col-lg-3">
                      <label class="form-label modal-custom-label my-2">Project</label>
                      <input type="text" id="project" name="project" class="form-control custom-font-size" readonly>
                    </div>
                    <div class="col-lg-3">
                      <label class="form-label modal-custom-label my-2">Module</label>
                      <input type="text" id="module" name="module" class="form-control custom-font-size" readonly>
                    </div>
                    <div class="col-lg-3">
                      <label class="form-label modal-custom-label my-2">Task Type</label>
                      <input type="text" id="task_type" name="task_type" class="form-control custom-font-size" readonly>
                    </div>
                    <div class="col-lg-3">
                      <label class="form-label modal-custom-label my-2">Assigned By</label>
                      <input type="text" id="assigned_by" name="assigned_by" class="form-control custom-font-size" readonly>
                    </div>
                  </div>
                  <div class="row m-2">
                    <div class="col-lg-4">
                      <label class="form-label modal-custom-label my-2">Status</label>
                      <input type="text" id="status" name="status" class="form-control custom-font-size" readonly>
                    </div>
                     <div class="col-lg-4">
                      <label class="form-label modal-custom-label my-2">Start Date/Time</label>
                      <cfset minday= dateTimeFormat(dateAdd("d", -1, dateFormat(now())),"yyyy-mm-dd HH:nn")>
                      <input type="datetime-local" id="start_time" min="#minday#" name="start_time" class="form-control custom-font-size" required>
                      <div class="invalid-feedback">Start Time is required.</div>
                    </div>
                    <div class="col-lg-4">
                      <label class="form-label modal-custom-label my-2">End Date/Time</label>
                      <input type="datetime-local" id="end_time" min="#minday#" name="end_time" class="form-control custom-font-size" required>
                      <div class="invalid-feedback">End Time is required or must be after Start Time.</div>
                    </div>
                  </div>
                  <div class="row m-2">
                    <div class="col-lg-12">
                      <label class="form-label modal-custom-label my-2">Scope</label>
                      <textarea class="form-control custom-font-size" id="taskDescription" name="taskDescription" readonly></textarea>
                    </div>
                  </div>
                  <div class="row m-2">
                    <div class="col-lg-12">
                      <label class="form-label modal-custom-label my-2">Task Description</label>
                      <textarea class="form-control" id="dev_comments" name="dev_comments" required></textarea>
                      <div class="invalid-feedback">Description is required.</div>
                    </div>
                    <input type="hidden" id="project_id" name="project_id">
                    <input type="hidden" id="module_id" name="module_id">
                    <input type="hidden" id="status_id" name="status_id">
                    <input type="hidden" id="assigned_by_id" name="assigned_by_id">
                    <input type="hidden" id="task_id" name="task_id">
                    <input type="hidden" id="task_type_id" name="task_type_id">
                    <input type="hidden" id="emp_id" name="emp_id" value="#session.employee.id#">
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn  mx-2" style="font-size:small; vertical-align: middle; border-color:##ee7843; background-color:white; Color:##ee7843;" data-bs-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-outline-white mx-2" style="font-size:small; vertical-align: middle; background-color:##ee7843; Color:white;">Update Timesheet</button>
                </div>
              </div>
            </div>
          </div>
        </form>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
          $(document).ready(function () {
            document.getElementById("loader").style.display = 'block';
            document.getElementById("overlay").style.display = 'block';
              // Fetch data via AJAX
                $.ajax({
                    url: "../models/tasks.cfc",
                    type: "GET",
                    data:{
                      method:"getTaskData"
                    },
                    success: function (data) {
                      document.getElementById("loader").style.display = 'none';
                      document.getElementById("overlay").style.display = 'none';
                      console.log(JSON.parse(data));
                        populateProjects(JSON.parse(data));
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching data:", error);
                    }
                });

              function populateProjects(response) {
                let data = response["fullData"];
                let recentAssignedModule = response["recentAssignedModule"];
                
                if (Object.keys(data).length === 0) {
                    $("##task-container").html('<div class="note">No task has been assigned to you at the moment.</div>');
                    return;
                }

                // Iterate through projects
                $.each(data, function (project, modules) {
                    const projectElement = $(`
                        <div class="project">
                            <h5 style="font-family: 'Raleway', sans-serif; color:##7d66e3;">${project}</h5>
                        </div>
                    `);
                    const moduleList = $('<ul></ul>');

                    $.each(modules, function (module, tasks) {
                        const moduleItem = $(`<li class="module-item">${module}</li>`);

                        // Attach click listener to load tasks on demand and highlight the clicked module
                        moduleItem.on("click", function () {
                            // Remove highlight from previously selected module
                            $(".module-item").removeClass("highlighted");

                            // Add highlight to the clicked module
                            $(this).addClass("highlighted");

                            if (Array.isArray(tasks)) {
                                loadTasks(tasks);
                            } else {
                                console.warn("Expected an array of tasks, but got:", tasks);
                            }
                        });

                        moduleList.append(moduleItem);

                        // Automatically load the tasks for the first (most recent) module and highlight it
                        if (recentAssignedModule == module) {
                            moduleItem.addClass("highlighted");  // Highlight recent assigned module by default
                            loadTasks(tasks); // Ensure this happens only once
                        }
                    });

                    projectElement.append(moduleList);
                    $("##project-list").append(projectElement);
                });
            }


              function loadTasks(tasks) {
                const taskContainer = $("##task-container");

                 console.log("Tasks received:", tasks);

                // Clear existing task container and append new structure
                taskContainer.html(`
                    <div class="task-list">
                        <div class="text-left task-column" id="todo">
                            <h3 style="text-align: left;"><b>To-Do</b></h3>
                        </div>
                        <div class="task-column drop-zone" id="reopened">
                            <h3 style="text-align: left;"><b>Re-opened</b></h3>
                        </div>
                        <div class="task-column drop-zone" id="in-progress">
                            <h3 style="text-align: left;"><b>In Progress</b></h3>
                        </div>
                        <div class="task-column drop-zone" id="completed">
                            <h3 style="text-align: left;"><b>Completed</b></h3>
                        </div>
                    </div>
                `);

                // Columns for each task status
                const todoColumn = $("##todo");
                 const reopenedColumn = $("##reopened");
                const inProgressColumn = $("##in-progress");
                const completedColumn = $("##completed");

                // Flag to track if there are any re-opened tasks
                let hasReopenedTasks = false;

                if (Array.isArray(tasks)) {
                    // Iterate over the tasks and append them to the respective columns based on status
                    $.each(tasks, function (index, task) {
                        
                      const taskElement =  $(taskTemplate(task.task_id,task.scope,task.priority,task.eta));

                        if (task.status.toLowerCase() === 'completed') {
                          taskElement.attr("draggable", "false"); // Prevent dragging
                          taskElement.addClass("disabled-task"); // Add a CSS class for visual styling
                      } else {
                          // Handle drag events for non-completed tasks
                          taskElement.on("dragstart", function () {
                              $(this).addClass("dragging");
                          });

                          taskElement.on("dragend", function () {
                              $(this).removeClass("dragging");
                          });
                      }

                        // Append task to the correct column based on its status
                        switch (task.status.toLowerCase()) {
                            case 'to-do':
                                todoColumn.append(taskElement);
                                break;
                            case 're-opened':
                                reopenedColumn.append(taskElement);
                                hasReopenedTasks = true;
                                break;
                            case 'in progress':
                                inProgressColumn.append(taskElement);
                                break;
                            case 'completed':
                                completedColumn.append(taskElement);
                                break;
                            default:
                                todoColumn.append(taskElement); // Default to "To-Do" if status is unknown
                        }
                    });
                       if (!hasReopenedTasks) {
                            reopenedColumn.hide(); // Hide the "Reopened" column if no re-opened tasks
                        } else {
                            reopenedColumn.show(); // Show the "Reopened" column if there are re-opened tasks
                        }

                  

                    // Initialize popovers for tasks in the "To-Do" column
                   const todoTasks = todoColumn.find('.task');
                    todoTasks.popover({
                        trigger: 'hover',
                        placement: 'top',
                        container: 'body',
                        html: true,
                    });

                    const inprogressTasks = inProgressColumn.find('.task');
                    inprogressTasks.popover({
                        trigger: 'hover',
                        placement: 'top',
                        container: 'body',
                        html: true,
                    });

                    const completedTasks = completedColumn.find('.task');
                    completedTasks.popover({
                        trigger: 'hover',
                        placement: 'top',
                        container: 'body',
                        html: true,
                    });
                } else {
                    console.warn("Expected an array of tasks but found:", tasks);
                }
                function taskTemplate(task_id,task_scope,task_priority,task_eta){
                  const fullDescription = '<b>Task Description :</b> '+task_scope;
                  const letters = task_scope.split("");
                    if (letters.length > 15) {
                        task_scope = letters.slice(0, 15).join("") + " ...";
                    }
                  const taskElement = 
                            `<div class="task" data-task-id="task_${task_id}" draggable="true" data-bs-toggle="popover" data-bs-content="${fullDescription}">
                                <span><b>Task ID:</b> <span class="taskID">${task_id}</span></span>
                                <span><b>Scope :</b> ${task_scope}</span>
                                <span><b>Priority:</b> <span class="priority">${task_priority}</span></span>
                                <span class="eta"><b>ETA:</b> ${task_eta}</span>
                            </div>`;
                  return taskElement;
                }
                $(document).ready(function () {
                    // Enable drag-and-drop functionality
                    $(".drop-zone").on("dragover", function (e) {
                        e.preventDefault();  // Allow dropping
                    });

                    $(".drop-zone").on("drop", function () {
                        const draggedItem = $(".dragging");

                        if (draggedItem.length > 0) {
                            // Add a custom data attribute to open a modal
                            // draggedItem.attr("data-bs-toggle", "modal");
                            // draggedItem.attr("data-bs-target", "##staticBackdrop");
                            // draggedItem.addClass("trigger-modal");
                            console.log(draggedItem);
                        }

                        // Extract task ID and description for the dropped task
                        let taskID = draggedItem.find("span:contains('Task ID:')").text().replace("Task ID:", "").trim();
                        let eta = draggedItem.find("span:contains('ETA:')").text().replace("ETA:", "").trim();
                        let priority = draggedItem.find("span:contains('Priority:')").text().replace("Priority:", "").trim();
                        let taskDescription = draggedItem.find("span:contains('Task Description:')").text().replace("Task Description:", "").trim();

                        let taskElement = taskTemplate(taskID, taskDescription, priority, eta);

                        // Check the source and destination statuses
                        let sourceStatus = draggedItem.parent().attr("id");
                        let targetStatus = $(this).attr("id");

                        // Restrict dragging back to "To-Do" or "Reopened"
                        if (
                            (targetStatus === "todo" && (sourceStatus === "in-progress" || sourceStatus === "completed")) ||
                            (targetStatus === "reopened" && (sourceStatus === "in-progress" || sourceStatus === "completed"))
                        ) {
                            return;  // Prevent dragging back
                        }

                        // let taskElement = taskTemplate(taskID,taskDescription,priority,eta);
                        // Update the dropped task's HTML
                        draggedItem.html($(taskElement).html());

                        let parentDiv = this;
                        let heading = parentDiv.querySelector("h3");

                       if (heading.nextSibling === null) { 
                        $(parentDiv).prepend(draggedItem); 
                    }  else {
                        parentDiv.insertBefore(draggedItem[0], heading.nextSibling); 
                    }
                        draggedItem.removeClass("dragging");  
                    });
                });

              }
            });
          $(document).on("click", ".task", function () {
            const divTaskId = $(this).data("task-id");
            const taskId = divTaskId.replace(/^task_/, "");
            if (this.parentElement.id === 'todo' || this.parentElement.id === 'reopened') {
                return; // Prevent modal for "To-Do" or "Reopened"
            }

            var temporary_status = this.parentElement.id=='in-progress'? 'In Progress':this.parentElement.id=='completed'?'Completed':this.parentElement.id === 'reopened' ? 'Reopened' : "";
            var status_id = this.parentElement.id=='in-progress'? 2 : this.parentElement.id=='completed'? 1 :this.parentElement.id === 'reopened' ? 3 : ""; 
            $("##loader").show();
            $("##overlay").show();

            // Fetch task details from server
            $.ajax({
                url: "../models/tasks.cfc",
                type: "GET",
                data:{
                  method:"getTaskData",
                  taskId: taskId
                },
                success: function (response) {
                    const taskDetails = JSON.parse(response).fullData;
                    console.log(taskDetails);

                    // Extract project, module, and task data dynamically
                    const project = Object.keys(taskDetails)[0];
                    const module = Object.keys(taskDetails[project])[0];
                    const taskData = taskDetails[project][module][0];
                    console.log(taskData);
                    // Populate modal fields
                    $("##project").val(project);
                    $("##module").val(module);
                    $("##task_type").val(taskData.task_type || "N/A");
                    $("##assigned_by").val(taskData.assigned_by || "N/A");
                    $("##status").val(temporary_status);
                    $("##priority").val(taskData.priority);
                    $("##project_id").val(taskData.project_id);
                    $("##module_id").val(taskData.module_id);
                    $("##assigned_by_id").val(taskData.assignedby_id);
                    $("##taskDescription").val(taskData.scope);
                    $("##status_id").val(status_id);
                    $("##task_id").val(taskData.task_id);
                    $("##task_type_id").val(taskData.task_type_id);
                    $("##taskIdDiv").html(taskData.task_id);

                    // Hide loader and overlay
                    $("##loader").hide();
                    $("##overlay").hide();

                    // Show modal
                    $("##staticBackdrop").modal("show");
                },
                error: function (xhr, status, error) {
                    console.error("Error fetching task details:", error);

                    // Hide loader and overlay on error
                    $("##loader").hide();
                    $("##overlay").hide();
                }
            });
        });
             (() => {
          "use strict";

          // Apply Bootstrap validation to forms with "needs-validation" class
          const forms = document.querySelectorAll(".needs-validation");

          Array.from(forms).forEach((form) => {
            form.addEventListener(
              "submit",
              (event) => {
                // Prevent submission if form is invalid or custom validation fails
                if (!form.checkValidity() || !customValidation()) {
                  event.preventDefault();
                  event.stopPropagation();
                }
                form.classList.add("was-validated");
              },
              false
            );
          });
        })();

 function customValidation() {
  const startTime = document.getElementById("start_time");
  const endTime = document.getElementById("end_time");
  const devComments = document.getElementById("dev_comments");

  let isValid = true;

  // Clear previous invalid styles
  clearInvalid(startTime);
  clearInvalid(endTime);
  clearInvalid(devComments);

  // Get current date and normalize to compare only dates
  const now = new Date();
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate()); 
  const yesterday = new Date(today);
  const tomorrow = new Date(today);

  yesterday.setDate(today.getDate() - 1);
  tomorrow.setDate(today.getDate() + 1);

  const startDate = startTime.value ? new Date(startTime.value) : null;
  const endDate = endTime.value ? new Date(endTime.value) : null;

  // Validate Start Time
  if (!startDate) {
    setInvalid(startTime, "Start Time is required.");
    isValid = false;
  } else if (startDate < yesterday) {
    setInvalid(startTime, "Start Date is out of Range.");
    isValid = false;
  }

  // Validate End Time
  if (!endDate) {
    setInvalid(endTime, "End Time is required.");
    isValid = false;
  } else if (startDate && startDate.getTime() > endDate.getTime()) {
    setInvalid(endTime, "End Time must be after Start Time.");
    isValid = false;
  } else if (endDate < yesterday) {
    setInvalid(endTime, "End Date is out of Range.");
    isValid = false;
  }

  // Validate Task Description
  if (!devComments.value.trim()) {
    setInvalid(devComments, "Description is required.");
    isValid = false;
  }

  return isValid;
}

function setInvalid(element, message) {
  element.classList.add("is-invalid");
  element.nextElementSibling.textContent = message;
}

function clearInvalid(element) {
  element.classList.remove("is-invalid");
  element.nextElementSibling.textContent = "";
}

// Attach event listeners for clearing errors
["input", "blur"].forEach(event => {
  document.getElementById("start_time").addEventListener(event, function () {
    clearInvalid(this);
  });
  document.getElementById("end_time").addEventListener(event, function () {
    clearInvalid(this);
  });
  document.getElementById("dev_comments").addEventListener(event, function () {
    clearInvalid(this);
  });
});

</script>
</cfoutput>
</body>

      <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
      <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  </html>
