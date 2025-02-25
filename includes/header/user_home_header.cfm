<cftry><!--- current month timesheet --->
    <cfset currentDateTime = now()>
    <cfset currentMonth = createDateTime(year(currentDateTime),month(currentDateTime),1,0,0,0)>
    <cfset formattedCurrentMonth = dateFormat(currentMonth, "yyyy-mm-dd")>
    <cfset currentDate = now()>
    <cfset formattedCurrentdate = dateFormat(currentDate, "yyyy-mm-dd")>
<!--- /current month timesheet --->
<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>
 <cfoutput>
    <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>


<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>


<!--- header --->
        <header id="header" class="fixed-top d-flex align-items-center">
            <div class="container-fluid d-flex align-items-center justify-content-between">
                <div class="logo">
                    <h2 class="text-light"><a href="dashboard.cfm" style=" text-decoration: none;"><span><img class="img-fluid" src="../images/logo-black.jpeg" alt="" width="150"></span>&nbsp;&nbsp;&nbsp;<span style="color: ##534980; font-size:x-large;">Hi,&nbsp;<strong>#employeeList.first_name#</strong></span></a></h2>
                </div>
<!--- navbar --->
                <nav id="navbar" class="navbar">
                    <ul>
<!--- home --->
                        <li><a style=" text-decoration: none;" class="nav-link scrollto active d-flex d-inline-flex" href="dashboard.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-house-door mx-1"></i></span><span>Home</span></a></li>
<!--- Profile --->
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-person-circle mx-1"></i></span><span>Profile</span></a>
                            <ul>
                                <li>
                                    <a href="employee_profile_list.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">View Profile</a>
                                </li>
                                <li>
                                    <!--- <a href="employee_asset_details.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Asset Details</a> --->
                                </li>
                                <!--- <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">Employee Referral</a></li> --->
                                
                                <!--- <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">View Employee Referral</a></li>                            --->
                            </ul>
                        </li>
<!--- leave --->
                        <!--- <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-calendar2-x mx-1"></i></span><span>Leave</span></a>
                            <ul>
                                <li>
                                    <a style=" text-decoration: none;" href="leave_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Apply Leave</a>
                                </li>
                                
                                <li>
                                    <a style=" text-decoration: none;" href="employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">View Leave History</a>
                                </li>
                            </ul>
                        </li> --->
<!--- WFH --->
                        <!--- <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-house-check mx-1"></i></span><span>WFH</span></a>
                            <ul>
                                <li>
                                    <a style=" text-decoration: none;" href="wfh_application_form.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Apply WFH</a>
                                </li>

                                <li>
                                    <a style=" text-decoration: none;" href="employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">View WFH History</a>
                                </li>
                            </ul>
                        </li> --->
<!--- More --->
                        <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-list mx-1"></i></span><span>More</span></a>
                            <ul>
                                <li>
                                    <a href="listing.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&project=&year=&month=&FSdate=#formattedCurrentMonth#&FEdate=#formattedCurrentdate#&module=&status=&req=&assgn=&employeeid=">Timesheet</a>
                                </li>
                                <li>
                                    <a href="attendance_log.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Logsheet</a>
                                </li>
                                <li>
                                    <a style=" text-decoration: none;" href="employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Leave</a>
                                </li>
                                <!--- <li>
                                    <a style=" text-decoration: none;" href="employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">WFH</a>
                                </li> --->
                                
                            </ul>
                        </li>
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

<!--- clock in/out --->
                            <li>
                              <!--- <div style=" margin-left: 20px; margin-right: 20px;">
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
                          <div id="colocktimer"></div> --->
                        <!--- calendar --->
                        <a class="d-flex d-inline-flex" style=" text-decoration: none;" href="yearly_calendar.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-calendar2-check mx-1" data-toggle="tooltip" data-placement="top" title="Calendar"></i></span></a>
<!--- calendar ends --->
                        <li><a class="getstarted scrollto logout_button" href="logout.cfm"><i class="bi bi-box-arrow-right" data-toggle="tooltip" data-placement="top" title="Logout"></i></a></li>
                    </ul>
                    <i class="bi bi-list mobile-nav-toggle"></i>
                </nav>
<!-- .navbar end -->
            </div>
        </header>
        <script>
            function callIp(){
                fetch('https://api64.ipify.org')
            .then((res)=> res.text())
            .then(ip=> document.getElementById('ip').value=ip)
            .catch(err=> console.log(err))
            }
            callIp();
            callIp();
            callIp();
            callIp();
            callIp();
            // setInterval(callIp, 500);
        </script>
    </cfoutput>
    <cfcatch><cfdump var="#cfcatch#" abort></cfcatch>
</cftry>