<cfoutput>
<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


<CFHEADER name="Content-Disposition" value="inline; filename=Timesheet_Individual_Report_Excel.xls">
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
				.totalTable td, th{
					border: 1px solid black;
				}
				
			</style>
		</head>
			<body style="font-family: Calibri;">
				<cfinvoke component="models.timesheet" method="getTimesheetEmployees" returnvariable="employeeList"/>
				<!--- <cfdump var="#employeeList#"><cfabort> --->
				<cfif url.emp_id EQ "">
					<cfloop query="employeeList">
						<cfinvoke component="models.timesheet" method="getdetails" p1="#url.p_id#" id="#employeeList.id#"year="#url.year#" month="#url.month#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#"  returnvariable="list"/>
						<cfif list.recordCount GT 0>
							<table class="text-center listing-table" border="1" width="100%" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
								<thead style="color: ##1C4587">
									
									<tr><th colspan="14" style="font-size:16px;">
										<b>
											<cfif structKeyExists(URL, "p_id") AND URL.p_id NEQ ""> 
												<cfinvoke component="models.timesheet" method="getProject" p1="#URL.p_id#" returnvariable="project">
													#project.name#
											</cfif>
											TIMESHEET - #list.first_name# (#list.des_name#)
										</b></th></tr>
									<cfif NOT structKeyExists(URL, "month") OR structKeyExists(URL, "month") AND URL.month EQ "">
										<!--- <tr><th colspan="12" style="font-size:14px;"><b>JANUARY_2023</b></th></tr> --->
									<cfelse>
										<cfif NOT structKeyExists(URL, "year") OR structKeyExists(URL, "year") AND URL.year EQ "">
											<cfset new_date = createDate(year(now()), URL.month, 1)>
											<tr><th colspan="14" style="font-size:14px;"><b>#UCase(dateFormat(new_date,"mmmm"))#_#dateFormat(now(),"yyyy")#</b></th></tr>
										<cfelse>
											<cfset new_date = createDate(year(now()), URL.month, 1)>
											<tr><th colspan="14" style="font-size:14px;"><b>#UCase(dateFormat(new_date,"mmmm"))#_#URL.year#</b></th></tr>
										</cfif>
									</cfif>
									<tr style="font-size:11px;background-color: ##A4C2F4; text-align: center; height: 50px;">
										<b>
											<th width="80">DATE</th>
											<th width="80">TASK ID</th>
											<th width="125">PROJECT</th>
											<th width="120">REQUIREMENT TYPE</th>
											<th width="120">ASSIGNED BY</th>
											<th width="120">MODULE</th>
											<th width="120">SCOPE</th>
											<th width="600">DESCRIPTION</th>
											<th width="80">STATUS</th>
											<th width="80">START DATE</th>
											<th width="80">START TIME</th>
											<th width="80">END DATE</th>
											<th width="80">END TIME</th>
											<!--- <th width="110">TIME SPENT</th> --->
											<th width="100">PRODUCTIVE HRS</th>
										</b>
									</tr>
								</thead>
								<tbody>
									<cfset k=1>
									<cfset totaltime_hours=0>
									<cfset totaltime_mins=0>
									<cfset New_hours=0>
									<cfset New_mins=0>
									<cfset Bug_hours=0>
									<cfset Bug_mins=0>
									<cfset M_hours=0>
									<cfset M_mins=0>
									<cfset billable_hours=0>
									<cfset billable_mins=0>
									<cfloop query="list">
											<tr style="font-size: 11px; text-align: center; color: black; font-family: serif;">
												<td>#dateformat(list.start_time,"dd-mm-yyyy")#</td>
												<cfif list.task_id NEQ "">
													<td style="color:##7d66e3"><b>#list.task_id#</b></td>
												<cfelse>
													<td>-</td>
												</cfif>
												<td>#ucFirst(list.Pro_name)#</td>
												<cfif list.type EQ "New">
													<td style="background-color: ##BFE1F6;Color: black">#ucFirst(list.type)#</td>
												<cfelseif list.type EQ "Bug">
													<td style="background-color: ##FFE5A0;Color: black">#ucFirst(list.type)#</td>
												<cfelseif list.type EQ "Manual Error">
													<td style="background-color: ##11734B;Color: black">#ucFirst(list.type)#</td>
												</cfif>
												<td>#ucFirst(list.assigned_by_first_name,true)#</td>
												<td>#ucFirst(list.modules,true)#</td>
												<td style="text-align: justify; padding: 10px;">#ucFirst(list.taskDescription)#</td>
												<td style="text-align: justify; padding: 10px;">#ucFirst(list.description)#</td>
												<cfif list.timesheetstatus EQ "In Progress">
													<td style="background-color: ##FF9900;Color: black">#ucFirst(list.timesheetstatus)#</td>
												<cfelseif list.timesheetstatus EQ "Completed">
													<td style="background-color:##B7E1CD;color: Black;">#ucFirst(list.timesheetstatus)#</td>
												<cfelseif list.timesheetstatus EQ "Re-opened">
													<td style="background-color:##fc4138;color: Black;">#ucFirst(list.timesheetstatus)#</td>
												<cfelseif list.timesheetstatus EQ "R&D">
													<td style="background-color:##64c906;color: Black;">#ucFirst(list.timesheetstatus)#</td>
												</cfif>
												<td style="font-size: x-small;">#dateFormat(list.start_time,"dd-mm-yyyy")#</td>
												<td style="font-size: x-small;">#timeFormat(list.start_time,"hh:nn tt")#</td>
												<td style="font-size: x-small;">#dateFormat(list.end_time,"dd-mm-yyyy")#</td>
												<td style="font-size: x-small;">#timeFormat(list.end_time,"hh:nn tt")#</td>
												<!--- <td style="font-size: x-small;">#timeFormat(list.start_time,"hh:nn tt")# - #timeFormat(list.end_time,"hh:nn tt")#</td> --->
												<!--- <td>#dateFormat(list.date,"dd-mmm-yyyy")#</td> --->
												<td>#val(list.productive_hours)#h #val(list.productive_mins)#m</td>
											</tr>
										<cfset k++>
										<cfset totaltime_mins += list.productive_mins>
										<cfset totaltime_hours += list.productive_hours>
										<cfif list.type EQ "New">
											<cfset New_hours += list.productive_hours>
											<cfset New_mins += list.productive_mins>
										<cfelseif list.type EQ "Bug">
											<cfset Bug_hours += list.productive_hours>
											<cfset Bug_mins += list.productive_mins>
										<cfelseif list.type EQ "Manual Error">
											<cfset M_hours += list.productive_hours>
											<cfset M_mins += list.productive_mins>
										</cfif>
										<cfset billable_hours=New_hours+M_hours>
										<cfset billable_mins=New_mins+M_mins>
									</cfloop>
									<!--- minutes hours calculations start --->

									<!--- total --->

									<cfset cal_mins_hour = listGetAt((totaltime_mins/60), 1,".")>
									<cfif cal_mins_hour GT 0>
										<cfset final_cal_hours = totaltime_hours+cal_mins_hour>
										<cfset final_cal_mins = totaltime_mins-(60*cal_mins_hour)>
									<cfelse>
										<cfset final_cal_hours = totaltime_hours>
										<cfset final_cal_mins = totaltime_mins>
									</cfif>

									<!--- New --->

									<cfset cal_mins_hour_new = listGetAt((New_mins/60), 1,".")>
									<cfif cal_mins_hour_new GT 0>
										<cfset final_cal_hours_new = New_hours+cal_mins_hour_new>
										<cfset final_cal_mins_new = New_mins-(60*cal_mins_hour_new)>
									<cfelse>
										<cfset final_cal_hours_new = New_hours>
										<cfset final_cal_mins_new = New_mins>
									</cfif>

									<!--- Bug --->

									<cfset cal_mins_hour_Bug = listGetAt((Bug_mins/60), 1,".")>
									<cfif cal_mins_hour_Bug GT 0>
										<cfset final_cal_hours_Bug = Bug_hours+cal_mins_hour_Bug>
										<cfset final_cal_mins_Bug = Bug_mins-(60*cal_mins_hour_Bug)>
									<cfelse>
										<cfset final_cal_hours_Bug = Bug_hours>
										<cfset final_cal_mins_Bug = Bug_mins>
									</cfif>

									<!--- Manual Error --->

									<cfset cal_mins_hour_M = listGetAt((M_mins/60), 1,".")>
									<cfif cal_mins_hour_M GT 0>
										<cfset final_cal_hours_M = M_hours+cal_mins_hour_M>
										<cfset final_cal_mins_M = M_mins-(60*cal_mins_hour_M)>
									<cfelse>
										<cfset final_cal_hours_M = M_hours>
										<cfset final_cal_mins_M = M_mins>
									</cfif>

									<!--- Billable --->

									<cfset cal_mins_hour_b = listGetAt((billable_mins/60), 1,".")>
									<cfif cal_mins_hour_b GT 0>
										<cfset final_cal_hours_b = billable_hours+cal_mins_hour_b>
										<cfset final_cal_mins_b = billable_mins-(60*cal_mins_hour_b)>
									<cfelse>
										<cfset final_cal_hours_b = billable_hours>
										<cfset final_cal_mins_b = billable_mins>
									</cfif>

									<!--- minutes hours calculations end --->
									<tr>
										<td colspan="13" align="right">Total</td>
										<td style="font-size:small; text-align:center;">#final_cal_hours#h #final_cal_mins#m</td>

									</tr>
								</tbody>
							</table>
						</cfif>
						<br><br>
						<div class="container">
							<div class="row">
								<div class="col-2"></div>
								<div class="col-3">
									<cfif list.recordCount GT 0>
										<table class="totalTable" border="1">
												<tr align="center">
													<th colspan="2" style="font-size:12px;"><b>TOTAL HOURS</b></th>
												</tr>
											</thead>
											<tbody class="font-11">
												<tr align="center">
													<th width="110">Requirement Type</th>
													<th width="80">Hours</th>
												</tr>
												<tr>
													<th align="left">Bugs</th>
													<td align="center">#final_cal_hours_Bug#h #final_cal_mins_Bug#m</td>
												</tr>
												<tr>
													<th align="left">Manual Error</th>
													<td align="center">#final_cal_hours_M#h #final_cal_mins_M#m</td>
												</tr>
												<tr>
													<th align="left">New Requirements</th>
													<td align="center">#final_cal_hours_new#h #final_cal_mins_new#m</td>
												</tr>
												<tr align="center" class="font-12">
													<th><b>TOTAL HOURS</b></th>
													<td><b>#final_cal_hours#h #final_cal_mins#m</b></td>
												</tr>
											</tbody>
										</table>
									</cfif>
									<br>
									<cfif list.recordCount GT 0>
										<table class="totalTable" border="1">
											<tr class="font-12" align="center">
												<th width="110"><b>TOTAL BILLABLE HOURS</b></th>
												<th width="80"><b>#final_cal_hours_b#h #final_cal_mins_b#m</b></th>
											</tr>
										</table>
									</cfif>
								</div>
							</div>
							<div class="row my-3"></div>
						</div>
						<br/>
						<br/>
					</cfloop>
				<cfelse>
					<cfloop list="#url.emp_id#" index="item_emp" delimiters=",">
						<cfinvoke component="models.timesheet" method="getdetails" p1="#url.p_id#" id="#decrypt(item_emp, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"year="#url.year#" month="#url.month#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#"  returnvariable="list"/>
						<table class="text-center listing-table" border="1" width="100%" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
							<thead style="color: ##1C4587">
								
								<tr><th colspan="14" style="font-size:16px;">
									<b>
										<cfif structKeyExists(URL, "p_id") AND URL.p_id NEQ ""> 
											<cfinvoke component="models.timesheet" method="getProject" p1="#URL.p_id#" returnvariable="project">
												#project.name#
										</cfif>
										TIMESHEET - #list.first_name# (#list.des_name#)
									</b></th></tr>
								<cfif NOT structKeyExists(URL, "month") OR structKeyExists(URL, "month") AND URL.month EQ "">
									<!--- <tr><th colspan="12" style="font-size:14px;"><b>JANUARY_2023</b></th></tr> --->
								<cfelse>
									<cfif NOT structKeyExists(URL, "year") OR structKeyExists(URL, "year") AND URL.year EQ "">
										<cfset new_date = createDate(year(now()), URL.month, 1)>
										<tr><th colspan="14" style="font-size:14px;"><b>#UCase(dateFormat(new_date,"mmmm"))#_#dateFormat(now(),"yyyy")#</b></th></tr>
									<cfelse>
										<cfset new_date = createDate(year(now()), URL.month, 1)>
										<tr><th colspan="14" style="font-size:14px;"><b>#UCase(dateFormat(new_date,"mmmm"))#_#URL.year#</b></th></tr>
									</cfif>
								</cfif>
								<tr style="font-size:11px;background-color: ##A4C2F4; text-align: center; height: 50px;">
									<b>
										<th width="80">DATE</th>
										<th width="80">TASK ID</th>
										<th width="125">PROJECT</th>
										<th width="120">REQUIREMENT TYPE</th>
										<th width="120">ASSIGNED BY</th>
										<th width="120">MODULE</th>
										<th width="120">SCOPE</th>
										<th width="600">DESCRIPTION</th>
										<th width="80">STATUS</th>
										<th width="80">START DATE</th>
										<th width="80">START TIME</th>
										<th width="80">END DATE</th>
										<th width="80">END TIME</th>
										<!--- <th width="110">TIME SPENT</th> --->
										<th width="100">PRODUCTIVE HRS</th>
									</b>
								</tr>
							</thead>
							<tbody>
								<cfset k=1>
								<cfset totaltime_hours=0>
								<cfset totaltime_mins=0>
								<cfset New_hours=0>
								<cfset New_mins=0>
								<cfset Bug_hours=0>
								<cfset Bug_mins=0>
								<cfset M_hours=0>
								<cfset M_mins=0>
								<cfset billable_hours=0>
								<cfset billable_mins=0>
								<cfloop query="list">
										<tr style="font-size: 11px; text-align: center; color: black; font-family: serif;">
											<td>#dateformat(list.start_time,"dd-mm-yyyy")#</td>
											<cfif list.task_id NEQ "">
												<td style="color:##7d66e3"><b>#list.task_id#</b></td>
											<cfelse>
												<td>-</td>
											</cfif>
											<td>#ucFirst(list.Pro_name)#</td>
											<cfif list.type EQ "New">
												<td style="background-color: ##BFE1F6;Color: black">#ucFirst(list.type)#</td>
											<cfelseif list.type EQ "Bug">
												<td style="background-color: ##FFE5A0;Color: black">#ucFirst(list.type)#</td>
											<cfelseif list.type EQ "Manual Error">
												<td style="background-color: ##11734B;Color: black">#ucFirst(list.type)#</td>
											</cfif>
											<td>#ucFirst(list.assigned_by_first_name,true)#</td>
											<td>#ucFirst(list.modules,true)#</td>
											<td style="text-align: justify; padding: 10px;">#ucFirst(list.taskDescription)#</td>
											<td style="text-align: justify; padding: 10px;">#ucFirst(list.description)#</td>
											<cfif list.timesheetstatus EQ "In Progress">
												<td style="background-color: ##FF9900;Color: black">#ucFirst(list.timesheetstatus)#</td>
											<cfelseif list.timesheetstatus EQ "Completed">
												<td style="background-color:##B7E1CD;color: Black;">#ucFirst(list.timesheetstatus)#</td>
											<cfelseif list.timesheetstatus EQ "Re-opened">
												<td style="background-color:##fc4138;color: Black;">#ucFirst(list.timesheetstatus)#</td>
											<cfelseif list.timesheetstatus EQ "R&D">
												<td style="background-color:##64c906;color: Black;">#ucFirst(list.timesheetstatus)#</td>
											</cfif>
											<td style="font-size: x-small;">#dateFormat(list.start_time,"dd-mm-yyyy")#</td>
											<td style="font-size: x-small;">#timeFormat(list.start_time,"hh:nn tt")#</td>
											<td style="font-size: x-small;">#dateFormat(list.end_time,"dd-mm-yyyy")#</td>
											<td style="font-size: x-small;">#timeFormat(list.end_time,"hh:nn tt")#</td>
											<!--- <td style="font-size: x-small;">#timeFormat(list.start_time,"hh:nn tt")# - #timeFormat(list.end_time,"hh:nn tt")#</td> --->
											<!--- <td>#dateFormat(list.date,"dd-mmm-yyyy")#</td> --->
											<td>#val(list.productive_hours)#h #val(list.productive_mins)#m</td>
										</tr>
									<cfset k++>
									<cfset totaltime_mins += list.productive_mins>
									<cfset totaltime_hours += list.productive_hours>
									<cfif list.type EQ "New">
										<cfset New_hours += list.productive_hours>
										<cfset New_mins += list.productive_mins>
									<cfelseif list.type EQ "Bug">
										<cfset Bug_hours += list.productive_hours>
										<cfset Bug_mins += list.productive_mins>
									<cfelseif list.type EQ "Manual Error">
										<cfset M_hours += list.productive_hours>
										<cfset M_mins += list.productive_mins>
									</cfif>
									<cfset billable_hours=New_hours+M_hours>
									<cfset billable_mins=New_mins+M_mins>
								</cfloop>
								<!--- minutes hours calculations start --->

								<!--- total --->

								<cfset cal_mins_hour = listGetAt((totaltime_mins/60), 1,".")>
								<cfif cal_mins_hour GT 0>
									<cfset final_cal_hours = totaltime_hours+cal_mins_hour>
									<cfset final_cal_mins = totaltime_mins-(60*cal_mins_hour)>
								<cfelse>
									<cfset final_cal_hours = totaltime_hours>
									<cfset final_cal_mins = totaltime_mins>
								</cfif>

								<!--- New --->

								<cfset cal_mins_hour_new = listGetAt((New_mins/60), 1,".")>
								<cfif cal_mins_hour_new GT 0>
									<cfset final_cal_hours_new = New_hours+cal_mins_hour_new>
									<cfset final_cal_mins_new = New_mins-(60*cal_mins_hour_new)>
								<cfelse>
									<cfset final_cal_hours_new = New_hours>
									<cfset final_cal_mins_new = New_mins>
								</cfif>

								<!--- Bug --->

								<cfset cal_mins_hour_Bug = listGetAt((Bug_mins/60), 1,".")>
								<cfif cal_mins_hour_Bug GT 0>
									<cfset final_cal_hours_Bug = Bug_hours+cal_mins_hour_Bug>
									<cfset final_cal_mins_Bug = Bug_mins-(60*cal_mins_hour_Bug)>
								<cfelse>
									<cfset final_cal_hours_Bug = Bug_hours>
									<cfset final_cal_mins_Bug = Bug_mins>
								</cfif>

								<!--- Manual Error --->

								<cfset cal_mins_hour_M = listGetAt((M_mins/60), 1,".")>
								<cfif cal_mins_hour_M GT 0>
									<cfset final_cal_hours_M = M_hours+cal_mins_hour_M>
									<cfset final_cal_mins_M = M_mins-(60*cal_mins_hour_M)>
								<cfelse>
									<cfset final_cal_hours_M = M_hours>
									<cfset final_cal_mins_M = M_mins>
								</cfif>

								<!--- Billable --->

								<cfset cal_mins_hour_b = listGetAt((billable_mins/60), 1,".")>
								<cfif cal_mins_hour_b GT 0>
									<cfset final_cal_hours_b = billable_hours+cal_mins_hour_b>
									<cfset final_cal_mins_b = billable_mins-(60*cal_mins_hour_b)>
								<cfelse>
									<cfset final_cal_hours_b = billable_hours>
									<cfset final_cal_mins_b = billable_mins>
								</cfif>

								<!--- minutes hours calculations end --->
								<tr>
									<td colspan="13" align="right">Total</td>
									<td style="font-size:small; text-align:center;">#final_cal_hours#h #final_cal_mins#m</td>

								</tr>
							</tbody>
						</table>
						<br><br>
						<div class="container">
							<div class="row">
								<div class="col-2"></div>
								<div class="col-3">
									<table class="totalTable" border="1">
											<tr align="center">
												<th colspan="2" style="font-size:12px;"><b>TOTAL HOURS</b></th>
											</tr>
										</thead>
										<tbody class="font-11">
											<tr align="center">
												<th width="110">Requirement Type</th>
												<th width="80">Hours</th>
											</tr>
											<tr>
												<th align="left">Bugs</th>
												<td align="center">#final_cal_hours_Bug#h #final_cal_mins_Bug#m</td>
											</tr>
											<tr>
												<th align="left">Manual Error</th>
												<td align="center">#final_cal_hours_M#h #final_cal_mins_M#m</td>
											</tr>
											<tr>
												<th align="left">New Requirements</th>
												<td align="center">#final_cal_hours_new#h #final_cal_mins_new#m</td>
											</tr>
											<tr align="center" class="font-12">
												<th><b>TOTAL HOURS</b></th>
												<td><b>#final_cal_hours#h #final_cal_mins#m</b></td>
											</tr>
										</tbody>
									</table>
									<br>
									<table class="totalTable" border="1">
										<tr class="font-12" align="center">
											<th width="110"><b>TOTAL BILLABLE HOURS</b></th>
											<th width="80"><b>#final_cal_hours_b#h #final_cal_mins_b#m</b></th>
										</tr>
									</table>
								</div>
							</div>
							<div class="row my-3"></div>
						</div>
						<br/>
						<br/>
					</cfloop>
				</cfif>
			</body>
		</html>
</cfoutput>