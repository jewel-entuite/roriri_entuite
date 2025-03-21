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

    <link rel="stylesheet" href="assets/css/style.css">
    <title>RORIRI -Weekly Report</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">
        <style>
            .pointer {
              cursor: pointer;
            }
            .tag .remove {
              margin-left: 5px;
              color: #333;
              cursor: pointer;
             /*display: none;*/
            }
            .tag {
              display: inline-flex;
              align-items: center;
              background-color: #e0e0e0;
              padding: 4px 8px;
              border-radius: 10px;
              font-size: 14px;
              color: #333;
            }
            .selected-tags {
            /*margin-top: 10px;*/
              display: flex;
              flex-wrap: wrap;
              gap: 10px;
            }
            .clear-all {
              margin-top: 1px;
              color: gray;
              cursor: pointer;
              font-size: 16px;
              display: none; /* Hide initially */
              text-decoration: underline; /* Adds underline */
            }
            select {
              padding: 8px;
              font-size: 14px;
              border: 1px solid #ccc;
              border-radius: 5px;
              width: 200px;
            }
            .selected-count {
              margin-top: 1px;
              font-size: 16px;
              color: dimgray;
              font-weight: bold;
              display: none; /* Hide initially */
            }
            .selected-filter{
              padding: 0px 50px 11px 55px;
              margin-top:-26px;
            }
            .custom-btn {
              background: #fff;
              color: #7d66e3;
              border: 1px solid #7d66e3;
              border-radius: 5px;
              text-decoration: none;
              width:150px;
              padding: 4px;
              justify-content:center;
            }
            .custom-btn:hover {
              background: #7d66e3;
              color: #fff;
            }
            #loader {
              position: fixed;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
              z-index: 9999;
            }
            #overlay {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
              z-index: 1000; /* Lower z-index */
            }
        </style>    
    <!-- Template Main CSS File -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
</head>
<body>
    <cfif structKeyExists(url, "emp_id") AND decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX') NEQ "">
        <cfinvoke component="models.Weeklyreport" emp_id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" method="getEmployeesDetails" returnvariable="getEmployees"/>
    <cfelse>
        <cfinvoke component="models.Weeklyreport" method="getEmployeesDetails" returnvariable="getEmployees"/>
    </cfif>
    <cfinvoke component="models.Weeklyreport" method="getTimesheetEmployees" returnvariable="allemployee"/>
     
<!--- header --->
    <cfset print="admin_weekly_report_print">
    <cfset active_status="weekly_report">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
