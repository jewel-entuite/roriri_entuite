<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Timeline Roadmap</title>
     <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }

        .timeline-container {
            max-width: 1600px;
            padding: 10px 20px;
            height: calc(100vh - 100px); /* Adjust height dynamically for scrolling */
            overflow-y: auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .timeline {
            position: relative;
            padding: 20px 0;
            margin-left: 40px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            left: 10px;
            width: 4px;
            background: #7d66e3;
        }

        .timeline-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .timeline-dot {
            width: 16px;
            height: 16px;
            background-color: #7d66e3;
            border-radius: 50%;
            position: relative;
            left: -18px;
        }

        .timeline-content {
            background: #fff;
            padding: 15px 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #7d66e3;
            margin-left: 20px;
            width: 100%;
        }

        .timeline-content h5 {
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .timeline-content small {
            color: #777;
        }

        .timeline-content p {
            margin: 5px 0;
        }

        .timeline-content strong {
            color: #555;
        }

    </style>
</head>
<body>
<cfoutput>
    <cfset taskId = url.task_id>
    <cfset popup = url.popup>
        <cfinvoke component="models.timesheet" method="getAllDetails" returnvariable="tasks">
            <cfinvokeargument name="task_id" value="#taskId#">
        </cfinvoke>
        <cfinvoke component="models.timesheet" method="Project" returnvariable="list">
            <cfinvokeargument name="task_id" value="#taskId#">
        </cfinvoke>
            <div class="header d-flex justify-content-center fs-4 mb-2" style="font-weight: bold; color: ##7d66e3;">#url.task_id#</div>
            <div class="timeline-container">
            <div class="timeline">
            <!--- <cfloop query="tasks">
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h4><span class="badge rounded-pill bg-secondary">Task Assigned</span></h4>
                        <p><strong style="color: ##7d66e3;">Date:</strong>#DateFormat(tasks.created_on, "dd/mm/yyyy")# #TimeFormat(tasks.created_on, "hh:mm tt")#</p>
                        <p><strong style="color: ##7d66e3;">Assigned To:</strong> #tasks.first_name#</p>
                        <p><strong style="color: ##7d66e3;">Assigned By:</strong> #tasks.assignorname#</p>
                        <p><strong style="color: ##7d66e3;">ETA:</strong> #tasks.estimatedHours# hours</p>
                        <p><strong style="color: ##7d66e3;">Deliver Before:</strong> #DateFormat(tasks.deliverBefore, "dd/mm/yyyy")#</p>
                        <p><strong style="color: ##7d66e3;">Scope:</strong> #tasks.scope#</p>
                    </div>
                </div>
            </cfloop> --->
            <cfloop query="list">
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                    <h4><span class="badge rounded-pill <cfif list.status eq "Completed">bg-success<cfelseif list.status eq "In Progress">bg-info
                    <cfelseif list.status eq "Reassigned">bg-warning</cfif>">#list.status#</span></h4>
                        <p><strong style="color: ##7d66e3;">Date:</strong> #DateFormat(list.created_date, "dd/mm/yyyy")#</p>
                        <p><strong style="color: ##7d66e3;">Start Time:</strong> #TimeFormat(list.start_time, "hh:mm tt")#</p>
                        <p><strong style="color: ##7d66e3;">End Time:</strong> #TimeFormat(list.end_time, "hh:mm tt")#</p>
                        <p><strong style="color: ##7d66e3;">Productive Hours:</strong> #list.productive_hours#hrs #list.productive_mins#mins </p>
                        <p><strong style="color: ##7d66e3;">Description:</strong> #list.description#</p>
                    </div>
                </div>
            </cfloop>

            <!-- Timesheet Entry 1 -->
            <!--- <cfloop query="list">
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                    <h4><span class="badge rounded-pill <cfif list.status eq "Completed">bg-success<cfelseif list.status eq "In Progress">bg-info
                    <cfelseif list.status eq "Reassigned">bg-warning</cfif>">#list.status#</span></h4>
                        <p><strong style="color: ##7d66e3;">Date:</strong> #DateFormat(list.created_date, "dd/mm/yyyy")#</p>
                        <p><strong style="color: ##7d66e3;">Start Time:</strong> #TimeFormat(list.start_time, "hh:mm tt")#</p>
                        <p><strong style="color: ##7d66e3;">End Time:</strong> #TimeFormat(list.end_time, "hh:mm tt")#</p>
                        <p><strong style="color: ##7d66e3;">Productive Hours:</strong> #list.productive_hours#hrs #list.productive_mins#mins </p>
                        <p><strong style="color: ##7d66e3;">Description:</strong> #list.description#</p>
                    </div>
                </div>
            </cfloop> --->
            <!--- <cfdump var="#tasks#"> --->
            <cfloop query="tasks">
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <!--- <h4><span class="badge rounded-pill bg-secondary"><cfif tasks.reassigned_id EQ 1>Task Reassigned<cfelse>Task Assigned</cfif></span></h4> --->
                        <h4><span class="badge rounded-pill <cfif tasks.reassigned_id EQ 1>bg-primary<cfelse>bg-secondary</cfif>"> <cfif tasks.reassigned_id EQ 1>Task Reassigned<cfelse>Task Assigned</cfif></span></h4>
                        <p><strong style="color: ##7d66e3;">Date:</strong>#DateFormat(tasks.created_on, "dd/mm/yyyy")# #TimeFormat(tasks.created_on, "hh:mm tt")#</p>
                        <p><strong style="color: ##7d66e3;">Assigned To:</strong> #tasks.first_name#</p>
                        <p><strong style="color: ##7d66e3;">Assigned By:</strong> #tasks.assignorname#</p>
                        <p><strong style="color: ##7d66e3;">ETA:</strong> #tasks.estimatedHours# hours</p>
                        <p><strong style="color: ##7d66e3;">Deliver Before:</strong> #DateFormat(tasks.deliverBefore, "dd/mm/yyyy")#</p>
                        <p><strong style="color: ##7d66e3;">Scope:</strong> #tasks.scope#</p>
                    </div>
                </div>
            </cfloop>

            <!-- Reassigned Entry -->
            <!--- <div class="timeline-item">
            <div class="timeline-dot"></div>
            <div class="timeline-content">
                <h5>Task Reassigned</h5>
                <small>Date: 2024-12-10 02:59:50</small>
                <p><strong>Reassigned To:</strong> Employee ID 33</p>
                <p><strong>Assigned By:</strong> Employee ID 28</p>
                <p><strong>Task:</strong> Jewel: Need a delete button for the admin listing.</p>
            </div>
            </div>

            <!-- Timesheet Entry 2 -->
            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-content">
                    <h5>Timesheet Entry 2</h5>
                    <small>Date: 2024-12-11</small>
                    <p><strong>Start Time:</strong> 09:20:00</p>
                    <p><strong>End Time:</strong> 14:00:00</p>
                    <p><strong>Productive Hours:</strong> 4h 40m</p>
                    <p><strong>Description:</strong> Instead of deleting data from the database for task details, set the active_status column with a default value of 1. When deleting data, update the active_status to 0 and hide rows with a value of 0.</p>
                </div>
            </div>

            <!-- Timesheet Entry 3 -->
            <div class="timeline-item">
                <div class="timeline-dot"></div>
                <div class="timeline-content">
                    <h5>Timesheet Entry 3</h5>
                    <small>Date: 2024-12-11</small>
                    <p><strong>Start Time:</strong> 14:30:00</p>
                    <p><strong>End Time:</strong> 17:48:00</p>
                    <p><strong>Productive Hours:</strong> 3h 18m</p>
                    <p><strong>Description:</strong> Added delete button for Task Details listing.</p>
                </div>
            </div> --->
        </div>
    </div>
</cfoutput>
</body>
</html>




