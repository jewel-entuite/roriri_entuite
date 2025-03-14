<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>
<cfoutput>
    <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>
  <style>
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
<!--- current month timesheet --->
        <cfset currentDateTime = now()>
        <cfset currentMonth = createDateTime(year(currentDateTime),month(currentDateTime),1,0,0,0)>
        <cfset formattedCurrentMonth = dateFormat(currentMonth, "yyyy-mm-dd")>
        <cfset currentDate = now()>
        <cfset formattedCurrentdate = dateFormat(currentDate, "yyyy-mm-dd")>
<!--- /current month timesheet --->
<!--- invoke --->

    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
    <cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>

<!--- header --->

<header id="header" class="fixed-top d-flex align-items-center">
            <div class="container-fluid d-flex align-items-center justify-content-between">
                <div class="logo">
                    <h2 class="text-light">
                        <a href="dashboard.cfm" style=" text-decoration: none;"><span><img class="img-fluid" src="../images/logo-black.jpeg" alt="" width="150"></span>&nbsp;&nbsp;&nbsp;</a>
                        <span style="color: ##534980; font-size:x-large;">Hi,&nbsp;<strong>#employeeList.first_name#</strong></span>
                    </h2>
                </div>
<!--- navbar --->
                <nav id="navbar" class="navbar">
                    <ul>
<!--- home--->
                        <li><a class="nav-link scrollto d-flex d-inline-flex" href="dashboard.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-house-door mx-1"></i></span><span>Home</span></a></li>
<!--- profile --->
                        <li class="dropdown"><a class="d-flex d-inline-flex <cfif isDefined("active_status")AND active_status EQ "profile">active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-person-circle mx-1"></i></span><span>Profile</span></a>
                            <ul>
                                <li><a style=" text-decoration: none;" href="employee_profile_list.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">View Profile</a></li>
                                <!--- <li><a style=" text-decoration: none;" href="employee_asset_details.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Asset Details</a></li> --->
                                <!--- <li><a href="employee_referral_form.cfm">Employee Referral</a></li> --->
                                <!--- <li><a style=" text-decoration: none;" href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status=">Employee Referral</a></li> --->
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
                        <!--- <li class="dropdown"><a class="d-flex d-inline-flex<cfif isDefined("active_status") AND active_status EQ "WFH"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-house-check mx-1"></i></span><span>WFH</span></a>
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
                        <li class="dropdown"><a class="d-flex d-inline-flex <cfif isDefined("active_status") AND active_status EQ "more"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-list mx-1"></i></span><span>More</span></a>
                            <ul>
                                <!--- <li>
                                    <a style=" text-decoration: none;" href="dashboard.cfm##contact">Update  Timesheet</a>
                                </li> --->

                                <li>
                                    <a style=" text-decoration: none;" href="listing.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&project=&year=&month=&FSdate=#formattedCurrentMonth#&FEdate=#formattedCurrentdate#&module=&status=&req=&assgn=&emp_id=&employeeid=">Timesheet</a>
                                </li>

                                <li>
                                    <a style=" text-decoration: none;" href="attendance_log.cfm?emp_id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Logsheet</a>
                                </li>
                                <li>
                                    <a style=" text-decoration: none;" href="employee_leave_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">Leave</a>
                                </li>
                                <!--- <li>
                                    <a style=" text-decoration: none;" href="employee_wfh_history.cfm?id=#encrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#">WFH</a>
                                </li> --->    
                            </ul>
                        </li>
<!--- clock --->
                        <!--- <div style="font-size:20px; margin-left: 20px;">
                            <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">
                              <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: red;" data-toggle="tooltip" data-placement="top" title="Clocked In"></i></span>
                            <cfelse>
                              <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: grey;" data-toggle="tooltip" data-placement="top" title="Clocked Out"></i></span>
                            </cfif>
                        </div> --->
<!--- print --->
                        <!--- <div><cfif isDefined("print") AND print EQ "user_dashboard_print">
                      <li>
                        <li class="dropdown">
                          <a style=" text-decoration: none;" href="##"><span>Print</span> <i class="bi bi-chevron-down"></i>
                          </a>
                          <ul>
                            <li>
                              <a style=" text-decoration: none;" target="_blank"  class="nav-link scrollto" href="./reports/timesheet_individual_report.cfm?emp_id=#url.emp_id#&p_id=#url.project#&year=#url.year#&month=#url.month#&module=#url.module#&status=#url.status#&req=#url.req#&FSdate=#URL.FSdate#&FEdate=#URL.FEdate#&assgn=#url.assgn#&employeeid=#url.employeeid#">
                                PDF
                              </a>
                            </li>
                            <li>
                              <!--- <cfif structKeyExists(url, "emp_id") AND URL.emp_id EQ "" OR URL.month EQ "" OR URL.project EQ "">
                                <a style=" text-decoration: none;"  class="nav-link scrollto" onclick="alert('Please select Employee name, months, project')" href="">
                                Excel
                                </a>
                              <cfelse> --->
                                <a style=" text-decoration: none;" class="nav-link scrollto" href="./reports/timesheet_individual_report_excel.cfm?emp_id=#url.emp_id#&p_id=#url.project#&year=#url.year#&month=#url.month#&FSdate=#url.FSdate#&FEdate=#url.FEdate#&module=#url.module#&status=#url.status#&req=#url.req#&assgn=#url.assgn#&employeeid=#url.employeeid#">
                                Excel
                                </a>
                              <!--- </cfif> --->
                            </li>
                          </ul>
                        </li>  
                      </li>
                    </cfif></div> --->

<!--- calendar --->
                        <a class="d-flex d-inline-flex <cfif isDefined("active_status")AND active_status EQ "calendar">active </cfif>" style=" text-decoration: none;" href="yearly_calendar.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-calendar2-check mx-1" data-toggle="tooltip" data-placement="top" title="Calendar"></i></span></a>
<!--- calendar ends --->

<!--- back --->
                       <li><a class="getstarted back_button"<cfif isDefined("backbutton") AND backbutton EQ "employee_profile">href="employee_profile_list.cfm?id=#url.id#"
                       <cfelseif  isDefined("backbutton1") AND backbutton EQ "employee_leave_history"> href="leave_application_form.cfm?id=#url.id#"
                        <cfelseif  isDefined("backbutton") AND backbutton EQ "employee_wfh_history"> href="wfh_application_form.cfm?id=#url.id#"
                       <cfelse> href="dashboard.cfm"
                       </cfif> style="font-size:small;text-decoration: none;">Back</a>
                       </li>
                    </ul>
                    <i class="bi bi-list mobile-nav-toggle"></i>
                </nav>
    <!--navbar ends -->
            </div>
        </header>
<!--- header ends --->
    </cfoutput>