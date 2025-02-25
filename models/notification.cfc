 <cfcomponent>
 	<cffunction name="get_DOB">
		<cfquery name="DOB">
			SELECT * FROM employee
		</cfquery>
		<cfreturn DOB>
	</cffunction>
	<cffunction name="checknotification">
		<cfset date = get_DOB()>
		 <cfset currentDate = now()>
            <cfset enddate = dateAdd("d", 5, currentDate)>
            <cfloop from="#currentDate#" to="#enddate#" index="i" step="#createTimespan(1, 0, 0, 0)#">
                <cfloop query="date">
                <cfif date.DOB NEQ "">
                        <cfset birthday = createDate(year(now()), month(date.DOB), day(date.DOB))>
                    <cfif dateFormat(i) EQ dateFormat(birthday)>
                    	<cfquery name="check">
                    		select * from notification 
                    		where content_id = <cfqueryparam value="#date.id#" cfsqltype="cf_sql_integer">
                    		AND date 
                    	</cfquery>
                       	<cfquery name="insertNotification">
                       	INSERT INTO notification SET
                       	content = <cfqueryparam value="birthday" cfsqltype="cf_sql_varchar">,
                       	content_id = <cfqueryparam value="#date.id#" cfsqltype="cf_sql_integer">
						</cfquery>
                    </cfif>
                </cfif>
            </cfloop>
            </cfloop>
	</cffunction>
</cfcomponent>