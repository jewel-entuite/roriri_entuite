<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

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
        body.custom-body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #4e4039;
            margin: 0;
            display: flex;
            height: 100vh;
        }

        .sidebar.custom-sidebar {
            width: 300px;
            background-color: white;
            color: #4e4039;
            display: flex;
            flex-direction: column;
            padding: 20px;
            box-shadow: 2px 0 6px rgba(0, 0, 0, 0.1);
        }

        .sidebar.custom-sidebar h2 {
            font-size: 18px;
            font-weight: bold;
            margin: 0 0 15px;
            border-bottom: 1px solid ##b3a6ed;
            padding-bottom: 10px;
        }

        .custom-project {
            margin-bottom: 20px;
        }

        .custom-project h3 {
            font-size: 16px;
            margin: 0 0 10px;
            cursor: pointer;
            font-weight: bold;
        }

        .custom-module {
            margin-left: 15px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 5px;
            background-color: ##b3a6ed;
            color: white;
            margin-bottom: 5px;
        }

        .custom-module:hover {
            background-color: #7d66e3;
        }

        .content.custom-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .custom-module-tasks {
            margin-bottom: 20px;
            flex: 1;
        }

        .draggable.custom-draggable {
            padding: 10px 15px;
            background-color: white;
            border: 2px solid ##b3a6ed;
            color: #4e4039;
            border-radius: 8px;
            cursor: grab;
            margin-bottom: 10px;
            font-size: 14px;
            text-align: left;
        }

        .drop-zone.custom-drop-zone {
            flex: 1;
            border: 2px dashed #4e4039;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s, background-color 0.3s;
            text-align: left;
            height: 300px;
            margin-top: 20px;
            padding: 10px;
            overflow-y: auto;
        }

        .drop-zone.custom-drop-zone.active {
            border-color: #7d66e3;
            background-color: #fff4ec;
        }

        button.custom-btn {
            padding: 6px 12px;
            background-color: #7d66e3;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 14px;
        }

        button.custom-btn:hover {
            background-color: #d4571a;
        }

        .full-width-task.custom-full-width-task {
            width: auto;
            padding: 15px;
            margin: 0;
            background-color: white;
            color: #4e4039;
            border: 2px solid ##b3a6ed;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            text-align: left;
            margin-bottom: 10px;
        }

        .task-container.custom-task-container {
            margin-bottom: 20px;
        }

        .task-details.custom-task-details {
            margin-top: 10px;
        }

        .remove-btn.custom-remove-btn {
            background-color: #d4571a;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
        }

        .status-message.custom-status-message {
            margin-top: 15px;
            color: #4e4039;
        }

        .module-list.custom-module-list {
            display: none;
            flex-direction: column;
        }

        .custom-project.active .custom-module-list {
            display: flex;
        }
        .custom-task-details {
            margin-top: 10px;
            font-size: 14px;
            color: #4e4039;
        }

        .custom-task-details div {
            margin-bottom: 5px;
        }

        .custom-task-details .task-name {
            font-weight: bold;
        }

        .custom-task-details .est-hours,
        .custom-task-details .due-date,
        .custom-task-details .priority {
            color: #6c757d;
        }
    </style>
