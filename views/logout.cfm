<cfset structDelete(session, "user")>
<cfset structClear(session)>
<cflocation url="..\index.cfm?session_out">