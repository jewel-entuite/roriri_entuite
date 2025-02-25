<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>
<cfoutput>
    <style>
        .icon_status_ac{
            font-size: 9px; 
            vertical-align: middle; 
            color:##31a24c;
        }
        .icon_status_inac{
            font-size: 9px; 
            vertical-align: middle; 
            color:orange;
        }
        .icon_status_off{
            font-size: 9px; 
            vertical-align: middle; 
            color:orangered;
        }
        .icon_status_ac_wfh{
            font-size: 18px !important; 
            vertical-align: middle; 
            color:##31a24c;
        }
        .icon_status_inac_wfh{
            font-size: 18px !important; 
            vertical-align: middle; 
            color:orange;
        }
        .icon_status_off_wfh{
            font-size: 18px !important; 
            vertical-align: middle; 
            color:orangered;
        }

    </style>
<!--- invoke --->
    <cfinvoke component="models.employee" method="getAllEmployees" returnvariable="getAllEmployees"/>
        <!--- <cfdump var="#getAllEmployees#" abort> --->
        
<!--- invoke ends --->

<!--- header starts --->

    <header id="header" class="fixed-top d-flex align-items-center">
        <div class="container-fluid d-flex align-items-center justify-content-between">
            <div class="logo">
                <h2 class="text-light"><a href="admin_dashboard.cfm" style=" text-decoration: none;"><span><img class="img-fluid" src="../images/logo-black.jpeg" alt="" width="150"></span>&nbsp;&nbsp;&nbsp;<span style="color: ##534980; font-size:x-large;">Hi,&nbsp;<strong>#employeeList.first_name#</strong></span></a></h2>
            </div>
<!--- navbar starts --->
            <nav id="navbar" class="navbar">
                <ul>
<!--- home --->
                    <li><a class="nav-link scrollto active d-flex d-inline-flex" href="admin_dashboard.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-house-door mx-1"></i></span><span>Home</span></a></li>
<!--- home ends --->
                    <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large;" class="bi bi-person-workspace mx-1"></i></span><span>Workforce Structure</span></a>
                        <ul>
                            <li><a href="department.cfm">Department Details</a></li>
                            <li><a href="">Career level Details</a></li>
                            <li><a href="">Designation Details</a></li>
                        </ul>
                    </li>
<!--- Employee Management  --->
                    <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large;" class="bi bi-person-gear mx-1"></i></span><span>Employee Management</span></a>
                        <ul>
                            <!--- <li><a href="add_user.cfm">Add Employee</a></li> --->
                            <li><a href="all_employee_details.cfm">Employee Details</a></li>
  
                            <!--- <li><a href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&employee=&today">View Timesheet</a></li> --->
                            <!--- <li><a href="admin_employees_log.cfm">View Log Sheet</a></li> --->
                            <!--- Weekly Report --->
                            <!--- <li>
                            <!--- <a href="admin_weeklyreport_listing.cfm" class="bi bi-house-door mx-1">Weekly Report</a> --->
                                <a href="admin_weeklyreport_listing.cfm?emp_id=&year=&month=&FSdate=#dateFormat(dateAdd('d', -5, now()), 'yyyy-mm-dd')#&FEdate=#dateFormat(now(), 'yyyy-mm-dd')#">View Log Sheet</a>
                            </li> --->
                            <!--- <li><a href="employee_referral_form.cfm">Employee Referral</a></li> --->
                            <!--- <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">Employee Referral</a></li> --->

                            <!--- Weekly Report ends --->
                        </ul>
                    </li>
<!--- employee ends --->

<!--- project management : start--->
                    <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large; margin-top: 10px;" class="bi bi-journal-check mx-1"></i></span><span>Project Management</span></a>
                        <ul>
                            <li><a href="add_task.cfm">Add New Task</a></li>
                            <li><cfset FSdate = dateFormat(dateAdd("m", -2, now()), "yyyy-mm-01")>
                                <cfset FEdate = dateFormat(now(), "yyyy-mm-dd")>
                                <a href="assigned_task_details.cfm?tasks=&filtertaskId=&year=&month=&FSdate=#FSdate#&FEdate=#FEdate#&project=&module=&status=&handler=&assgn=&employeeid=&prior=">Task Details</a></li>

                        </ul>

                    </li>