</head>
<body class="custom-body">
     <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
    <!--- header --->

    <cfset active_status="employee_management">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
    
    <div class="sidebar custom-sidebar pt-5 mt-5">
        <h2>Projects</h2>
        <div id="projectList" class="projects"></div>
    </div>
    <div class="container d-flex align-items-center justify-content-between" style="margin-top:100px;">
        <div class="col-sm-12 col-md-12 col-lg-12 page-heading">
            <section id="contact" class="contact" style="padding: 20px;">
                <div class="container mt-5" data-aos="fade-up">
                    <div id="taskList" class="custom-module-tasks">
                        <h4>Tasks</h4>
                    </div>
                    <!--- <div class="content custom-content"> --->
                        <div id="taskList" class="custom-module-tasks"></div>

                        <div id="dropZone" class="drop-zone custom-drop-zone">
                            Drop your tasks here!
                        </div>

                        <button id="saveBtn" class="custom-btn" disabled>Save Changes</button>

                        <div id="statusMessage" class="custom-status-message"></div>
                    <!--- </div> --->
                </div>
            </section>
        </div>
    </div>

    <script>
        const projectList = document.getElementById('projectList');
        const taskList = document.getElementById('taskList');
        const dropZone = document.getElementById('dropZone');
        const saveBtn = document.getElementById('saveBtn');
        const statusMessage = document.getElementById('statusMessage');

        const projectModules = {
            'Entuite HRMS': ['Project Management'],
            'Maurya CRM': ['Accounting', 'Reports']
        };

        const moduleTasks = {
            'Project Management': [
                { taskId: 'T001', taskName: 'Show user updated status in admin listing',estHours: '1 hr', dueDate: '25/12/2024', priority: 'High' },
                { taskId: 'T002', taskName: 'Employees can enter their own work description',estHours: '2 hrs', dueDate: '28/12/2024', priority: 'Medium' },
                { taskId: 'T003', taskName: 'Display Estimated Hours and Total Worked Hours in timesheet',estHours: '4 hrs', dueDate: '30/12/2024', priority: 'Low' }
            ],
            'Accounting': [],
            'Reports': [
                { taskId: 'T001', taskName: 'Create sales report' },
                { taskId: 'T002', taskName: 'Generate purchase report' }
            ]
        };

        // Create the project list dynamically
        for (const project in projectModules) {
            const projectDiv = document.createElement('div');
            projectDiv.classList.add('custom-project');
            const projectName = document.createElement('h3');
            projectName.textContent = project;
            projectDiv.appendChild(projectName);
            const moduleListDiv = document.createElement('div');
            moduleListDiv.classList.add('custom-module-list');
            projectModules[project].forEach(module => {
                const moduleDiv = document.createElement('div');
                moduleDiv.classList.add('custom-module');
                moduleDiv.textContent = module;
                moduleListDiv.appendChild(moduleDiv);

                moduleDiv.addEventListener('click', () => {
                    displayTasks(module);
                });
            });
            projectDiv.appendChild(moduleListDiv);
            projectList.appendChild(projectDiv);
        }

        // Display tasks of a selected module
        function displayTasks(module) {
            taskList.innerHTML = '';
            moduleTasks[module].forEach(task => {
                const taskDiv = document.createElement('div');
                taskDiv.classList.add('draggable', 'custom-draggable');
                
                // Create a container for task details
                const taskDetails = document.createElement('div');
                taskDetails.classList.add('task-details', 'custom-task-details');
                
                // Task name
                const taskName = document.createElement('div');
                taskName.classList.add('task-name');
                taskName.textContent = `Task: ${task.taskName}`;
                
                // Estimated hours
                const estHours = document.createElement('div');
                estHours.classList.add('est-hours');
                estHours.textContent = `Estimated Hours: ${task.estHours || 'N/A'}`;
                
                // Due date
                const dueDate = document.createElement('div');
                dueDate.classList.add('due-date');
                dueDate.textContent = `Due Date: ${task.dueDate || 'N/A'}`;
                
                // Priority
                const priority = document.createElement('div');
                priority.classList.add('priority');
                priority.textContent = `Priority: ${task.priority || 'N/A'}`;
                
                // Append details to taskDetails
                taskDetails.appendChild(taskName);
                taskDetails.appendChild(estHours);
                taskDetails.appendChild(dueDate);
                taskDetails.appendChild(priority);

                // Append task details to the taskDiv
                taskDiv.appendChild(taskDetails);
                taskDiv.setAttribute('draggable', true);
                taskDiv.setAttribute('data-task-id', task.taskId);

                // Add event listener for dragstart
                taskDiv.addEventListener('dragstart', dragStart);
                
                // Append taskDiv to taskList
                taskList.appendChild(taskDiv);
            });
        }


        function dragStart(event) {
            event.dataTransfer.setData('taskId', event.target.getAttribute('data-task-id'));
        }

        dropZone.addEventListener('dragover', (event) => {
            event.preventDefault();
            dropZone.classList.add('active');
        });

        dropZone.addEventListener('dragleave', () => {
            dropZone.classList.remove('active');
        });

        dropZone.addEventListener('drop', (event) => {
            event.preventDefault();
            dropZone.classList.remove('active');
            const taskId = event.dataTransfer.getData('taskId');
            const taskDiv = document.querySelector(`[data-task-id='${taskId}']`);
            if (taskDiv) {
                dropZone.appendChild(taskDiv);
                // statusMessage.textContent = `Task with ID: ${taskId} added to the drop zone`;
                saveBtn.disabled = false;
            }
        });

        saveBtn.addEventListener('click', () => {
            statusMessage.textContent = 'Changes saved!';
            saveBtn.disabled = true;
        });
    </script>
</body>
</html>
s

