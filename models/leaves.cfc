<cfcomponent>
<cffunction name="company_leaves">
   <cfset details = array()>
    <cfset uniqueId = 1> 
    <cfset yearPart = year(listGetAt(form.date, 1, ","))>
    <cfquery name="checkYear">
        SELECT id, company_leaves_JSON
        FROM company_leaves
        WHERE years = <cfqueryparam value="#yearPart#" cfsqltype="cf_sql_longvarchar">
    </cfquery>
    <cfif checkYear.recordCount NEQ 0>
       <cfset getDetails = deserializeJSON(checkYear.company_leaves_JSON)>
        <cfset maxUniqueId = 0>
        <cfloop array="#getDetails#" index="existingDetail">
            <cfif existingDetail.uniqueId GT maxUniqueId>
                <cfset maxUniqueId = existingDetail.uniqueId>
            </cfif>
        </cfloop>
        <cfset uniqueId = maxUniqueId + 1>
    <cfelse>
        <cfset getDetails = arrayNew(1)>
    </cfif>
    <!-- Loop through the form.date list to process each date -->
    <cfloop from="1" to="#listLen(form.date, ',')#" index="i">
        <cfset structnew = structNew()>
        <cfset structnew.uniqueId = uniqueId>
        <cfset structnew.date = listGetAt(form.date, i, ",")>
        <cfset structnew.reason = listGetAt(form.reason, i, ",")>
        <cfset arrayAppend(details, structnew)>
        <cfset uniqueId = uniqueId + 1>
    </cfloop>
    <cfloop array="#details#" index="newDetail">
        <cfset arrayAppend(getDetails, newDetail)>
    </cfloop>
        <cfset updatedLeaveDetails = serializeJSON(getDetails)>
<!-- If no record exists for the year, insert a new record -->
    <cfif checkYear.recordCount EQ 0>
        <cfquery name="Insert_C_Leaves">
            INSERT INTO company_leaves 
            (company_leaves_JSON, years)
            VALUES (
                <cfqueryparam value="#updatedLeaveDetails#" cfsqltype="cf_sql_longvarchar">,
                <cfqueryparam value="#yearPart#" cfsqltype="cf_sql_longvarchar">
            )
        </cfquery>
    <cfelse>
        <!-- If a record exists, update the existing record -->
        <cfquery name="Update_C_Leaves">
            UPDATE company_leaves
            SET company_leaves_JSON = <cfqueryparam value="#updatedLeaveDetails#" cfsqltype="cf_sql_longvarchar">
            WHERE id = <cfqueryparam value="#checkYear.id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfif>
