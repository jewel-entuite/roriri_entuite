<html>
<style>
  .navbar .getstarted,
.navbar .getstarted:focus {
  background: 7d66e3;
  color: fff;
  padding: 10px 25px;
  border-radius: 50px;
}
.navbar a {
  text-decoration: none;
}

.back_button{
    align-items: center;
}
@media(max-width: 991px) {
  .back_button{
    width: 78px;
    height: 39px;
  }
}
</style>
<cftry>
    <!--- current month timesheet --->
    <cfset currentDateTime = now()>
    <cfset currentMonth = createDateTime(year(currentDateTime),month(currentDateTime),1,0,0,0)>
    <cfset formattedCurrentMonth = dateFormat(currentMonth, "yyyy-mm-dd")>
    <cfset currentDate = now()>
    <cfset formattedCurrentdate = dateFormat(currentDate, "yyyy-mm-dd")>
    <cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>
 <cfoutput>
    <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
    <cfinvoke component="models.employee" method="getemployee" id="#session.EMPLOYEE.ID#" returnvariable="employeeList1"/>
    <cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
    <cfinvoke component="models.employee" method="getAllEmployees" returnvariable="getAllEmployees">

      <header id="header" class="fixed-top d-flex align-items-center">
        <div class="container-fluid d-flex align-items-center justify-content-between">
            <div class="logo">
                <h2 class="text-light"><a href="admin_dashboard.cfm" style=" text-decoration: none;"><span><img class="img-fluid" src="../images/logo-black.jpeg" alt="" width="150"></span>&nbsp;&nbsp;&nbsp;<span style="color: ##534980; font-size:x-large;">Hi,&nbsp;<strong>#employeeList.first_name#</strong></span></a></h2>
            </div>
<!--- navbar starts --->
            <nav id="navbar" class="navbar">
                <ul>
<!--- home --->
                    <cfif session.employee.role_id EQ 1>
                        <li><a class="nav-link scrollto active d-flex d-inline-flex" href="admin_dashboard.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-house-door mx-1"></i></span><span>Home</span></a></li>
                    </cfif>
                    <cfif session.employee.role_id EQ 4>
                        <li><a style=" text-decoration: none;" class="nav-link scrollto active d-flex d-inline-flex" href="dashboard.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-house-door mx-1"></i></span><span>Home</span></a></li>
                    </cfif>
<!--- home ends --->
<!--- Profile --->      <cfif session.employee.role_id EQ 4>
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-person-circle mx-1"></i></span><span>Profile</span></a>
                            <ul>
                                <li>
                                    <a href="employee_profile_list.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">View Profile</a>
                                </li>
                                <li>
                                    <a href="employee_asset_details.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Asset Details</a>
                                </li>
                                <!--- <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">Employee Referral</a></li> --->
                                
                                <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">Employee Referral</a></li>                           
                            </ul>
                        </li>
                        </cfif>

<!--- Employee Management  --->
                    <cfif session.employee.role_id EQ 1>
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large;" class="bi bi-person-gear mx-1"></i></span><span>Employee Management</span></a>
                            <ul>
                                <!--- <li><a href="add_user.cfm">Add Employee</a></li> --->
                                <li><a href="all_employee_details.cfm">Employee Details</a></li>      
                                <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">Employee Referral</a></li>

                            <!--- Weekly Report ends --->
                            </ul>
                        </li>
                    </cfif>
<!--- employee ends --->
<!--- project management : start--->
                    <cfif session.employee.role_id EQ 1>
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large; margin-top: 10px;" class="bi bi-journal-check mx-1"></i></span><span>Project Management</span></a>
                            <ul>
                                <li><a href="add_task.cfm">Add New Task</a></li>
                                <li><cfset FSdate = dateFormat(dateAdd("m", -2, now()), "yyyy-mm-01")>
                                    <cfset FEdate = dateFormat(now(), "yyyy-mm-dd")>
                                    <a href="assigned_task_details.cfm?tasks=&filtertaskId=&year=&month=&FSdate=#FSdate#&FEdate=#FEdate#&project=&module=&status=&handler=&assgn=&employeeid=&prior=">Task Details</a></li>
                            </ul>
                        </li>
                    </cfif>   

<!--- project management : end --->
<!--- asset starts --->
                    <cfif session.employee.role_id EQ 1>
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-pc-display mx-1"></i></span><span>Asset Management</span></a>
                            <ul>
                            <!--- <li><a href="asset_registration_form.cfm">Add Device</a></li> --->
                                <li><a href="asset_list.cfm">Asset</a></li>
                                <li><a href="asset_assign.cfm?asset_id=">Assign Assets</a></li>
                            </ul>
                        </li>
                    </cfif>    
