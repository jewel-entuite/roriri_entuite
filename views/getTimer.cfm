<cfset now = createDateTime(1970, 1, 1, 0, 0, 0)> <!-- Set the start time to 00:00:00 -->
<cfset elapsedTime = now + now()> <!-- Calculate elapsed time -->

<cfset hours = datePart("hour", elapsedTime)>
<cfset minutes = datePart("minute", elapsedTime)>
<cfset seconds = datePart("second", elapsedTime)>

<!-- Format the time in HH:MM:SS format -->
<cfoutput>
    <cfif len(hours) EQ 1>0#hours#<cfelse>#hours#</cfif>: 
    <cfif len(minutes) EQ 1>0#minutes#<cfelse>#minutes#</cfif>: 
    <cfif len(seconds) EQ 1>0#seconds#<cfelse>#seconds#</cfif>
</cfoutput>