<cfreturn true>
</cffunction>
<!--- delete --->
<cffunction name="deleteleaves">
<cfif structKeyExists(url, "dlt")>
<cfset getid= decrypt(url.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>
<cfquery name="checkYears">
    SELECT id, company_leaves_JSON
    FROM company_leaves
    WHERE id = <cfqueryparam value="#getid#" cfsqltype="cf_sql_longvarchar">
</cfquery>
 <cfset getDetails = deserializeJSON(checkYears.company_leaves_JSON)>
<cfset updatedDetails = []> 
<cfloop array="#getDetails#" index="existingDetail">
   <cfif NOT (existingDetail.UNIQUEID EQ url.uid AND existingDetail.DATE EQ url.date AND existingDetail.REASON EQ url.reason)>
        <cfset arrayAppend(updatedDetails, existingDetail)>
    </cfif>
</cfloop>
<cfset updatedJSON = serializeJSON(updatedDetails)>
<cfquery name="Update_Leaves">
        UPDATE company_leaves
        SET company_leaves_JSON = <cfqueryparam value="#updatedJSON#" cfsqltype="cf_sql_longvarchar">
        WHERE id = <cfqueryparam value="#checkYears.id#" cfsqltype="cf_sql_integer">
    </cfquery>
</cfif>
</cffunction>
<!--- end of delete --->
<!--- edit --->
<cffunction name="editleaves">
<cfset getid= form.id>
    <cfset updatedDetails = []> 
<cfquery name="edit_leave">
    SELECT *
    FROM company_leaves
    WHERE id = <cfqueryparam value="#getid#" cfsqltype="cf_sql_longvarchar">
</cfquery>
<cfset getDetails = deserializeJSON(edit_leave.company_leaves_JSON)>
<cfloop array="#getDetails#" index="existingDetail">
     <cfif existingDetail.UNIQUEID EQ form.uid>
            <!-- Update the Record -->
            <cfset existingDetail.DATE = form.date>
            <cfset existingDetail.REASON = form.reason>
    </cfif>
    <cfset arrayAppend(updatedDetails, existingDetail)>
</cfloop>
    <cfset updatedJSON = serializeJSON(updatedDetails)>
    <cfquery name="update_leave">
        UPDATE company_leaves
        SET company_leaves_JSON = <cfqueryparam value="#updatedJSON#" cfsqltype="cf_sql_longvarchar">
        WHERE id = <cfqueryparam value="#getid#" cfsqltype="cf_sql_integer">
    </cfquery>
</cffunction>
<!--- end of edit --->
<cffunction name="get_leaves">
    <cfargument name="yearByValue" default="">
    <cfquery name="getLeaves">
        SELECT * FROM company_leaves
        <cfif structKeyExists(arguments, "yearByValue") AND arguments.yearByValue NEQ"" AND isNumeric(arguments.yearByValue)>
        WHERE years=<cfqueryparam value="#arguments.yearByValue#" cfsqltype="cf_sql_integer">
        </cfif>
    </cfquery>
<cfreturn getLeaves>
</cffunction>
<cffunction name="edit_Leaves">
    <cfif structKeyExists(url, "dump")>
        <cfdump var="#arguments#"><cfabort>
    </cfif>
<cfquery name="editLeaves">
        WITH RECURSIVE cte AS (
            SELECT
                0 AS idx
            UNION ALL
            SELECT
                idx + 1
            FROM
                cte
            WHERE
                idx + 1 < (
                    SELECT JSON_LENGTH(l.company_leaves_JSON)
                    FROM company_leaves l
                    WHERE l.id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
                )
        )
        SELECT 
            JSON_UNQUOTE(JSON_EXTRACT(l.company_leaves_JSON, CONCAT('$[', cte.idx, '].DATE'))) AS DATE,
            JSON_UNQUOTE(JSON_EXTRACT(l.company_leaves_JSON, CONCAT('$[', cte.idx, '].UNIQUEID'))) AS UNIQUEID,
            JSON_UNQUOTE(JSON_EXTRACT(l.company_leaves_JSON, CONCAT('$[', cte.idx, '].REASON'))) AS REASON
        FROM 
            company_leaves l
        JOIN 
            cte
        ON 
            l.id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        WHERE 
            JSON_UNQUOTE(JSON_EXTRACT(l.company_leaves_JSON, CONCAT('$[', cte.idx, '].UNIQUEID'))) = <cfqueryparam value="#arguments.uid#" cfsqltype="cf_sql_varchar">;
    </cfquery>
<cfreturn editLeaves>
</cffunction>
<cffunction name="calendar_list">
    <cfquery name="calendar_list">
        SELECT * FROM company_leaves
    </cfquery>
    <cfreturn calendar_list>
</cffunction>
<cffunction name="getleaveapproval">
        <cfquery name="leave_history" >
            SELECT * FROM leave_history lh
            LEFT JOIN employee e on e.id = lh.employee_id
            WHERE 1=1
            AND approved_status=<cfqueryparam value="0" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn leave_history>
    </cffunction>
<cffunction name="getwfhapproval">
        <cfquery name="wfh_history" >
            SELECT * FROM wfh_history lh
            LEFT JOIN employee e on e.id = lh.employee_id
            WHERE 1=1
            AND approved_status=<cfqueryparam value="0" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn wfh_history>
</cffunction>
<cffunction name="getwfhapprovals">
             <cfquery name="approve_wfh">
                SELECT * FROM wfh_history WH
                LEFT JOIN employee E ON WH.employee_id=E.id
                WHERE approved_status='0'
            </cfquery>
            <cfreturn approve_wfh>
</cffunction>
<cffunction name="getleaveapprovals">
     <cfquery name="approve_leave">
        SELECT * FROM leave_history LH
        LEFT JOIN employee E ON LH.employee_id=E.id
        WHERE approved_status='0'
    </cfquery>
    <cfreturn approve_leave>
</cffunction>
<cffunction name="update_approve_leave">
    <cfquery name="approve_leave">
        UPDATE leave_history SET 
        approved_status=1
        WHERE  id=<cfqueryparam value="#form.leave_approve#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn 1>
</cffunction>
<cffunction name="update_approve_wfh">
    <cfquery name="approve_wfh">
    UPDATE wfh_history SET 
        approved_status=1
        WHERE id=<cfqueryparam value="#form.wfh_approve#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn 1>
</cffunction>
<cffunction name="getleaveapproved">
     <cfquery name="approved_leave">
        SELECT * FROM leave_history 
        WHERE approved_status='1'
        AND read_status='0' 
        AND employee_id=<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn approved_leave>
</cffunction>
<cffunction name="getwfhapproved">
     <cfquery name="approved_wfh">
        SELECT * FROM wfh_history 
        WHERE approved_status='1' 
        AND read_status='0'
        AND employee_id=<cfqueryparam value="#arguments.emp_id#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn approved_wfh>
</cffunction>
<cffunction name="update_readstatus_leave">
    <cfquery name="read_leave">
    UPDATE leave_history SET 
        read_status=1
        WHERE id=<cfqueryparam value="#form.leave_read#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn 1>
</cffunction>
<cffunction name="update_readstatus_wfh">
    <cfquery name="read_wfh">
    UPDATE wfh_history SET 
        read_status=1
        WHERE id=<cfqueryparam value="#form.wfh_read#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfreturn 1>
</cffunction>
</cfcomponent>
        

        

