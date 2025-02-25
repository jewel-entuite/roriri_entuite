<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RORIRI -Employee Management</title>
</head>
<body>
    <h1>test</h1>
    <cfif structKeyExists(url, "id" )>
        <h2>IF</h2>
            <cfinvoke method="getform" id="#url.id#" returnvariable="get" component="../models/login">
                <!--- <cfdump var="#get#" abort> --->

                <cfset dateNow = #dateTimeFormat(now())#>
                <cfset date = #dateTimeFormat(get.date)#>
                <cfset diffday = #DateDiff("d", dateNow, date)#>
                <!--- <cfset diffmonth = dateDiff(m, date, dateNow)>
                <cfset diffyear = dateDiff(y, date, dateNow)> --->
                    <cfset day = val(dateTimeFormat(now(),"dd"))-2>
                    <cfset month = dateTimeFormat(now(),"mm")>
                    <cfset year = dateTimeFormat(now(),"yyyy")>
                    <!-- <cfset minday= CreateDate(year, month, day)> -->
                <cfdump var="#day#">
                </cfif>

                <cfset date = now()>


</body>
</html>