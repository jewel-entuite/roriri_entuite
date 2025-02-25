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
                <!--- <cfdump var="#tasks#"> --->
                <div class="d-flex justify-content-end">
                  <form action="add_task.cfm"  enctype="multipart/form-data" method="post">
                    <button type="submit" class="btn btn-outline-white mb-3" style="font-size:small; vertical-align: middle; background-color: ##ee7843; Color:white;">Add New Task</button>
                  </form>
                </div>
               <table class="table table-striped border-dark table-responsive-sm" style="overflow: hidden;">
                <thead style="background-color:##31394F;">
                  <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                    <th>SL.N0</th>
                    <th style="width: 10%;">TASK ID</th>
                    <th style="width: 8%;">PROJECT</th>
                    <th style="width:4%">MODULE</th>
                    <th>SCOPE</th>
                    <th style="width: 7%;">PRIORITY</th>
                    <th style="width: 7%;">ASSIGNER</th>
                    <th style="width: 6%;">STATUS</th>
                    <th style="width:8%">HANDLERS</th>
                    <th style="width: 6%;">HANDLER'S STATUS</th>
                    <th style="width:10%">ETA</th>
                    <th style="width:6%">WORKED HOURS</th>
                    <th>ACTION</th>
                  </tr>
                </thead>
                <tbody style="background-color:##FEF7F5">
                  <cfif queryRecordCount(tasks) GT 0>
                  <!--- <cfdump var="#tasks#"> --->
                    <cfset index = 1>
                    <cfoutput query="tasks">
                      <cfinvoke component="models.timesheet" taskId="#tasks.task_id#" method="getWorkedHours" returnvariable="workedHours">
                      <cfinvoke component="models.tasks" method="getTaskData" taskId="#tasks.task_id#" needfulltasks="true" returnvariable="userTaskData" />
                      <cfif structKeyExists(url, "debug")>
                        <cfdump var="#deserializeJSON(userTaskData)#">
                      </cfif>
                      <cfset userDataStruct = deserializeJSON(userTaskData)[tasks.project_name][tasks.module_name][1]/>
                      <!--- <cfif queryRecordCount(userTaskData) GT 0>
                        <cfset userDataStruct = deserializeJSON(userTaskData)[tasks.project_name][tasks.module_name][1]/>
                      <cfelse>
                        <cfset userDataStruct = {} />
                      </cfif> --->
                      <tr class="text-center">
                        <td class="custom-font-size align-middle"><b>#index#</b></td>
                        <td class="custom-font-size align-middle"><b><a href="add_task.cfm?task_id=#encrypt(tasks.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">#tasks.task_id#</a></b></td>
                        <td class="custom-font-size text-sm-start align-middle">#UCase(tasks.project_name)#</td>
                        <td class="custom-font-size text-sm-start align-middle">#uCase(tasks.module_name)#</td>
                        <td class="custom-font-size text-sm-start align-middle">#tasks.taskDescription#</td>
                        <td class="custom-font-size align-middle" <cfif tasks.priority EQ "High">style="color: red;"<cfelseif tasks.priority EQ "Medium">style="color: ##e3c541;"<cfelse>style="color: seagreen;"</cfif>><b>#tasks.priority#</b></td>
                          <td class="custom-font-size align-middle">#tasks.assignor#</td>
                        <td class="custom-font-size align-middle"><b><cfif tasks.status_id EQ 10>Not Assigned<cfelse>#tasks.status#</cfif></b></td>
                        <cfif tasks.first_name NEQ "">
                          <td class="custom-font-size align-middle">#tasks.first_name#</td>
                        <cfelse>
                          <td data-bs-toggle="tooltip" title="Assign Task">
                            <button type="button" class="btn btn-outline-dark btn-sm assign-task-button" data-bs-toggle="modal" data-bs-target="##staticBackdrop" data-task-id="#tasks.task_id#">
                              <i class="bi bi-person-fill-add"></i>
                            </button>
                          </td>
                        </cfif>
                        <cfif len(userDataStruct["status"])>
                          <td class="custom-font-size align-middle"><b>#userDataStruct["status"]#</b></td>
                        <cfelse>
                          <td>-</td>
                        </cfif>
                        <cfif tasks.deliverBefore NEQ "" AND tasks.estimatedHours NEQ "">
                          <td class="custom-font-size align-middle"><b style="color: crimson;">#dateformat(tasks.deliverBefore, 'dd-mmm-yy')#</b>&nbsp;&nbsp;#tasks.estimatedHours# Hr(s)</td>
                        <cfelse>
                          <td class="align-middle">-</td>
                        </cfif>

                        <cfset workedHoursInMinutes = 0>
                        <cfif find("hour", workedHours)>
                            <cfset workedHoursInMinutes = workedHoursInMinutes + (Val(replace(workedHours, " hours", "")) * 60)>
                        </cfif>
                        <cfif find("minute", workedHours)>
                            <cfset workedHoursInMinutes = workedHoursInMinutes + Val(replace(workedHours, " minutes", ""))>
                        </cfif>
                        <cfif workedHoursInMinutes EQ 0>
                          <td>-</td>
                        <cfelse>
                          <td class="align-middle custom-font-size" style="<cfif workedHoursInMinutes GT (tasks.estimatedHours * 60)>background-color: ##edb4b9;<cfelse>background-color: ##d4edda;</cfif>">#workedHours#</td>
                        </cfif>
                        <td class="align-middle">
                          <form method="post" action="add_task.cfm?task_id=#encrypt(tasks.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
                            <span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="Disabled">
                              <button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"><i class="bi bi-pencil-square"></i></button>
                              <input type="hidden" name="url_data" value='#serializeJSON(URL)#'> 
                            </span>
                          </form>
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
                              <input type="radio" value="#allemployee.id#" name="Employee">
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
    </script>

  </body>
</html>