<!--- project management : end --->

<!--- asset starts --->
                    <!--- <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-pc-display mx-1"></i></span><span>Asset Management</span></a> --->
                        <!--- <ul>
                            <!--- <li><a href="asset_registration_form.cfm">Add Device</a></li> --->
                            <li><a href="asset_list.cfm">Asset</a></li>
                            <li><a href="asset_assign.cfm?asset_id=">Assign Assets</a></li>
                            <!--- <li><a href="admin_assigned_asset_details.cfm">View Assigned Assets</a></li> --->
                        </ul> --->
                    </li>
<!--- asset ends --->

<!--- More --->
                    <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-list mx-1"></i></span><span>More</span></a>
                        <ul>
                            <!--- <li>
                                <a style=" text-decoration: none;" href="leave_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Apply</a>
                            </li> --->
                            <li>
                                <a href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&today">Timesheet</a>
                            </li>
                            <li>
                                <a href="admin_weeklyreport_listing.cfm?emp_id=&year=&month=&FSdate=#dateFormat(dateAdd('d', -5, now()), 'yyyy-mm-dd')#&FEdate=#dateFormat(now(), 'yyyy-mm-dd')#">Logsheet</a>
                            </li>
                            <li>
                                <a style=" text-decoration: none;" href="employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Leave</a>
                            </li>
                            <!--- <li>
                                <a style=" text-decoration: none;" href="employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">WFH</a>
                            </li> --->
                            <li>
                                <a href="company_leave_days.cfm">Company Holidays</a>
                            </li>
                        </ul>
                    </li>
<!--- leave ends --->

<!--- WFH starts --->
                    <!--- <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-house-check mx-1"></i></span><span>WFH</span></a>
                        <ul>
                            <li>
                                <a style=" text-decoration: none;" href="wfh_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Apply</a>
                            </li>
                            <li>
                                <a style=" text-decoration: none;" href="employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">View Personal History</a>
                            </li>
                            <li>
                              <a href="admin_employee_wfh_management.cfm"> Employee Requests</a>
                            </li>
                        </ul>
                    </li> --->
<!--- WFH ends --->