<!--- asset ends --->                    
<!--- More starts --->
                 <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-list mx-1"></i></span><span>More</span></a>
                        <ul>
                            <!--- <li>
                                <a style=" text-decoration: none;" href="leave_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Apply</a>
                            </li> --->
                            <cfif session.employee.role_id EQ 4>
                                <li>
                                    <a style=" text-decoration: none;" href="listing.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&project=&year=&month=&FSdate=#formattedCurrentMonth#&FEdate=#formattedCurrentdate#&module=&status=&req=&assgn=&emp_id=&employeeid=">Timesheet</a>
                                </li>
                            <cfelse>    
                                <li>
                                    <a href="admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=#dateFormat(now(),'yyyy-mm-dd')#&FEdate=#dateFormat(now(),'yyyy-mm-dd')#&module=&status=&req=&assgn=&today">Timesheet</a>
                                </li>
                            </cfif>
                            <cfif session.employee.role_id EQ 1>
                                <li>
                                    <a href="admin_weeklyreport_listing.cfm?emp_id=&year=&month=&FSdate=#dateFormat(dateAdd('d', -5, now()), 'yyyy-mm-dd')#&FEdate=#dateFormat(now(), 'yyyy-mm-dd')#">Logsheet</a>
                                </li>
                                <li>
                                    <a href="_roles.cfm">roles</a>
                                </li>
                            <cfelse>
                                <li>
                                    <a style=" text-decoration: none;" href="attendance_log.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Logsheet</a>
                                </li>
                            </cfif>    
                                <li>
                                    <a style=" text-decoration: none;" href="employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Leave</a>
                                </li>
                                <li>
                                    <a style=" text-decoration: none;" href="employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">WFH</a>
                                </li>
                            <cfif session.employee.role_id EQ 1>
                                <li>
                                    <a href="company_leave_days.cfm">Company Holidays</a>
                                </li>
                            </cfif>
                        </ul>
                  </li>