<!--- header ends --->
<cfoutput>
    <cfif structKeyExists(url, "emp_id") AND structKeyExists(url, "FSdate") AND structKeyExists(url, "FEdate") AND url.FEdate NEQ "" AND url.FEdate NEQ "">
        <div class="section-title pt-5" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
            <h2>Employee Management</h2>
            <p>WEEKLY REPORT<span>&nbsp;[#dateFormat(url.FSdate,"mmm-dd-yy")#&nbsp; TO &nbsp;#dateFormat(url.FEdate,"mmm-dd-yy")#]</span></p>
        </div>
    <cfelse>
        <div class="card shadow p-3 alert alert-warning" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
            <center><h3><strong>WEEKLY REPORT</strong></h3></center>
        </div>
    </cfif>
    <div class="row mt-5 me-4 ms-5 pt-5">
       <div class="col-6"></div>
          <div class="col-6 d-flex justify-content-end">
                <!--- <a class="btn btn-outline-light custom-btn btn-sm me-2" href="add_user.cfm" role="button">New Employee</a> --->
                <!--- <a class="btn btn-outline-light custom-btn btn-sm me-2" href="all_employee_details.cfm" role="button">Employee List</a> --->
                <!--- <a class="btn btn-outline-light custom-btn btn-sm me-2" href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&employee=&today" role="button">Timesheet</a> --->
                <!--- <form action="../views/resigned_employee_list.cfm" method="post"> --->
                <!--- <div style="margin-left: 53%; margin-top:-5%" class="mb-5 pb-5"> --->
                <!--- <a class="btn btn-outline-light custom-btn btn-sm me-3" type="submit" href="resigned_employee_list.cfm">Resigned Employees</a> --->
                <!--- </div> --->
              <!--- </form>  --->
          </div>
       </div>
</cfoutput>
<!--- weeklyreport filter --->
<div class="shadow card m-5 my-3">
    <div class="ms-4 my-2 mt-4 fw-bold" style="font-size: 0.9rem; color:#7d66e3;">
            <label>WEEKLY REPORT </label>
        </div>
        <hr>
        <div id="overlay" style="display: none;"></div>
            <div id="loader" style="display: none;">
                <img src="../assets/img/loader.gif" width="50" height="50" alt="Loading...">
            </div>
<div class="container my-5 mt-1 ms-5 ">
    <div class="row my-4 me-5 justify-content-start">
        <!--- <div class="col-lg-2"></div> --->
        <cfoutput>
            <div class="col-lg-3">
                <label for="admin_filter_start_Date" class="mb-1">Start Date</label>
                <input type="date" class="form-control border-dark" name="admin_filter_start_Date" id="admin_filter_start_Date" onchange="filter()"<cfif structKeyExists(url, "FSdate") AND url.FSdate NEQ  ""> value="#URL.FSdate#"</cfif>>
            </div>
            
            <div class="col-lg-3">
                <label for="admin_filter_end_Date" class="mb-1">End Date</label>
                <input type="date" class="form-control border-dark" name="admin_filter_end_Date" id="admin_filter_end_Date" onchange="filter()"<cfif structKeyExists(url, "FEdate") AND url.FEdate NEQ ""> value="#URL.FEdate#"</cfif>>
            </div>
            
            <div class="col-lg-3">
                <label for="empid" class="mb-1">Choose Employee</label>
                    <select class="form-select border-dark show-selected-tags" name="empid" id="empid" onchange="filter()">
                        <option class="dropdown-item" value="">All Employees</option>
                        <cfoutput query="#allemployee#">
                            <option class="dropdown-item" value="#encrypt(allemployee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" <cfif structKeyExists(url, "emp_id") AND decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX') EQ allemployee.id> selected </cfif>>#allemployee.first_name#</option>
                        </cfoutput>
                    </select>
            </div>
        </cfoutput>
        </div>
    </div>
<!--- </div> --->
<div class="row selected-filter ">
                    <div id="selected-count" class="col-2 selected-count">Filter's Selected:0</div>
                    <div class="col-1 clear-all" onclick="clearAll()">Clear All</div>
                    <div id="selected-tags" class="col-9 selected-tags "></div>
                    <!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
                    <!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
               </div>
<!--- listing table ---> 

<cfif structKeyExists(url, "emp_id") AND structKeyExists(url, "FSdate") AND structKeyExists(url, "FEdate") AND url.FEdate NEQ "" AND url.FEdate NEQ "">
            <cfinvoke component="models.Weeklyreport" FSdate="#url.FSdate#" FEdate="#url.FEdate#" emp_id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" method="getAllEmployeeDetails" returnvariable="detailsStruct"/>
            <cfset employeeDetails =detailsStruct.employeeDetails>
            <cfset employeeAttendanceCount =detailsStruct.attendanceCount>
            <cfset leaveCount =detailsStruct.leaveCount>
            <cfset weekendDays =detailsStruct.weekendDays>
            <cfset holidayDetails =detailsStruct.holidayDetails>
            <cfset allEmployeeDetails=detailsStruct.allEmployeeDetails>
            <cfset workingDaysCount=detailsStruct.workingDaysCount>
            <cfset employeeList=detailsStruct.employeeList>
        <div style="overflow-x:auto;" class="m-5 my-0">
            <style>
                table{
                    border: 5px solid black;
                    border-radius: 20px;
                }
            </style>
    <cfif allEmployeeDetails.timesheet.recordcount GT 0  >
            <table class="table table-striped border-dark" style="overflow: hidden; table-layout: fixed;">
                <thead style="background-color:#31394F;">
                    <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <cfoutput>
                            <th style="width: 50px;" rowspan="2">SL NO</th>
                            <th style="width: 150px;" rowspan="2">Name</th>
                            <th style="width: 130px;" rowspan="2">Company Working Days</th>
                            <th style="width: 100px;" rowspan="2">Attendance</th>
                            <th style="width: 100px;" rowspan="2">Leave Count</th>
                            <cfset uniqueDates = {}>
                            <cfloop collection="#employeeDetails#" item="employeeName">
                                <cfloop collection="#employeeDetails[employeeName]#" item="dateKey">
                                    <cfset uniqueDates[dateKey] = parseDateTime(dateKey, "mm-dd-yyyy")>
                                </cfloop>
                            </cfloop>
                            
                            <cfset sortedDates = structSort(uniqueDates, "numeric", "asc")>
                            <cfloop from=#url.FSdate# to="#URL.FEdate#" index="i" step="#CreateTimeSpan(1,0,0,0)#">
                            <!--- <cfdump var="#dateformat(i, "mm/dd/yyyy")#"> --->
                                <th style="width: 250px;" colspan="2">#dateformat(i, "mm-dd-yyyy")#</th>
                            <!--- <cfloop array="#sortedDates#" item="dateKey">
                                <th style="width: 250px;" colspan="2">#parseDateTime(dateFormat(dateKey, "mm-dd-yyyy"))#</th>
                            </cfloop> --->
                           </cfloop>
                        </cfoutput>
                    </tr>
                    <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <cfloop array="#sortedDates#" item="dateKey">
                            <th>Prod Hrs</th>
                            <th>Log Hrs</th>
                        </cfloop>
                    </tr>
                </thead>
                <tbody style="background-color:#FEF7F5;">
                    <cfset i=0>
                    <cfloop collection="#employeeDetails#" item="employeeName">
                        <cfset i++>
                        <tr class="text-center" style="font-size: 15px;">
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
                                    <td style="color: blue;font-size: 11px;"><b>Update Pending</b></td>
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
                                            <td style="color: red;">NC</td>
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
                                        <td >#productiveHours# Hrs #productiveMinutes# Mins<br><b style="color: green;">WFH</b></td>
                                        <td>
                                            <cfif structKeyExists(details, "log_hrs") AND details.log_hrs NEQ 0>
                                                #Int(details.log_hrs / 60)# Hrs #details.log_hrs mod 60# Mins
                                            <cfelseif  structKeyExists(details, "log_hrs") AND details.log_hrs EQ 0 AND structKeyExists(details, "no_log_hrs") AND details.no_log_hrs EQ 1>
                                                <td style="color: red;">NC</td>
                                            <cfelse>
                                                <td style="color: red;">NIL</td>
                                            </cfif>  
                                        </td>
                                    <cfelseif structKeyExists(details, "leave") AND details.leave>
                                        <cfset productiveHours = Int(details.produc_mins / 60)>
                                        <cfset productiveMinutes = details.produc_mins mod 60>
                                        <td>#productiveHours# Hrs #productiveMinutes# Mins<br><b style="color: green; font-size: 11px;">HALFDAY LEAVE</b></td>
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
                                        <td>#productiveHours# Hrs #productiveMinutes# Mins</td>
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
        <cfelse>
            <table class="table table-striped border-dark" style="overflow: hidden; table-layout: fixed;">
                <thead style="background-color:#31394F;">
                    <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <cfoutput>
                            <th style="width: 50px;" rowspan="2">SL NO</th>
                            <th style="width: 150px;" rowspan="2">Name</th>
                            <th style="width: 130px;" rowspan="2">Company Working Days</th>
                            <th style="width: 100px;" rowspan="2">Attendance</th>
                            <th style="width: 100px;" rowspan="2">Leave Count</th>
                            <cfset uniqueDates = {}>
                            <cfloop collection="#employeeDetails#" item="employeeName">
                                <cfloop collection="#employeeDetails[employeeName]#" item="dateKey">
                                    <cfset uniqueDates[dateKey] = parseDateTime(dateKey, "mm-dd-yyyy")>
                                </cfloop>
                            </cfloop>
                            
                            <cfset sortedDates = structSort(uniqueDates, "numeric", "asc")>
                            
                            <cfloop array="#sortedDates#" item="dateKey">
                                <th style="width: 250px;" colspan="2">#dateKey#</th>
                            </cfloop>
                        </cfoutput>
                    </tr>
                    <tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
                        <cfloop array="#sortedDates#" item="dateKey">
                            <th>Prod Hrs</th>
                            <th>Log Hrs</th>
                        </cfloop>
                    </tr>
                </thead>
            </table>
            <cfoutput>
                    <center><div><tr><td colspan="12" class="text-center"><h3 class="my-5">No Records Found!</h3></td></tr> </div></center>
             </cfoutput>
        </cfif>
            <cfelse>
                <cfoutput>
                    <center><div><tr><td colspan="12" class="text-center"><h3 class="my-5">No Records Found!</h3></td></tr> </div></center>
                </cfoutput>
            </div>
     </div>
</cfif>
        <script>
            function formatDate(date) {
                return date.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
            }
            function filter(){
                var FSdate = document.getElementById("admin_filter_start_Date").value;
                var FEdate = document.getElementById("admin_filter_end_Date").value;
                var emp_id = document.getElementById("empid").value;
                location.href="admin_weeklyreport_listing.cfm?FSdate="+FSdate+"&FEdate="+FEdate+"&emp_id="+emp_id;
                document.getElementById("loader").style.display = 'block';
                document.getElementById("overlay").style.display = 'block';
            }
            function addTag() {
            const selectedTagsDiv = document.getElementById("selected-tags");
            const allElements = document.querySelectorAll(".show-selected-tags");

            allElements.forEach(dropdown => {
                let valueText = dropdown.options[dropdown.selectedIndex].innerHTML;
                const selectedValue = dropdown.value;
                const dropdownId = dropdown.id;

                // Prevent adding empty or duplicate tags
                if (!selectedValue || Array.from(selectedTagsDiv.children).some(tag => tag.getAttribute("data-dropdown") === dropdownId)) {
                    return;
                }

                const labelText = getLabelForDropdown(dropdownId);

                // Create the tag with an identifier for the dropdown
                const tag = document.createElement("div");
                tag.id = `select-tags${dropdown.id}`;
                tag.className = "tag";
                tag.setAttribute("data-dropdown", dropdownId);
                tag.innerHTML = `<strong>${labelText}:</strong>&nbsp;${valueText}<span class="remove" onclick="removeTag(this)">&nbsp;&times;</span>`;

            function getLabelForDropdown(dropdownId) {
                    switch(dropdownId) {
                        case "empid": return "Choose Employee";
                        default: return "Label";
                    }
                }

                // Add or update the tag in the selected tags area
                if (document.getElementById(`select-tags${dropdown.id}`) != null) {
                    if (dropdown.value != "") {
                        document.getElementById(`select-tags${dropdown.id}`).outerHTML = tag.outerHTML;
                    } else {
                        document.getElementById(`select-tags${dropdown.id}`).remove();
                    }
                } else {
                    if (dropdown.value != "") {
                        selectedTagsDiv.appendChild(tag);
                    }
                }

                showClearAllButton();
                updateSelectedCount();
            });
        }

            function removeTag(element) {
                console.log(element);
            const tag = element.parentElement;
            const dropdownId = tag.getAttribute("data-dropdown");

            // Reset the corresponding dropdown
            const dropdown = document.getElementById(dropdownId);
            if (dropdown) {
                dropdown.value = ""; // Reset dropdown to placeholder option
                dropdown.dispatchEvent(new Event('change'));
            }

            // Remove the tag
            tag.remove();

            // Hide the "Clear All" button if there are no selected tags
            hideClearAllButton();

            // Update selected count
            updateSelectedCount();
        }

            function clearAll() {
            // Reset all dropdowns to their placeholder options
            const dropdowns = document.querySelectorAll(".show-selected-tags");
            dropdowns.forEach(dropdown => {
                dropdown.value = ""; // Reset to empty
            });

            // Remove all tags
            const selectedTagsDiv = document.getElementById("selected-tags");
            selectedTagsDiv.innerHTML = "";

            // Hide the "Clear All" button after clearing
            hideClearAllButton();

            // Update selected count
            updateSelectedCount();
             document.getElementById("admin_filter_start_Date").value = new Date().toISOString().split('T')[0];
            // location.reload();
            dropdowns[0].dispatchEvent(new Event('change'));
        }

            function showClearAllButton() {
            const clearAllButton = document.querySelector(".clear-all");
            clearAllButton.style.display = "inline-block"; // Show the button
        }

            function hideClearAllButton() {
            const selectedTagsDiv = document.getElementById("selected-tags");
            const clearAllButton = document.querySelector(".clear-all");

            // Hide the "Clear All" button if there are no tags selected
            if (selectedTagsDiv.children.length === 0) {
                clearAllButton.style.display = "none";
            }
        }

            function updateSelectedCount() {
            const selectedTagsDiv = document.getElementById("selected-tags");
            const selectedCountDiv = document.getElementById("selected-count");

            // Update count and toggle visibility
            const count = selectedTagsDiv.children.length;
            selectedCountDiv.innerText = `Filter's Selected: (${count})`;
            selectedCountDiv.style.display = count > 0 ? "block" : "none";
        }

            document.addEventListener("DOMContentLoaded", function(e) {
            addTag();
        });
        </script>
            <!-- Vendor JS Files -->
            <script src="assets/vendor/aos/aos.js"></script>
            <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
            <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
            <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
            <script src="assets/vendor/php-email-form/validate.js"></script>
        
          <!-- Template Main JS File -->
            <script src="assets/js/main.js"></script>
    </body>