<!--- <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project and Task Management</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f9f9f9;
    }

    /* Sidebar styles */
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
      justify-content: space-around;
      height: calc(100vh - 40px); /* Full height minus padding */
    }

    .task-column {
      width: 30%;
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
      border: 2px dashed #534980;
    }

    .task-column.drop-zone:hover {
      background-color: #f9f9f9;
    }

    .task span {
      font-size: 14px;
      margin: 4px 0;
    }

    .priority {
      color: #7d66e3; /* Priority color */
      font-weight: bold;
    }

    .eta {
      color: #534980;
    }
  </style>
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar">
    <h2>Projects</h2>
    <div id="project-list"></div>
  </div>

  <!-- Main Content -->
  <div class="main-content">
    <div id="task-container">
      <div class="note">Choose a project module to view tasks</div>
    </div>
  </div>

  <script>
    // Data for projects, modules, and tasks
    const data = {
      "ENTUITE HRMS": {
        "Admin Timesheet Reports": [
          {
            "scope": "If the task is saved without assigning to the employee, the status in listing will be shown as 'Not Assigned'.",
            "priority": "High",
            "status": "Completed",
            "handlers": "Jewel",
            "eta": "18-Nov-24 24 Hr(s)"
          }
        ],
        "Dashboard": [
          {
            "scope": "Auto fill est hours and due date if any one of the field is filled.",
            "priority": "High",
            "status": "In Progress",
            "handlers": "Jewel",
            "eta": "18-Nov-24 12 Hr(s)"
          }
        ]
      },
      "VCCS CooperACTIVE": {
        "Dashboard": [
          {
            "scope": "Action Column - Assign Task Button - Opens a popup and list the employees along with check boxes, multiple employees can be added for single task.",
            "priority": "Medium",
            "status": "In Progress",
            "handlers": "Jewel",
            "eta": "08-Nov-24 2 Hr(s)"
          }
        ]
      },
      "General": {
        "Others": [
          {
            "scope": "Employees will pick a Task ID and they can enter their own work description in text area and enter hours worked.",
            "priority": "High",
            "status": "Completed",
            "handlers": "Jewel",
            "eta": "13-Nov-24 12 Hr(s)"
          }
        ]
      }
    };

    // Populate sidebar with projects and modules
    const projectList = document.getElementById("project-list");

    for (let project in data) {
      const projectElement = document.createElement("div");
      projectElement.classList.add("project");
      projectElement.innerHTML = `<h3>${project}</h3>`;

      const moduleList = document.createElement("ul");
      for (let module in data[project]) {
        const moduleItem = document.createElement("li");
        moduleItem.textContent = module;

        // Click event for showing tasks
        moduleItem.addEventListener("click", () => {
          loadTasks(data[project][module]);
        });

        moduleList.appendChild(moduleItem);
      }
      projectElement.appendChild(moduleList);
      projectList.appendChild(projectElement);
    }

    // Load tasks into the main content
    function loadTasks(tasks) {
      const taskContainer = document.getElementById("task-container");
      taskContainer.innerHTML = `
        <div class="task-list">
          <div class="task-column" id="todo">
            <h3>To-Do</h3>
          </div>
          <div class="task-column drop-zone" id="in-progress">
            <h3>In Progress</h3>
          </div>
          <div class="task-column drop-zone" id="completed">
            <h3>Completed</h3>
          </div>
        </div>
      `;

      // Populate tasks in the To-Do column
      const todoColumn = document.getElementById("todo");
      tasks.forEach(task => {
        const taskElement = document.createElement("div");
        taskElement.classList.add("task");
        taskElement.draggable = true;
        taskElement.innerHTML = `
          <span>${task.scope}</span>
          <span class="priority">Priority: ${task.priority}</span>
          <span class="eta">ETA: ${task.eta}</span>
        `;

        // Drag event listeners
        taskElement.addEventListener("dragstart", handleDragStart);
        taskElement.addEventListener("dragend", handleDragEnd);

        todoColumn.appendChild(taskElement);
      });

      // Make other columns droppable
      document.querySelectorAll(".drop-zone").forEach(column => {
        column.addEventListener("dragover", handleDragOver);
        column.addEventListener("drop", handleDrop);
      });
    }

    // Drag and drop handlers
    let draggedItem = null;

    function handleDragStart(e) {
      draggedItem = this;
      setTimeout(() => (this.style.display = "none"), 0);
    }

    function handleDragEnd() {
      this.style.display = "block";
      draggedItem = null;
    }

    function handleDragOver(e) {
      e.preventDefault();
    }

    function handleDrop(e) {
      e.preventDefault();
      if (draggedItem) {
        this.appendChild(draggedItem);
      }
    }
  </script>
</body>
</html> --->