<!--- More ends --->
                   <cfif session.employee.role_id EQ 4>    
                        <cfinvoke component="models.leaves" method="getwfhapproved" emp_id="#session.employee.id#" returnvariable="approved_wfh">
                        <cfinvoke component="models.leaves" method="getleaveapproved" emp_id="#session.employee.id#" returnvariable="approved_leave">
                            
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;"class="bi bi-bell-fill mx-1"></i></span></a>
                                    <cfset recod_count=queryRecordCount(approved_leave)+queryRecordCount(approved_wfh)>
                           <cfif recod_count GT 0>
                                 <span class="position-absolute top-5 start-95 translate-middle badge rounded-pill bg-danger">
                                    #recod_count#
                                    <span class="visually-hidden">unread messages</span>   
                                 </span>
                            </cfif>
                        </span>
                            <ul><cfset leave_inx = 1>
                                <cfset wfh_inx = 1>
                                <cfloop query="approved_leave">
                                     <li>
                                        <cfset form_name = "form_"&leave_inx>
                                        <form name="#form_name#" method="post" action="../controller/_notification.cfm">
                                        <span style="cursor: pointer;"><a onclick="document.#form_name#.submit()">Leave applied on (#dateFormat(approved_leave.created_date,"dd-mm-yyyy")#)<br> has been approved.</a></span>
                                        <input type="hidden" value="#approved_leave.id#" name="leave_read">
                                        </form>
                                    </li>
                                    <cfset leave_inx ++>
                                </cfloop>
                                
                                <cfloop query="approved_wfh">
                                     <li>
                                        <cfset form_name = "form"&wfh_inx>
                                        <form name="#form_name#" method="post" action="../controller/_notification.cfm">
                                        <span style="cursor: pointer;"><a onclick="document.#form_name#.submit()">WFH applied on (#dateFormat(approved_wfh.created_date,"dd-mm-yyyy")#)<br>has been approved.</a></span>
                                        <input type="hidden" value="#approved_wfh.id#" name="wfh_read">
                                        </form>
                                    </li>

                                    <cfset wfh_inx ++>
                                </cfloop>
                            </ul>
                        </li>
                   </cfif>               
<!--- Status starts --->
                 <cfif session.employee.role_id EQ 1>
                    <cfif (isDefined("page") AND (page EQ "dashboard" OR page EQ "admin_dashboard"))>
                    <li class="dropdown"><a class="d-flex d-inline-flex"><span><i style="width:100%; font-size: large;" class="bi bi-clock mx-1"></i></span><span class="me-4">Status</span></a>
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
                    </li>
                </cfif>
            </cfif>

<!--- status ends --->
                        <cfif session.employee.role_id EQ 1>
                            <cfif NOT (isDefined("page") AND (page EQ "dashboard" OR page EQ "admin_dashboard"))>
                                <li>
                                    <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">
                                        <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: red;" data-toggle="tooltip" data-placement="top" title="Clocked In"></i></span>
                                    <cfelse>
                                        <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: grey;" data-toggle="tooltip" data-placement="top" title="Clocked Out"></i></span>
                                    </cfif>
                                </li>
                            </cfif>
                        </cfif>
                        <cfif session.employee.role_id EQ 4>
                            <cfif NOT (isDefined("page") AND (page EQ "dashboard" OR page EQ "admin_dashboard"))>
                            <div style="font-size:20px; margin-left: 20px;">
                                <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">
                                  <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: red;" data-toggle="tooltip" data-placement="top" title="Clocked In"></i></span>
                                <cfelse>
                                  <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: grey;" data-toggle="tooltip" data-placement="top" title="Clocked Out"></i></span>
                                </cfif>
                            </div>
                            </cfif>
                        </cfif>
<!--- clock in/out ---> 
                        <cfif session.employee.role_id EQ 4>
                            <cfif (isDefined("page") AND page EQ "dashboard")>                       
                                <li>
                                    <div style=" margin-left: 20px; margin-right: 20px;">
                                      <form name="clockSubmit" method="post">
                                          <span class="clockin_button d-flex align-items-center"><input type="button" name="clockBtn" id="clockBtn" onclick="checkClock()" 
                                          <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">value="Clock Out" class="btn btn-sm" style="background-color: red;color: white;border-radius: 20px;"
                                          <cfelse> value="Clock In" class="btn btn-sm btn-primary"</cfif>style="border-radius: 20px;">
                                            <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">
                                               <span class="clock bi bi-hourglass-split ms-4 me-1"></span><span id="clocktimer"></span>
                                            </cfif>
                                          </span>
                                          <input type="hidden" name="clockTime" id="clockTime">
                                          <input type="hidden" id="ip" name="ip">
                                      </form>
                                    </div>
                                </li>
                                <div id="colocktimer"></div>
                            </cfif>
                        </cfif>
                        <cfif session.employee.role_id EQ 1>
                            <cfif (isDefined("page") AND (page EQ "dashboard" OR page EQ "admin_dashboard"))>
                                <li>
                                    <form name="clockSubmit" method="post">
                                        <span class="clockin_button"><input type="button" name="clockBtn" id="clockBtn" onclick="checkClock()" 
                                        <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">value="Clock Out" class="btn btn-sm" style="background-color: red;color: white;border-radius: 30px;"
                                        <cfelse> value="Clock In" class="btn btn-sm"</cfif> style="background-color: blue;color: white; border-radius: 30px;"></span>
                                        <input type="hidden" id="ip" name="ip">
                                        <input type="hidden" name="clockTime" id="clockTime">
                                    </form>
                                </li>
                            </cfif>
                        </cfif>
<!--- calendar --->                            
          <a class="d-flex d-inline-flex <cfif isDefined("active_status")AND active_status EQ "calendar">active </cfif>" style=" text-decoration: none;" href="yearly_calendar.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-calendar2-check mx-1" data-toggle="tooltip" data-placement="top" title="Calendar"></i></span></a>
<!--- back button starts --->
            <cfif NOT (isDefined("page") AND (page EQ "dashboard" OR page EQ "admin_dashboard"))>
                <li>
                    <a class="getstarted back_button" href="
                        <cfif structKeyExists(url, "token")>
                            all_employee_details.cfm
                        <cfelseif structKeyExists(url, "token1")>
                            admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=&FEdate=&module=&status=&req=&assgn=&employeename=&today 
                        <cfelseif structKeyExists(url, "token2")>
                            admin_employees_log.cfm?Emp_id="+Emp_id+"&startDate="+startDate+"&endDate="+endDate
                        <cfelseif structKeyExists(url, "token2")>
                        <cfelseif  isDefined("backbutton") AND backbutton EQ "employee_leave_history">
                         leave_application_form.cfm?id=#url.id# 
                        <cfelseif isDefined("backbutton") AND backbutton EQ "employee_profile">
                            employee_profile_list.cfm?id=#url.id#
                        <cfelseif  isDefined("backbutton1") AND backbutton EQ "employee_leave_history"> 
                            leave_application_form.cfm?id=#url.id#
                        <cfelseif  isDefined("backbutton") AND backbutton EQ "employee_wfh_history"> 
                            wfh_application_form.cfm?id=#url.id#
                        <cfelse>
                            <cfif session.employee.role_id EQ 4>
                                dashboard.cfm
                            <cfelse>
                                admin_dashboard.cfm
                            </cfif>
                        </cfif>"
                         style="font-size:small;">
                        Back
                    </a>
                </li>
            </cfif>
<!--- back button ends --->
<!--- logout button starts --->
            <cfif (isDefined("page") AND (page EQ "dashboard" OR page EQ "admin_dashboard"))>
                <li><a class="getstarted scrollto logout_button" href="logout.cfm"><i class="bi bi-box-arrow-right" data-toggle="tooltip" data-placement="top" title="Logout"></i></a></li>
             <!--- </ul> --->
            </cfif>
<!--- logout button ends --->
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
    <cfcatch><cfdump var="#cfcatch#" abort></cfcatch>
    </cftry>
    </html>                                   