<!--- Status starts --->
                 <!---    <li class="dropdown"><a class="d-flex d-inline-flex"><span><i style="width:100%; font-size: large;" class="bi bi-clock mx-1"></i></span><span class="me-4">Status</span></a>
                        <ul>
                            <div style="width:250px;"><p id="test"></p>
                                <cfset i=0>
                                <cfloop query="getAllEmployees">
                                    <cfset i++>
                                    <cfinvoke component="models.logsheet" method="getClockStatus" emp_id="#getAllEmployees.id#" returnvariable="clockStatus">
                                        <cfinvoke component="models.logsheet" method="WFH_status" id="#getAllEmployees.id#"  returnvariable="WFH_status"/>
                                        <cfset de_clockStatus = deserializeJSON(clockStatus)>
                                    <li>
                                        <a href="admin_all_employee_details.cfm?id=#encrypt(getAllEmployees.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">
                                            <div class="row" style="width:240px;">
                                                <div class="col-6">
                                                    <cfset fullname = getAllEmployees.first_name & getAllEmployees.last_name>
                                                    #ucFirst(getAllEmployees.first_name,true,true)# 
                                                    <cfif Len(fullname) LTE 17>
                                                        <cfif Len(getAllEmployees.last_name) LTE 2>
                                                            #uCase(getAllEmployees.last_name)#
                                                        <cfelseif Len(getAllEmployees.last_name) GT 2>
                                                            #ucFirst(getAllEmployees.last_name,true,true)#
                                                        </cfif>
                                                    </cfif>
                                                </div>
                                                <div class="col-1"></div>
                                                <div class="col-4">
                                                    <div id="active#getAllEmployees.id#">
                                                        <cfif de_clockStatus.STATUS EQ "Active">
                                                            <i <cfif WFH_status GT 0>class="bi bi-house-check icon_status_ac_wfh me-2"<cfelse>class="bi bi-circle-fill icon_status_ac me-2"</cfif>></i><span>Active</span>
                                                        </cfif>
                                                    </div>
                                                    <div id="inactive#getAllEmployees.id#">
                                                        <cfif de_clockStatus.STATUS EQ "inactive">
                                                            <i <cfif WFH_status GT 0>class="bi bi-house-exclamation icon_status_inac_wfh me-2"<cfelse>class="bi bi-circle-fill icon_status_inac me-2"</cfif>></i><span>Inactive</span>
                                                        </cfif>
                                                    </div>
                                                    <div id="offline#getAllEmployees.id#">
                                                        <cfif de_clockStatus.STATUS EQ "offline">
                                                            <i <cfif WFH_status GT 0>class="bi bi-house-dash icon_status_off_wfh me-2"<cfelse>class="bi bi-circle-fill icon_status_off me-2"</cfif>></i><span>Offline</span>
                                                        </cfif>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <script>
                                        function liveStatus(){
                                            var id=#getAllEmployees.id#;
                                            $.ajax({
                                                    type:'GET',
                                                url:'../models/logsheet.cfc',
                                                data:{
                                                    method:'getClockStatus',
                                                    emp_id:id,
                                                },
                                                success:(res)=>{
                                                    var obj = JSON.parse(res);
                                                    // console.log(res)
                                                    if (obj.STATUS=="Active"){
                                                        document.getElementById("active"+obj.EMP_ID).innerHTML='<i  <cfif WFH_status GT 0>class="bi bi-house-check icon_status_ac_wfh me-2"<cfelse>class="bi bi-circle-fill icon_status_ac me-2"</cfif>></i><span>Active</span>'
                                                    }else if (obj.STATUS=="Inactive") {
                                                        document.getElementById("inactive"+obj.EMP_ID).innerHTML='<i <cfif WFH_status GT 0>class="bi bi-house-exclamation icon_status_inac_wfh me-2"<cfelse>class="bi bi-circle-fill icon_status_inac me-2"</cfif>></i><span>Inactive</span>'
                                                    }
                                                    else if (obj.STATUS=="Offline") {
                                                        document.getElementById("offline"+obj.EMP_ID).innerHTML='<i <cfif WFH_status GT 0>class="bi bi-house-dash icon_status_off_wfh me-2"<cfelse>class="bi bi-circle-fill icon_status_off me-2"</cfif>></i><span>Offline</span>'
                                                    }else{
                                                        console.log("error")
                                                    }
                                                }
                                            })
                                        }
                                        liveStatus();
                                    </script>
                                </cfloop>
                            <div>
                        </ul>
                    </li> --->
<!--- status ends --->

<!--- Clock in/out starts --->
                    <!--- <li>
                        <form name="clockSubmit" method="post">
                            <span class="clockin_button"><input type="button" name="clockBtn" id="clockBtn" onclick="checkClock()" 
                            <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">value="Clock Out" class="btn btn-sm" style="background-color: red;color: white;border-radius: 30px;"
                            <cfelse> value="Clock In" class="btn btn-sm"</cfif> style="background-color: blue;color: white; border-radius: 30px;"></span>
                            <input type="hidden" id="ip" name="ip">
                            <input type="hidden" name="clockTime" id="clockTime">
                        </form>
                    </li> --->
<!--- Clock in/out ends --->

<!--- calendar --->
                    <a class="d-flex d-inline-flex" style=" text-decoration: none;" href="yearly_calendar.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-calendar2-check mx-1" data-toggle="tooltip" data-placement="top" title="Calendar"></i></span></a>
<!--- calendar ends --->

<!--- logout button --->
                    <li><a class="getstarted scrollto button" href="logout.cfm" data-toggle="tooltip" title="Logout"><i class="bi bi-box-arrow-right" style="font-size:small;"></i></a></li>
                </ul>
                <i class="bi bi-list mobile-nav-toggle"></i>
            </nav>
<!-- navbar ends -->
        </div>
    </header>
<!--- header ends --->
    <script>
        function callIp(){
            fetch('https://api.ipify.org')
        .then((res)=> res.text())
        .then(ip=> document.getElementById('ip').value=ip)
        .catch(err=> console.log(err))
        }
        // setInterval(callIp, 500);
        callIp();
        callIp();
        callIp();
        callIp();
        callIp();
    </script>
    </cfoutput>