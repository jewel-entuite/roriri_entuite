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
<!--- session --->

<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>

<!--- session --->

<cfoutput>

<!--- invoke --->
  <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
  <cfinvoke component="models.employee" method="getemployee" id="#session.EMPLOYEE.ID#" returnvariable="employeeList1"/>
  <cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
  <cfinvoke component="models.employee" method="getAllEmployees" returnvariable="getAllEmployees">

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
          <li><a class="nav-link scrollto d-flex d-inline-flex" href="admin_dashboard.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-house-door mx-1"></i></span><span>Home</span></a></li>
<!--- home ends --->


          <li class="dropdown"><a class="d-flex d-inline-flex <cfif isDefined("active_status") AND active_status EQ "workforce_structure"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large;" class="bi bi-person-gear mx-1"></i></span><span>Workforce Structure</span></a>
              <ul>
                  <li><a href="department.cfm">Department Details</a></li>
                  <li><a href="all_employee_details.cfm">Career level Details</a></li>
                  <li><a href="all_employee_details.cfm">Designation Details</a></li>
              </ul>
          </li>

<!--- Employee --->
          <li class="dropdown"><a class="d-flex d-inline-flex <cfif isDefined("active_status") AND active_status EQ "employee_management"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large;" class="bi bi-person-gear mx-1"></i></span><span>Employee Management</span></a>
              <ul>
                  <li><a href="all_employee_details.cfm">Employee Details</a></li>
                  <!--- <li><a href="employee_referral_list.cfm?referral_emp=&referral_date=&experience=&education_level=&skills=&candidate_status="> Employee Referral</a></li> --->
                  <!--- Weekly Report ends --->
              </ul>
          </li>
<!--- employee ends --->

<!--- project management : start--->
          <li class="dropdown"><a class="d-flex d-inline-flex <cfif isDefined("active_status") AND active_status EQ "project_management"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size:large; margin-top: 10px;" class="bi bi-journal-check mx-1"></i></span><span>Project Management</span></a>
              <ul>
                  <li><a href="add_task.cfm">New Task</a></li>
                  <li><cfset FSdate = dateFormat(dateAdd("m", -2, now()), "yyyy-mm-01")>
                      <cfset FEdate = dateFormat(now(), "yyyy-mm-dd")>
                      <a href="assigned_task_details.cfm?tasks=&filtertaskId=&year=&month=&FSdate=#FSdate#&FEdate=#FEdate#&project=&module=&status=&handler=&assgn=&employeeid=&prior=">Task Details</a></li>
              </ul>
          </li>
<!--- project management : end --->

<!--- assets  --->
         <!---  <li class="dropdown"><a class="d-flex d-inline-flex <cfif isDefined("active_status") AND active_status EQ "asset_management"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-pc-display mx-1"></i></span><span>Asset Management</span></a>
              <ul>
                <!---   <li><a href="asset_list.cfm">Asset</a></li>
                  <li><a href="asset_assign.cfm?asset_id=">Assign Assets</a></li> --->
              </ul>
          </li> --->
<!--- assets end--->

<!--- More --->
          <li class="dropdown"><a class="d-flex d-inline-flex" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-list mx-1"></i></span><span>More</span></a>
              <ul>
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
                  </li>
 --->                  <li>
                    <a href="company_leave_days.cfm">Company Holidays</a>
                  </li>
              </ul>
          </li>
<!--- leave ends--->

<!--- WFH --->
       <!---    <li class="dropdown"><a class="d-flex d-inline-flex<cfif isDefined("active_status") AND active_status EQ "WFH"> active </cfif>" style=" text-decoration: none;" href="##"><span><i style="width:100%; font-size: large;" class="bi bi-house-check mx-1"></i></span><span>WFH</span></a>
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
<!--- WFH Ends --->

<!--- Print start --->
                    <!--- <cfif isDefined("print") AND print EQ "admin_dashboard_print">
                      <li>
                        <li class="dropdown">
                          <a style=" text-decoration: none;" href="##"><span>Print</span> <i class="bi bi-chevron-down"></i>
                          </a>
                          <ul>
                            <li>
                              <a style=" text-decoration: none;" class="nav-link scrollto" href="./reports/admin_timesheet_report.cfm?emp_id=#url.emp_id#&p_id=#url.project#&year=#url.year#&month=#url.month#&FSdate=#url.FSdate#&FEdate=#url.FEdate#&module=#url.module#&status=#url.status#&req=#url.req#&assgn=#url.assgn#">
                                PDF
                              </a>
                            </li>
                            <li>
                                <a style=" text-decoration: none;" class="nav-link scrollto" href="./reports/admin_timesheet_report_excel.cfm?emp_id=#url.emp_id#&p_id=#url.project#&year=#url.year#&month=#url.month#&FSdate=#url.FSdate#&FEdate=#url.FEdate#&module=#url.module#&status=#url.status#&req=#url.req#&assgn=#url.assgn#">
                                  Excel
                                </a>
                            </li>
                          </ul>
                        </li>  
                      </li>
                    </cfif>

                    <cfif isDefined("print") AND print EQ "admin_weekly_report_print">
                      <li>
                        <li class="dropdown">
                          <a style=" text-decoration: none;" href="##"><span>Print</span> <i class="bi bi-chevron-down"></i>
                          </a>
                          <ul>
                            <li>
                              <a style=" text-decoration: none;" class="nav-link scrollto" href="./admin_weekly_report_excel.cfm?emp_id=&year=&month=&FSdate=#url.FSdate#&FEdate=#url.FEdate#">
                                Excel
                              </a>
                            </li>
                          </ul>
                        </li>  
                      </li>
                    </cfif> --->
<!--- Print end --->

<!--- clock in/out --->
          <li>
            <cfif userClock.employee_id EQ session.employee.id AND userClock.checked_out_time EQ "">
              <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: red;" data-toggle="tooltip" data-placement="top" title="Clocked In"></i></span>
            <cfelse>
              <span class="mx-3"><i class="bi bi-stopwatch-fill" style="color: grey;" data-toggle="tooltip" data-placement="top" title="Clocked Out"></i></span>
            </cfif>
          </li>
<!--- clock in/out ends --->

<!--- calendar --->

          <a class="d-flex d-inline-flex <cfif isDefined("active_status")AND active_status EQ "calendar">active </cfif>" style=" text-decoration: none;" href="yearly_calendar.cfm"><span><i style="width:100%; font-size: large;" class="bi bi-calendar2-check mx-1" data-toggle="tooltip" data-placement="top" title="Calendar"></i></span></a>

<!--- calendar ends --->

<!--- back button --->
          <li><a class="getstarted back_button" href="
            <cfif structKeyExists(url, "token")>all_employee_details.cfm
            <cfelseif structKeyExists(url, "token1")>admin_timesheet_listing.cfm?emp_id=&project=&year=&month=&FSdate=&FEdate=&module=&status=&req=&assgn=&employeename=&today 
            <cfelseif structKeyExists(url, "token2")>admin_employees_log.cfm?Emp_id="+Emp_id+"&startDate="+startDate+"&endDate="+endDate
            <cfelseif structKeyExists(url, "token2")>
            <cfelseif  isDefined("backbutton") AND backbutton EQ "employee_leave_history"> leave_application_form.cfm?id=#url.id# 
            <cfelse>admin_dashboard.cfm##main
            </cfif>" style="font-size:small;">Back</a></li>
<!--- back button ends --->

        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav>
<!-- navbar ends -->
    </div>
  </header>
<!-- End Header --> 
</cfoutput>
</html>