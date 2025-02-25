<cfcomponent output="true">
   <cffunction name="getTaskData" access="remote" returnformat="JSON">
    <cfargument name="taskId" default="">
    <cfargument name="needfulltasks" default="false">
    
    <!--- Query to fetch tasks ordered by 'created_on' --->
    <cfquery name="taskData">
        SELECT 
            t.id,
            p.name AS project_name, 
            e.first_name AS assigned_to,
            m.`name` AS module_name, 
            t.taskDescription AS scope, 
            t.priority,
            th.task_id,
            t.deliverBefore AS eta,
            th.task_status AS status_id, 
            ee.first_name AS assignedBy,
            t.module AS module_id,
            p.id AS project_id,
            th.assigned_by AS assignedby_id,
            s.status, 
            r.type AS task_type,
            t.task_type AS task_type_id
        FROM 
            task_history th
        LEFT JOIN task t ON t.task_id = th.task_id
        LEFT JOIN project p ON p.id = t.project
        LEFT JOIN module m ON m.id = t.module
        LEFT JOIN employee e ON FIND_IN_SET(e.id, t.assignTo) > 0
        LEFT JOIN employee ee ON ee.id = th.assigned_by 
        LEFT JOIN status s ON s.id = th.task_status
        LEFT JOIN requirement r ON r.id = t.task_type
        INNER JOIN (
            SELECT 
                task_id, 
                MAX(id) AS latest_id
            FROM 
                task_history
            <cfif NOT (needfulltasks EQ "true")>
                WHERE 
                    FIND_IN_SET(<cfqueryparam value="#session.employee.id#" cfsqltype="cf_sql_integer">, assigned_to) > 0
            </cfif>
            GROUP BY 
                task_id
        ) latest_history ON th.task_id = latest_history.task_id AND th.id = latest_history.latest_id
        WHERE
            1 = 1
            <cfif NOT (needfulltasks EQ "true")>
                AND FIND_IN_SET(<cfqueryparam value="#session.employee.id#" cfsqltype="cf_sql_integer">, t.assignTo) > 0
            </cfif>
            <cfif structKeyExists(arguments, "taskId") AND len(arguments.taskId)>
                AND t.task_id = <cfqueryparam value="#arguments.taskId#" cfsqltype="cf_sql_varchar">
            </cfif>
            AND active_status = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            AND (reassigned_id > 0 OR reassigned_id IS NULL)
        GROUP BY t.task_id 
        ORDER BY 
            th.created_on DESC;
    </cfquery>
        <cfset projects = {}>
        <cfloop query="taskData">
            <cfif NOT structKeyExists(projects, project_name)>
                <cfset projects[project_name] = {}>
            </cfif>
            <cfif NOT structKeyExists(projects[project_name], module_name)>
                <cfset projects[project_name][module_name] = []> 
            </cfif>

            <cfset arrayAppend(projects[project_name][module_name], {
                "id" : id,
                "task_id": task_id,
                "scope": scope,
                "priority": priority,
                "status": status,
                "assigned_to": assigned_to,
                "task_type": task_type,
                "task_type_id": task_type_id,
                "eta": dateFormat(eta, 'dd-mm-yyyy'),
                "assigned_by": assignedBy,
                "project_id" : project_id,
                "module_id" : module_id,
                "assignedby_id" : assignedby_id,
                "status_id" : status_id
            })>
        </cfloop>
        <cfset returnData = {} />
        <cfset returnData["fullData"] = projects/>
        <cfset returnData["recentAssignedModule"] = taskData.module_name />
        <cfreturn serializeJSON(returnData)>
    </cffunction>

    <cffunction name="updateTaskStatus">
        <cfset startTime = parseDateTime(form.start_time) />
        <cfset endTime = parseDateTime(form.end_time) />
        <cfset productiveHours = DateDiff("H",startTime,endTime)>
        <cfset Mins= DateDiff("n", form.start_time,form.end_time)>
        <cfset productiveMins = Mins-(productiveHours*60)>
        <cfquery name="updateStatus">
            INSERT INTO task_history SET
            task_status = <cfqueryparam value="#form.status_id#" cfsqltype="cf_sql_varchar">,
            task_id = <cfqueryparam value="#form.task_id#" cfsqltype="cf_sql_varchar">,
            assigned_by = <cfqueryparam value="#form.assigned_by_id#" cfsqltype="cf_sql_integer">,
            assigned_to = <cfqueryparam value="#session.employee.id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfquery name="updateTimesheet">
            INSERT INTO timesheet SET 
            emp_id = <cfqueryparam value="#form.emp_id#" cfsqltype="cf_sql_integer">,
            project_id = <cfqueryparam value="#form.project_id#" cfsqltype="cf_sql_integer">,
            requirement_id = <cfqueryparam value="#form.task_type_id#" cfsqltype="cf_sql_integer">,
            status_id = <cfqueryparam value="#form.status_id#" cfsqltype="cf_sql_integer">,
            assignedby_id = <cfqueryparam value="#form.assigned_by_id#" cfsqltype="cf_sql_integer">,
            modules = <cfqueryparam value="#form.module#" cfsqltype="cf_sql_varchar">,
            description = <cfqueryparam value="#form.dev_comments#" cfsqltype="cf_sql_varchar">,
            start_time = <cfqueryparam value="#form.start_time#" cfsqltype="cf_sql_timestamp">,
            end_time = <cfqueryparam value="#form.end_time#" cfsqltype="cf_sql_timestamp">,
            productive_hours = <cfqueryparam value="#productiveHours#" cfsqltype="cf_sql_varchar">,
            productive_mins = <cfqueryparam value="#productiveMins#" cfsqltype="cf_sql_varchar">,
            task_id = <cfqueryparam value="#form.task_id#" cfsqltype="cf_sql_varchar">,
            created_date = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd HH:nn:ss')#" cfsqltype="cf_sql_date">
        </cfquery>
    </cffunction>

     <cffunction name="maketaskinactive">
    <cftry>
        <cfdump var="#form.task_id#">
        <cfquery name="updateactivestatus">
            UPDATE task
            SET active_status = <cfqueryparam value="0" cfsqltype="cf_sql_bit">
            WHERE task_id = <cfqueryparam value="#form.task_id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfcatch type="any">
            <cfset variables.errorMessage = "An error occurred: " & cfcatch.message>
            <cfoutput>#variables.errorMessage#</cfoutput>
            <cfabort>
        </cfcatch>
    </cftry>
     </cffunction>
     <cffunction name="makeTaskActive">
        <cfquery name="updateStatusActive">
            UPDATE task
            SET active_status = <cfqueryparam value="1" cfsqltype="cf_sql_bit">
            WHERE task_id = <cfqueryparam value="#form.task_id#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn 1> 
    </cffunction>

    <cffunction name="reopenedcount">
        <cfquery name="updatereopenedstatus" result="updateStatusResult">
            UPDATE task
            SET
            task_type = <cfqueryparam value="#form.task_type#" cfsqltype="cf_sql_varchar">,
            taskDescription = <cfqueryparam value="#form.taskDescription#" cfsqltype="cf_sql_varchar">,
            priority = <cfqueryparam value="#form.priority#" cfsqltype="cf_sql_varchar">,
            estimatedHours = <cfqueryparam value="#form.estimatedHours#" cfsqltype="cf_sql_double">,
            deliverBefore = <cfqueryparam value="#form.deliverBefore#" cfsqltype="cf_sql_varchar">,
            reopened_id = <cfqueryparam value="1" cfsqltype="cf_sql_integer">, 
            reopened_count = reopened_count + 1, 
            status_id = <cfqueryparam value="3" cfsqltype="cf_sql_integer">
            WHERE id = <cfqueryparam value="#form.update_task#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <!--- <cfdump var="#updateStatusResult#"><cfabort> --->
        <cfquery name="taskHistory" result="res">
            INSERT INTO task_history SET
            task_id = <cfqueryparam value="#form.hextask_id#" cfsqltype="cf_sql_varchar">,
            assigned_to = <cfqueryparam value="#form.first_assign#" cfsqltype="cf_sql_varchar">,
            assigned_by = <cfqueryparam value="#session.EMPLOYEE.ID#" cfsqltype="cf_sql_integer">,
            assigned_on = <cfqueryparam value="#dateTimeFormat(now(),'yyyy-mm-dd hh:nn:ss')#" cfsqltype="cf_sql_date">,
            task_status = <cfqueryparam value="3" cfsqltype="cf_sql_varchar">
        </cfquery>
    </cffunction>
</cfcomponent>

