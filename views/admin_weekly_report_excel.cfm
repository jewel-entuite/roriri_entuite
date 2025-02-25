<cfinvoke component="models.Weeklyreport" FSdate="#url.FSdate#" FEdate="#url.FEdate#" emp_id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" method="getAllEmployeeDetails" returnvariable="detailsStruct"/>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<CFHEADER name="Content-Disposition" value="inline;filename=Weekly_Report.xls">
<CFCONTENT type="application/vnd.msexcel">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
             <html>
                <head>
                    <style>
                        table td th{
                            vertical-align: center;
                        }
                        table.totalTable{
					border-collapse: collapse;
                        }
                        .font-11{
                            font-size:11px
                        }
                        .font-12{
                            font-size: 12px;
                        }
                        .listing-table td, th{
                            border: 1px solid black;
                        }
                    </style>
                </head>
                    <body style="font-family: Calibri;">

                        <cfoutput>
                            <cfif structKeyExists(url, "emp_id") AND structKeyExists(url, "FSdate") AND structKeyExists(url, "FEdate") AND url.FEdate NEQ "" AND url.FEdate NEQ "">
                                <div class="card shadow p-3 alert alert-warning" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
                                    <center><h3><strong>WEEKLY REPORT<span>&nbsp;[#dateFormat(url.FSdate,"d-mmm-yy")#&nbsp; TO &nbsp;#dateFormat(url.FEdate,"d-mmm-yy")#]</span></strong></h3></center>
                                </div>
                            <cfelse>
                                <div class="card shadow p-3 alert alert-warning" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
                                    <center><h3><strong>WEEKLY REPORT</strong></h3></center>
                                </div>
                            </cfif>
                        </cfoutput>
                    <cfset employeeDetails =detailsStruct.employeeDetails>
                    <cfset employeeAttendanceCount =detailsStruct.attendanceCount>
                    <cfset weekendDays =detailsStruct.weekendDays>
                    <cfset holidayDetails =detailsStruct.holidayDetails>
                    <cfset leaveCount =detailsStruct.leaveCount>
                    <cfset workingDaysCount=detailsStruct.workingDaysCount>
                <table  class="text-center listing-table"border="1" width="100%" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
                    <thead style="color: #1C4587;">
                        <cfif NOT structKeyExists(URL, "month") OR structKeyExists(URL, "month") AND URL.month EQ "">
                            <!--- <tr><th colspan="8" style="font-size:14px;"><b>JANUARY_2023</b></th></tr> --->
                        <cfelse>
                            <cfif NOT structKeyExists(URL, "year") OR structKeyExists(URL, "year") AND URL.year EQ "">
                                <cfset new_date = createDate(year(now()), URL.month, 1)>
                                <tr><th colspan="8" style="font-size:14px;"><b>#UCase(dateFormat(new_date,"mmmm"))#_#dateFormat(now(),"yyyy")#</b></th></tr>
                            <cfelse>
                                <cfset new_date = createDate(year(now()), URL.month, 1)>
                                <tr><th colspan="8" style="font-size:14px;"><b>#UCase(dateFormat(new_date,"mmmm"))#_#URL.year#</b></th></tr>
                            </cfif>
                        </cfif>
                        <tr style="font-size:11px;background-color: #A4C2F4; text-align: center; height: 50px;">
                            <cfoutput>
                                <th style="width: 50px;" rowspan="2">SL NO</th>
                                <th style="width: 150px;" rowspan="2">Name</th>
                                <th style="width: 130px;" rowspan="2">Company Working Days</th>
                                <th style="width: 100px;" rowspan="2">Attendance</th>
                                <th style="width: 100px;" rowspan="2">Leave Count</th>
                                <cfset uniqueDates = {}>
                            <cfloop collection="#employeeDetails#" item="employeeName">
                                <cfloop collection="#employeeDetails[employeeName]#" item="dateKey">
                                    <cfset uniqueDates[dateKey] = parseDateTime(dateKey, "dd-mm-yyyy")>
                                </cfloop>
                            </cfloop>
                            <cfset sortedDates = structSort(uniqueDates, "numeric", "asc")>
                            <cfloop array="#sortedDates#" index="dateKey">
                                <th style="width: 250px;" colspan="2">#dateFormat(dateKey, "mm-dd-yyyy")#</th>
                            </cfloop>
                            </cfoutput>
                        </tr>
                        <tr class="text-center" style="font-size:small; vertical-align: middle; color: black; height: 50px;">
                            <cfloop array="#sortedDates#" item="dateKey">
                                <th  style="font-size: 11px;">Prod Hrs</th>
                                <th style="font-size: 11px;">Log Hrs</th>
                            </cfloop>
                        </tr>
                            
                    </thead>
                    <tbody style="background-color:#FEF7F5">
                        <cfset i=0>
                        <cfloop collection="#employeeDetails#" item="employeeName">
                            <cfset i++>
                            <tr style="font-size: 15px; text-align: center;">
                            <cfoutput>
                            <td>#i#</td>
                            <td>#employeeName#</td>
                            <td>#workingDaysCount#</td>
                            <cfif structKeyExists(employeeAttendanceCount, employeeName)>
                                <td> #employeeAttendanceCount[employeeName]#</td>
                            <cfelse>
                                <td style="color: red;">NIL</td>
                            </cfif>
                            <cfif structKeyExists(leaveCount, "#employeeName#")>
                                <td>#leaveCount[employeeName]#</td>
                            <cfelse>
                                 <td style="color: red;">NIL</td>
                            </cfif>
                            
                                <cfloop array="#sortedDates#" index="dateKey">
                                    <cfset details = employeeDetails[employeeName][dateKey]>
                                        <cfif structKeyExists(details, "produc_mins") AND details.produc_mins EQ 0>
                                        <cfif structKeyExists(details, "attendance") AND details.attendance NEQ 0>
                                            <td style="color: blue;"><b>Update Pending</b></td>
                                            <td>
                                                <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                    #Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins
                                                <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                    <span style="color: red;">NC</span>
                                                <cfelse>
                                                    <span style="color: red;">NIL</span>
                                                </cfif>
                                            </td>
                                        <cfelseif structKeyExists(details, "leave") AND details.leave>
                                            <td style="color: green;"><b>LEAVE</b></td> 
                                            <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                               <td>#Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins</td>
                                            <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                <td style="color: red;">NC</td>
                                            <cfelse>
                                                <td style="color: red;">NIL</td>
                                            </cfif>    
                                        <cfelseif structKeyExists(weekendDays, dateKey)>
                                            <cfif weekendDays[dateKey] EQ 7>
                                                <td style="color: purple;"><b>Saturday</b></td>
                                                <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                   <td>#Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins</td>
                                                <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                    <td style="color: red;">NC</td>
                                                <cfelse>
                                                    <td style="color: red;">NA</td>
                                                </cfif>  
                                            <cfelseif weekendDays[dateKey] EQ 1>
                                                <td style="color: purple;"><b>Sunday<b></td>
                                                <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                    <td>#Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins</td>
                                                 <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                    <td style="color: red;" style="color: red;">NC</td>
                                                <cfelse>
                                                    <td style="color: red;">NA</td>
                                                </cfif> 
                                                    </cfif>
                                        <cfelseif structKeyExists(holidayDetails, dateKey)>
                                            <td style="color: purple;"><b>#holidayDetails[dateKey]#</b></td> 
                                            <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                               <td>#Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins</td>
                                            <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                <td style="color: red;">NC</td>
                                            <cfelse>
                                                <td style="color: red;">NA</td>
                                            </cfif>        
                                        <cfelseif structKeyExists(details, "newJoinee") AND details.newJoinee EQ "yes">
                                            <td style="color: red;">NA</td>
                                            <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                               <td>#Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins</td>
                                            <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                <td style="color: red;">NC</td>
                                            <cfelse>
                                                <td style="color: red;">NIL</td>
                                            </cfif>        
                                        <cfelseif NOT structKeyExists(details, "attendance") AND NOT structKeyExists(details, "leave")>
                                            <td style="color: red;"><b>LOP</b></td> 
                                            <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                               <td>#Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins</td>
                                            <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                <td style="color: red;">NC</td>
                                            <cfelse>
                                                <td style="color: red;">NIL</td>
                                            </cfif>  

                                        </cfif>
                                <cfelse>
                                    <cfif structKeyExists(details, "produc_mins")>
                                        <cfif structKeyExists(details, "wfh") AND details.wfh>
                                            <cfset productiveHours = Int(details.produc_mins / 60)>
                                            <cfset productiveMinutes = details.produc_mins mod 60>
                                            <td >#productiveHours# Hrs #productiveMinutes# Mins<br><b class="text-center" style="color: green;">WFH</b></td>
                                            <td>
                                                <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                    #Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins
                                                <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                    <td style="color: red;">NC</td>
                                                <cfelse>
                                                    <td style="color: red;">NIL/td>
                                                </cfif>  
                                            </td>
                                        <cfelseif structKeyExists(details, "leave") AND details.leave>
                                            <cfset productiveHours = Int(details.produc_mins / 60)>
                                            <cfset productiveMinutes = details.produc_mins mod 60>
                                            <td>#productiveHours# hrs #productiveMinutes# min<br><b class="text-center" style="color: green; font-size: 13px;">HALFDAY LEAVE</b></td>
                                            <td>
                                                <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                    #Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins
                                                <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                    <td style="color: red;">NC</td>
                                                <cfelse>
                                                    <td style="color: red;">NIL</td>
                                                </cfif>  
                                            </td>
                                        <cfelse>
                                            <cfset productiveHours = Int(details.produc_mins / 60)>
                                            <cfset productiveMinutes = details.produc_mins mod 60>
                                            <td>#productiveHours# hrs #productiveMinutes# min</td>
                                            <td>
                                                <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                    #Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins
                                                 <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                    <span style="color: red;">NC</span>
                                                <cfelse>
                                                    <span style="color: red;">NIL</span>
                                                </cfif>  
                                            </td>
                                        </cfif>
                                    </cfif>
                                </cfif>
                            </cfloop>
                        </cfoutput>
                        </tr>
                    </cfloop>
                </table>
                </body>
            </html>  