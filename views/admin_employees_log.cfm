<!doctype html>
<html lang="en">
<head>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="assets/css/style.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<title>RORIRI -Employee Management</title>
	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
	<!-- Template Main CSS File -->
	<link href="assets/css/style.css" rel="stylesheet">
	<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<style>
      .pointer {
        cursor: pointer;
      }
      .center{
      	text-align: center;
      }
      .textnone{
      	text-decoration: none;
      }
      .tag .remove {
        margin-left: 5px;
        color: #333;
        cursor: pointer;
/*      display: none;*/
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
/*      margin-top: 10px;*/
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
        padding: 0px 50px 11px 61px;
        margin-top:-26px;
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
</head>
<body>
	<cfoutput>
<!--- session --->
		<cfif NOT structKeyExists(session, "employee")>
			<cflocation url="logout.cfm">
		</cfif>
<!--- header --->
	<cfset active_status="employee_management">
 <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
<!--- header ends --->

<cfinvoke component="models.logsheet" method="getAllEmployees" returnvariable="employeeList"/>
<!--- <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/> --->

	<cfif structKeyExists(URL, "startDate") AND structKeyExists(URL, "endDate") AND URL.startDate NEQ "" AND URL.endDate NEQ "">
		<cfset Sdate= URL.startDate>
		<cfset Edate= URL.endDate>
	<cfelse>
		<cfset Sdate= dateFormat(dateAdd("d", -7, now()),"yyyy-mm-dd")>
		<cfset Edate= dateFormat(now(),"yyyy-mm-dd")>
	</cfif>
	<cfset loopcount = 5>
	<cfset employeeID = 0>

	<cfif structKeyExists(url, "Emp_id") AND structKeyExists(url, "startDate") AND structKeyExists(url, "endDate")>
		<cfset StartDate = #url.startDate#>
		<cfset EndDate = #url.endDate#>
		<cfset selectSdate = #dateFormat(url.startDate,"yyyy-mm-dd")#>
		<cfset selectEdate = #dateFormat(url.endDate,"yyyy-mm-dd")#>
		<cfset loopcount = dateDiff("d", StartDate, EndDate)>
		<cfset employeeID = #decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#>
		<cfinvoke component="models.logsheet" method="getEmployeeLogs" id="#employeeID#" returnvariable="employeeSelection"/>
	</cfif>
	
	<cfif structKeyExists(url, "Emp_id") AND url.Emp_id NEQ "" AND structKeyExists(URL, "startDate") AND structKeyExists(URL, "endDate")>
		<div class="section-title pt-5" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">	
		<h2>Employee Management</h2>	
		<p><cfoutput>#employeeSelection.first_name# Log Sheet <span>[#dateFormat(url.startDate,"dd-mmm-yyyy")# - #dateFormat(url.endDate,"dd-mmm-yyyy")#]</cfoutput></span></p>
		</div>
	<cfelse>
		<div class="section-title pt-5" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
		<h2>Employee Management</h2>	
		<p>LOG SHEET <span>[#dateFormat(Sdate,"dd-mmm-yyyy")# - #dateFormat(Edate,"dd-mmm-yyyy")#]</span></p>
		</div>
	</cfif>

	<!--- Logs filter --->
	<cfif structKeyExists(URL, "selectCount")>
		<cfset loopCount = #URL.selectCount#>
	</cfif>

	<cfset daysInMonth = daysInMonth(now())>
	<cfset startMonthNow = createDate(year(now()), month(now()), 01)>
	<cfset endMonthNow = createDate(year(now()), month(now()), daysInMonth)>
	<br>
	<div class="card m-5">
		<div class="ms-4 my-2 mt-4 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
            <label>LOG SHEET </label>
        </div>
        <hr>
        <div id="overlay" style="display: none;"></div>
	           <div id="loader" style="display: none;">
	              <img src="../assets/img/loader.gif" width="50" height="50" alt="Loading...">
	           </div>
<!--- <center> --->
	<div class="container my-5 ms-5">
		<div class="row justify-content-start me-5">
			<div class="col-lg-3">
				<label for="end_date" class="mb-1">SELECT MONTH</label>
				<select name="end_date" id="month" class="form-select" onchange="getEmp()">
				  <cfset currentMonth = Month(Now())> <!-- Get current month (1-12) -->		  
				  <cfloop from="1" to="12" index="i">
				    <cfset monthName = DateFormat(CreateDate(2024, i, 1), "mmmm")> <!-- Get month name -->
				    <!-- Dynamically create options, and select the current month -->
				    <option value="#right("0" & i, 2)#" 
				      <cfif structKeyExists(url, "startDate") AND right("0" & i, 2) EQ dateFormat(url.startDate,"mm")>selected</cfif>> <!-- If it's the current month, add 'selected' -->
				      #monthName#
				    </option>
				  </cfloop>
				</select>
			</div>
			<div class="col-lg-3">
				   <label for="end_date" class="mb-1">SELECT YEAR</label>
				<select name="end_date" id="year" class="form-select" onchange="getEmp()">
					    <!-- Set current year -->
					    <cfset currentYear = dateFormat(now(), 'yyyy')>
					    <!-- Set selected year -->
					    <cfset selectedYear = currentYear>
					    <!-- Check if we should select 2025 as the default year when it's near the end of the year -->
					    <cfif dateFormat(now(), 'mm') eq "12" AND dateFormat(now(), 'dd') ge "31">
					        <!-- If it's the last day of the year or close to the new year, select 2025 -->
					        <cfset selectedYear = "2025">
					    </cfif>
					    <!-- Loop through the last 5 years including the current year -->
					    <cfloop from="#currentYear - 5#" to="#currentYear#" index="year">
					        <option value="#year#" 
					            <cfif structKeyExists(url, "endDate") AND year EQ dateFormat(url.endDate,"yyyy")> 
					                selected 
					            </cfif>>
					            #year#
					        </option>
					    </cfloop>
					</select>
				<span class="d-inline-block" style="color: red;" id="error_msg_ed"></span>
			</div>
			<div class="col-lg-3">
				<label for="start_date" class="mb-1">EMPLOYEE</label>
				<select class="form-select show-selected-tags" name="empid" id="empid" onchange="getEmp()">
					<option class="dropdown-item" value="">All Employees</option>
					<cfloop query="#employeeList#">
					<option class="dropdown-item" value="#encrypt(employeeList.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" <cfif structKeyExists(url, "Emp_id") AND structKeyExists(url, "startDate") AND structKeyExists(url, "endDate")><cfif decrypt(emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX') EQ employeeList.id>selected</cfif></cfif>>#employeeList.first_name#</option>
					</cfloop>
				</select>
			</div>
		</div>
	</div>
	<div class="row selected-filter ">
                    <div id="selected-count" class="col-2 selected-count">Filter's Selected:0</div>
                    <div class="col-1 clear-all" onclick="clearAll()">Clear All</div>
                    <div id="selected-tags" class="col-9 selected-tags "></div>
                    <!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
                    <!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
               </div>
<!--- </center> --->
	<!--- Logs filter ends--->
	<!--- dump --->
		<cfif structKeyExists(URL, "key")>
			<cfdump var="#session#">
		</cfif>
	<!--- listing table --->
		<div class="m-5 my-0">
			<style>
				table{
					border: 5px solid black;
					border-radius: 20px;
				}
			</style>
				<!--- <cfdump var="#workingDays#"> --->
		<cfif structKeyExists(url, "Emp_id") AND decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX') NEQ"">
			<table class="table table-striped border-dark" style="overflow: hidden; margin-top: -2.75rem !important;">
				<thead style="background-color:##31394F;">
					<tr class="text-center" style="font-size:large; vertical-align: middle; color: white; height: 50px;">
						<th>DATE</th>
						<th>WORKING HOURS</th>
						<th>NUMBER OF BREAKS</th>
						<th>STATUS</th>
					</tr>
				</thead>
			<cfif employeeID NEQ 0>
				<cfloop from="#parseDateTime(URL.startDate)#" to="#parseDateTime(URL.endDate)#" index="dateindex"  step="#createTimespan(1, 0, 0, 0)#">
					<cfinvoke component="models.logsheet" method="getDailyWorkhours" id="#employeeID#" date="#dateindex#" returnvariable="dailyWorkTime"/>
					<cfinvoke component="models.logsheet" method="getDailyBreakCount" id="#employeeID#" date="#dateindex#" returnvariable="breakCount"/>
					<cfinvoke component="models.logsheet" method="getTotalLogs" id=#employeeID# date="#dateindex#" returnvariable="totalDayLogs"/>

				<cfset time = #dateTimeFormat(dailyWorkTime.total_hours,"HH:nn:ss")#>
				<cfset checktime = createTime(08, 30, 00)>

				<tbody style="background-color:##FEF7F5;">

					<tr class="text-center" style="font-size:medium; vertical-align: middle; height: 50px; cursor: pointer;" data-toggle="collapse" data-target="##rw-accordion-#dateindex#" class="clickable">
						<td>
						#dateformat(dateindex,"dd-mm-yyyy")#
						</td>
						<td>
						<cfif len(dailyWorkTime.total_hours) GT 0>#dateTimeformat(dailyWorkTime.total_hours,"HH:nn:ss")#<cfelse><span style="color: green; font-weight: bold;">NA</span></cfif>
						</td>
						<td>
						<cfif breakCount.breaks GT 0>#breakCount.breaks#<cfelse>0</cfif>
						</td>
						<td><cfif len(dailyWorkTime.total_hours) GT 0>
						<cfif time GTE #dateTimeFormat(checktime,"HH:nn:ss")#>
						<strong style="color:Blue;">P</strong>
						<cfelseif time LT #dateTimeFormat(checktime,"HH:nn:ss")# AND time NEQ "">
						<strong style="color:orangered;">AN</strong>
						<cfelse>
						<strong style="color:Red;">A</strong>
						</cfif>
						<cfelse><span style="color: red;">--</span></cfif>
						</td>
					</tr>

					<tr id="rw-accordion-#dateindex#" class="collapse">
						<td colspan="4">
							<table class="table table-striped border-dark" style="overflow: hidden;">
								<thead style="background-color:##31394F;">
								<tr style="font-size:medium; vertical-align: middle;color:white">
									<th class="center">SL No.</th>
									<th class="center">CHECK-IN TIME</th>
									<th class="center">CHECK-OUT TIME</th>
									<th class="center">TOTAL HOURS</th>
								</tr>
								</thead>
								<tbody style="background-color:##FEF7F5;">
								<cfset previous_checkout_time = "">
								<cfloop query="#totalDayLogs#">

<!--- break duration --->
								<cfif previous_checkout_time NEQ "">
									<cfif totalDayLogs.currentrow GT 1>
										<cfset seconds= dateDiff('s', previous_checkout_time, totalDayLogs.checked_in_time)>
										<cfset mins = seconds/60>
										<cfset len= listGetAt(mins,1,".")>

										<cfif len GT 0>
											<cfset mins_cal= listGetAt(mins, 1,".")>
											<cfset sec_remaing= seconds - (mins_cal*60)>
												<cfset hour= mins_cal/60>
												<cfset len_h= listGetAt(hour,1,".")>
												<cfif len_h GT 0>
													<cfset hour_cal= listGetAt(hour, 1,".")>
													<cfset min_remaing= mins_cal - (hour_cal*60)>
													<cfset hour_remaing=hour_cal>
												<cfelse>
													<cfset min_remaing=mins_cal>
													<cfset hour_remaing=00>
												</cfif>
										<cfelse>
											<cfset sec_remaing= seconds>
											<cfset min_remaing=00>
											<cfset hour_remaing=00>
										</cfif>

										<cfif hour_remaing EQ 0 AND min_remaing NEQ 0  >
											<cfset Break_duration = "#min_remaing# Minutes&nbsp;#sec_remaing# Seconds">

										<cfelseif hour_remaing EQ 0 AND min_remaing EQ 0>
											<cfset Break_duration = "#sec_remaing# Seconds">

										<cfelse>
											<cfset Break_duration = "#hour_remaing# Hours&nbsp;#min_remaing# Minutes&nbsp;#sec_remaing# Seconds">
										</cfif>
									</cfif>

										<tr style="font-size:small; vertical-align: middle; height: 50px;">
											<td colspan="4" class="alert alert-warning mt-5 text-left" style="font-weight:bold;">
												<center><span style="font-size:medium; color: black;">BREAK DURATION : </span><span style="font-size:medium">#Break_duration#</span></center>
											</td>
										</tr>
										</cfif>
									<cfset previous_checkout_time = totalDayLogs.checked_out_time>
<!--- break duration ends --->

									<tr style="font-size:small; vertical-align: middle; height: 50px;">
										<td align="center">
										#totalDayLogs.currentrow#
										</td>
										<td align="center">
											<cfif totalDayLogs.checked_in_time NEQ "">
												<strong>Time :</strong>
												#dateTimeFormat(totalDayLogs.checked_in_time,"dd-mm-yyyy HH:nn:ss")#
												<cfif totalDayLogs.ip_in NEQ "">
													<br><br><strong>IP :</strong>
													#totalDayLogs.ip_in#
												</cfif>
											<cfelse>
												<strong>--</strong>
											</cfif>
										</td>
										<td align="center">
											<cfif totalDayLogs.checked_out_time NEQ "">
												<strong>Time :</strong>
												#dateTimeFormat(totalDayLogs.checked_out_time,"dd-mm-yyyy HH:nn:ss")#
												<cfif totalDayLogs.ip_out NEQ "">
													<br><br><strong>IP :</strong>
													#totalDayLogs.ip_out#
											</cfif>
											<cfelse>
												<strong>--</strong>
											</cfif>
										</td>
										<td align="center">
										#dateTimeFormat(totalDayLogs.total_hours,"HH:nn:ss")#
										</td>
									</tr>
								</cfloop>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
				</cfloop>
				<tfoot>
					<tr>
						<td colspan="4" ><b>NOTE :</b> <b style="color:green;">NA</b><b>-</b> No records; <b style="color:blue;">P</b><b>-</b>Present; <b style="color:orangered;">AN</b><b>-</b>Anomalies; <b style="color:red;">A</b><b>-</b>Absent</td>
					</tr>
				</tfoot>
				<cfelse>
				<tfoot>
					<tr>
						<td colspan="12" class="text-center"><h3 class="my-5">No Records Found!</h3></td>
					</tr>
				</tfoot>	
			</cfif>	
			</table>
		<cfelse>
			<table class="table table-striped border-dark mt-1" style="overflow: hidden; margin-top: -2.75rem !important;">
				<thead style="background-color:##31394F;">
				<tr class="text-center" style="font-size:large; vertical-align: middle; color: white; height: 50px;">
					<th style="margin-left:20px">NAME</th>
					<th >COMPANY WORKING DAYS</th>
					<th>EMPLOYEE WORK HOURS</th>
					<th>EMPLOYEE WORK DAYS</th>
					<th>LEAVE COUNT</th>
				</tr>
				</thead>
			<cfset thisDay = now()>
			<!--- <cfinvoke component="models.logsheet" method="getEmployeeAttendanceToday" thisDay="#dateTimeFormat(thisDay,"yyyy-mm-dd")#"  returnvariable="TodatAttendanceList"/> --->
			<cfinvoke component="models.logsheet" method="getAllEmployees" returnvariable="allEmployeeList">
			<cfif allEmployeeList.recordcount NEQ 0>
				<tbody style="background-color:##FEF7F5;">
					<cfset a=0>
					<cfloop query="#allEmployeeList#">
						<cfset a++>
					<cfif structKeyExists(URL, "key")>
						<cfdump var="test1">
					</cfif>
					<cfinvoke component="models.logsheet" id="#allEmployeeList.id#" startdate="#Sdate#" enddate="#Edate#" method="workingDaysHours" returnvariable="workingDays">
						<!--- <cfdump var="#workingDays#"label="workingDays for Employee ID #allEmployeeList.id#"> --->
					<cfinvoke component="models.logsheet" startdate="#Sdate#" enddate="#Edate#" id="#allEmployeeList.id#" method="getLeaveCount" returnvariable="leaveCount">


					<tr class="text-center clickable" style="font-size:medium; vertical-align: middle; height: 50px; cursor: pointer;" data-toggle="collapse" data-target="##rw-accordion-#a#">
						<td style="font-weight:normal;">#ucFirst(allEmployeeList.first_name,true,true)#</td>
						<td>#workingDays.countofdays#</td>
						<td>#workingDays.h#:#workingDays.m#:#workingDays.s#</td>
						<cfset totalHours = workingDays.h + (workingDays.m / 60) + (workingDays.s / 3600)>
				    <cfset roundedDays = round(totalHours / 10.5)>
				    <td>#roundedDays#</td>
						<td>#leaveCount#</td>
					</tr>
					<tr  class="collapse" id="rw-accordion-#a#">
						<td colspan="4">
							<table class="table table-striped border-dark" style="overflow: hidden;">
								<thead style="background-color:##31394F;">
								<tr style="font-size:medium; vertical-align: middle; color:white;">
									<th class="center">DATE</th>
									<th class="center">CHECK-IN</th>
									<th class="center">CHECK-OUT</th>
									<th class="center">TOTAL HOURS</th>
									<th class="center">STATUS</th>
									<th class="center">LEAVE</th>
								</tr>
								</thead>
								<tbody style="background-color:##FEF7F5;">
										<cfloop from="#parseDateTime(Sdate)#" to="#parseDateTime(Edate)#" index="B" step="#createTimespan(1, 0, 0, 0)#">
											<cfinvoke component="models.logsheet" id="#allEmployeeList.id#" date="#dateFormat(B)#" method="getTotalLogs" returnvariable="clockInOutDetails">
											<cfinvoke component="models.logsheet" id="#allEmployeeList.id#" startdate="#dateFormat(B,"yyyy-mm-dd")#" enddate="#dateFormat(B,"yyyy-mm-dd")#" method="workingDays" returnvariable="workingDay">
											<cfinvoke component="models.logsheet" method="getLeaveDetails" id="#allEmployeeList.id#" date="#dateFormat(B,"yyyy-mm-dd")#" returnvariable="leaveDetails">
												<cfinvoke component="models.logsheet" method="getEmployeeCheckIn" id="#allEmployeeList.id#" startdate="#dateFormat(B,"yyyy-mm-dd")#" enddate="#dateFormat(B,"yyyy-mm-dd")#" returnvariable="CheckInOut"/>
												<cfset time = #dateTimeFormat(workingDay.EmpTotalHours,"HH:nn:ss")#>
												<cfset checktime = createTime(08, 30, 00)>
												<tr>
													<td align="center" style="vertical-align: middle; font-weight: bold;">#dateFormat(B,"mm-dd-yyyy")#</td>
													<td align="center" style="vertical-align: middle;">
													<cfif CheckInOut.checkIN NEQ "">
														<strong>Time :</strong>
														#dateTimeFormat(CheckInOut.checkIN,"hh:nn:ss tt")#
														<cfif CheckInOut.ipIn NEQ "">
															<br><br><strong>IP :</strong>
															#CheckInOut.ipIn#
														</cfif>
													<cfelse>
														<strong>--</strong>
													</cfif>
													</td>
													<td align="center" style="vertical-align: middle;">
														<cfif CheckInOut.checkOUT NEQ "">
															<strong>Time :</strong>
															#dateTimeFormat(CheckInOut.checkOUT,"hh:nn:ss tt")#
															<cfif CheckInOut.ipOut NEQ "">
																<br><br><strong>IP :</strong>
																#CheckInOut.ipOut#
														</cfif>
														<cfelse>
															<strong>--</strong>
														</cfif>
													</td>
													<td align="center" style="vertical-align: middle;">
														<cfif workingDay.EmpTotalHours NEQ "">
															#dateTimeFormat(workingDay.EmpTotalHours,"HH:nn:ss")#
														<cfelse>
															<strong>--</strong>
														</cfif>
													</td>
													<td align="center" style="vertical-align: middle;">
														<cfif time NEQ "">
															<cfif time GTE #dateTimeFormat(checktime,"HH:nn:ss")#>
																<strong style="color:Blue;">P</strong>
															<cfelseif time LT #dateTimeFormat(checktime,"HH:nn:ss")# AND time NEQ "">
																<strong style="color:red;">AN</strong>
																<cfelse>
																<strong style="color:Red;">A</strong>
															</cfif>
														<cfelse>
															<strong>--</strong>
														</cfif>
													</td>
													<td align="center" style="vertical-align: middle;">
														<cfif leaveDetails.leaveStatus EQ "halfday">
															<strong style="color:green;">HALF DAY</strong>
														<cfelseif leaveDetails.leaveStatus EQ "leave">
															<strong style="color:green;">LEAVE</strong>
														<cfelse>
															<strong>--</strong>
														</cfif>
													</td>
												</tr>
										</cfloop>
								</tbody>
							</table>
						</td>
					</tr>
					</cfloop>
				</tbody>
			<cfelse>
				<tfoot>
					<tr>
						<td colspan="4" class="text-center"><h3 class="my-5">No Records Found!</h3></td>
					</tr>
				</tfoot>
			</cfif>
			</table>
		</cfif>
		</div>
	</div>
	</cfoutput>

	<script>
		function checkCount() {
		let count = document.getElementById("count").value;
		console.log(count);
		// document.getElementById('daysCount').value = count;

		location.href="admin_employees_log.cfm?selectCount="+count;
		} 
	</script>
	<script>
		function formatDate(date) {
    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, '0');  // months are 0-indexed
    let day = String(date.getDate()).padStart(2, '0');  // pad single digits with leading zero
    return `${year}-${month}-${day}`;
}
		function getEmp(){

			let month = document.getElementById('month').value;
			let year = document.getElementById('year').value;
			let startDate = formatDate(new Date(year+'-'+month+'-01'));
			let endDate = formatDate(new Date(year,month,0));
			let Emp_id = document.getElementById("empid").value;
		// const oneDay = 24 * 60 * 60 * 1000;
		// const diffDays = Math.round(Math.abs((startDate - endDate) / oneDay));
		// document.getElementById('daysCount').value = count;
		location.href="admin_employees_log.cfm?Emp_id="+Emp_id+"&startDate="+startDate+"&endDate="+endDate;
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
         // document.getElementById("admin_filter_start_Date").value = new Date().toISOString().split('T')[0];
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

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" 
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous">
	</script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" 
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" 
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
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
</html>
