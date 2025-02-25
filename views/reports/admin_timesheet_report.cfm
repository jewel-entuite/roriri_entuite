<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="../logout.cfm">
</cfif>
<cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
<cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>
<cfinvoke component="models.login" method="getuser" returnvariable="user"/>
<cfif structKeyExists(URL, "emp_id") AND URL.emp_id EQ "">
	

	<!--- Total For All employee report --->

	
	
<!--- <cfdump var="#session#"> --->
	<cfdocument format="PDF" orientation="landscape" saveasname="Time Sheet Consolidated Reports.pdf" pagetype="A4">
		<cfdocumentitem type="header" evalAtPrint="false">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
	        		<td>
	        			<p style="float:left;font-size:11px;color:grey;">REPORT GENERATED ON <cfoutput>#UCASE(DateTimeFormat(now(), 'dd-MMMM-YYYY hh:nn:ss tt'))# BY #uCase(session.employee.user_name)#</cfoutput></p>
	        		</td>
	        		<td>
	        			<p style="float:right;font-size:11px;color:grey;">ENTUITE :: HRMS Portal</p>
	        		</td>
	        	</tr>
			</table>
		</cfdocumentitem>
		<cfdocumentitem type="footer" evalAtPrint="false">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><p  style="float:left;font-size:11px;color:grey;">
	        			<cfoutput>REPORT FROM #Ucase(dateFormat(url.FSdate,"dd-mmmm-yyyy"))# TO #Ucase(dateFormat(url.FEdate,"dd-mmmm-yyyy"))#</cfoutput></p>
	        		</td>
					<td> <p style="float:right;font-size:11px;color:grey;"><cfoutput>Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</cfoutput></p></td>
				</tr>
			</table>
		</cfdocumentitem>
		<html>
			<head>
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

			<title></title>
			<style type="text/css">

				.headers,h3,h4{color: darkslateblue;font-family: system-ui,serif;}
			        h4, h5, h6, p{margin: 0px; color: darkslateblue;}
			        p, h6 {font-size: 13px}
			        h4.report-title {
			        text-align: center;
			        background-color: beige;
			        padding: 10px;
			        }
                
			    h4.report-title {
	                text-align: center;
                    background-color: beige;
	                padding: 10px;
        		}
				th.sl-no {
	                width: 8%;
	            }
	           
                table {width:100%}

	            table.report-list thead tr th  {
	                text-align: center;
	                border: 0.5px solid gray;
                    background-color: #d2e8f7;
                    color: darkslateblue;
	                font-size: 12px;
	                padding: 10px;
                    font-family: monospace;
	            }

	            table.report-list tbody tr td {
	                border: 0.5px solid gray;
	                font-size: 11.5px;
	                font-weight: 300;
                    color: #292b2d;
	            }
	            .pagebreak { page-break-before: always; }
	             .center{
	            	text-align: center;
	            }

	        </style>
		</head>
		<cfoutput>
			<body>
				<!--- Background color start --->

				<cfset In_Progress = "##8adb8d">
				<cfset Completed = "##c69cd9">
				<cfset Re_opened = "##d2eff7">
				<cfset R_D = "##facfc8">

				<cfset New = "##d2ebc0">
				<cfset Bug = "##f5a4a9">
				<cfset Manual_Error = "##d7e4fa">


				<!--- Background color end --->

				<cfset grand_total_hours=0>
				<cfset grand_total_mins=0>
				<cfset total_New_hours = 0>
				<cfset total_New_mins = 0>
				<cfset total_Bug_hours = 0>
				<cfset total_Bug_mins = 0>
				<cfset total_M_hours = 0>
				<cfset total_M_mins = 0>
				<cfset total_billable_hours = 0>
				<cfset total_billable_mins = 0>
				<cfloop query="user">

				<cfinvoke component="models.timesheet" method="getdetails" p1="#url.p_id#" id="#user.id#"year="#url.year#" month="#url.month#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" returnvariable="list"/>
				<cfif queryRecordCount(list) GT 0>		
					<div class="container">
			            <div>
	                		<h4 class="report-title" style="text-align: center;">
	                			<cfif structKeyExists(URL, "p_id") AND URL.p_id NEQ ""> 
									<cfinvoke component="models.timesheet" method="getProject" p1="#URL.p_id#" returnvariable="project">
										#project.name#
								</cfif>
								TIMESHEET - #list.first_name# (#list.des_name#) 
								
									<cfif dateFormat(url.FSdate,"mm-yyyy") EQ dateFormat(url.FEdate,"mm-yyyy")>
										<!--- <cfset new_date = createDate(year(now()), URL.month, 1)> --->
										#Ucase(dateFormat(url.FSdate,"mmmm-yyyy"))#
									<cfelse>
										<cfoutput>#Ucase(dateFormat(url.FSdate,"MMM-yyyy"))# To #Ucase(dateFormat(url.FEdate,"MMM-yyyy"))#</cfoutput>
									</cfif>
								<br>
	                		</h4>
	            		</div>
					</div>
					<br>

					<table class="report-list" width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
						<cfoutput>
							<thead>
								<tr class="text-center" style="font-size:small; text-align: center; height: 50px;">
									<th style="width:5%;">#UCase("No.")#</th>
									<th style="width:10%;">#UCase("Start Date")#</th>
									<th style="width:22%;">#UCase("Task Id")#</th>
									<th style="width:5%;">#UCase("Risk")#</th>
									<th style="width:10%;">#UCase("Project")#</th>
									<th style="width:10%;">#UCase("Requirement")#</th>
									<th style="width:10%;">#UCase("Module")#</th>
									<th style="width:25%;">#UCase("Scope")#</th>
									<th style="width:30%;">#UCase("Description")#</th>
									<th style="width:8%;">#UCase("Status")#</th>
									<th style="width:8%;">#UCase("Time spent")#</th>
									<th style="width:13%;">#UCase("Productive hours")#</th>
								</tr>
							</thead>
						</cfoutput>
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
						<cfif queryRecordCount(list) GT 0>
						<tbody>
						<cfset timesheet_array = application.timesheet.filltering(
							fillterByThisOrder = "leaves,weekdays,company_leaves,pending_timesheet",
							emp_id = user.id,
							FSdate = url.FSdate,
							FEdate = url.FEdate
						)/>
						<cfset date_unique = [] />
						<cfloop query="list">
							<cfinvoke component="models.timesheet" method="getTotalWorkedHours"  returnvariable="gethours" taskId="#list.task_id#" emp_id="#list.emp_id#">
							<cfif dateFormat(url.FSdate) NEQ dateFormat(list.start_time)>
								<cfloop  from="#parseDateTime(dateFormat(url.FSdate,"dd-mmm-yyyy"))#" to="#parseDateTime(dateFormat(list.start_time,"dd-mmm-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
									<cfif NOT arrayFindNoCase(date_unique,DL)>
										<cfloop array="#timesheet_array#" index="TA">
											<cfif parseDateTime(dateFormat(DL,"dd-mmm-yyyy")) EQ parseDateTime(dateFormat(TA.DATE,"dd-mmm-yyyy"))>
												<cfif TA.TYPE EQ "pending_timesheet" OR TA.TYPE EQ "company_leaves">
													<cfset backgroundColor = "##f28f94;" />
												<cfelseif TA.TYPE EQ "leave" OR TA.TYPE EQ "company_leaves">
													<cfset backgroundColor = "##e8acac;" />
												<cfelseif TA.TYPE EQ "weekday">
													<cfset backgroundColor = "##f0ced0;" />
												</cfif>
												<tr>
													<td colspan="13" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
														<span style="font-size:medium;">
															(#dateFormat(TA.DATE,'dd-mmm-yyyy')#)
														</span>
														&nbsp;-&nbsp;
														<span style="font-weight: Bold; font-size:medium;">
															#TA.CONTENT#
														</span>
													</td>
												</tr>
												<cfset arrayAppend(date_unique, DL)>
											</cfif>
										</cfloop>
									</cfif>
								</cfloop>
							</cfif>
							<tr class="text-center" style="font-size: 11px; text-align: center; color: black; font-family: serif;">
								<td>#k#</td>
								<td>#dateformat(list.start_time,"dd-mmm-yyyy")#</td>
								<cfif list.task_id NEQ "">
								<td style="color:##7d66e3"><b>#list.task_id#</b><br>
									<span >Assigned: #dateformat(list.assigned_on, 'dd-mmm-yy')#</span><br>
	    							<span >ETA Date: #dateformat(list.deliverBefore, 'dd-mmm-yy')#<br>ETA Hours : #list.estimatedHours# Hr(s)</span><br>
	    							<span>Work Hrs: #list.productive_hours# Hrs <cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></span><br>

									<cfset totalhours = 0>
									<cfset totalmins = 0>
									<cfloop query="gethours">
										<cfif gethours.start_time LTE list.start_time>
											<cfset totalhours += gethours.productive_hours />
											<cfset totalmins += gethours.productive_mins />
										</cfif>
									</cfloop>
									<cfset totalhours += int(totalmins / 60) />
									<cfset totalmins = totalmins mod 60 />
									<cfif NOT (totalhours EQ list.productive_hours AND totalmins EQ list.productive_mins)>
								  		<span>Total Hrs:#totalhours# Hr(s) #totalmins# Min(s)</span>
								  	</cfif>
    							</td>
								<cfelse>
									<td>-</td>
								</cfif>
								<td>
									<cfset workedMinutes = (list.productive_hours * 60) + list.productive_mins>
									<cfset etaMinutes = isNumeric(list.estimatedHours) ? list.estimatedHours * 60 : 0>

									<cfif isNumeric(totalhours) AND isNumeric(totalmins)>
									    <cfset totalMinutes = (totalhours * 60) + totalmins>
									    <cfif totalMinutes GT etaMinutes>
									        <span style="color: red; font-weight: bold;">High</span>
									    <cfelse>
									        <span>-</span>
									    </cfif>
									<cfelse>
									    <cfif workedMinutes GT etaMinutes>
									        <span style="color: red; font-weight: bold;">High</span>
									    <cfelse>
									        <span>-</span>
									    </cfif>
									</cfif>
								</td>
								<td>#ucFirst(list.Pro_name)#</td>
								<cfif list.type EQ "New">
									<td style="background-color: #New#;">#ucFirst(list.type)#</td>
								<cfelseif list.type EQ "Bug">
									<td style="background-color: #Bug#;">#ucFirst(list.type)#</td>
								<cfelseif list.type EQ "Manual Error">
									<td style="background-color: #Manual_Error#;">#ucFirst(list.type)#</td>
								<cfelse>
									<td></td>
								</cfif>
								<td>#ucFirst(list.modules,true)#</td>
								<td style="text-align: justify; padding: 10px;">#ucFirst(list.taskDescription)#</td>
								<td style="text-align: justify; padding: 10px;">#ucFirst(list.description)#</td>
								<cfif list.status_id EQ 1>
									<td style="background-color: #In_Progress#;">#ucFirst("Completed")#</td>
								<cfelseif list.status_id EQ 2>
									<td style="background-color:#Completed#;">#ucFirst("In Progress")#</td>
								<cfelseif list.status_id EQ 3>
									<td style="background-color:#Re_opened#;">#ucFirst("Re-opened")#</td>
								<cfelseif list.status_id EQ 4>
									<td style="background-color:#R_D#;">#ucFirst("R&D")#</td>
								<cfelse>
									<td></td>
								</cfif>
								<td>#timeFormat(list.start_time,"hh:nn tt")#<br>to<br>#timeFormat(list.end_time,"hh:nn tt")#</td>
								<!--- <td style="font-size: x-small;">#timeFormat(list.start_time,"hh:nn tt")#<br>to<br>#timeFormat(list.end_time,"hh:nn tt")#</td> --->
								<!--- <td>#dateFormat(list.date,"dd-mmm-yyyy")#</td> --->
								<td>#val(list.productive_hours)#h #val(list.productive_mins)#m</td>
							</tr>
							
							<cfif queryRecordCount(list) EQ k>
								<cfif dateFormat(url.FEdate) NEQ dateFormat(list.start_time)>
									<cfloop  from="#parseDateTime(dateFormat(list.start_time,"dd-mmm-yyyy"))#" to="#parseDateTime(dateFormat(url.FEdate,"dd-mmm-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
										<cfif NOT arrayFindNoCase(date_unique,DL)>
											<cfloop array="#timesheet_array#" index="TA">
												<cfif parseDateTime(dateFormat(DL,"dd-mmm-yyyy")) EQ parseDateTime(dateFormat(TA.DATE,"dd-mmm-yyyy"))>
													<cfif TA.TYPE EQ "pending_timesheet" OR TA.TYPE EQ "company_leaves">
														<cfset backgroundColor = "##f28f94;" />
													<cfelseif TA.TYPE EQ "leave" OR TA.TYPE EQ "company_leaves">
														<cfset backgroundColor = "##e8acac;" />
													<cfelseif TA.TYPE EQ "weekday">
														<cfset backgroundColor = "##f0ced0;" />
													</cfif>
													<tr>
														<td colspan="13" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
															<span style="font-size:medium;">
																(#dateFormat(TA.DATE,'dd-mmm-yyyy')#)
															</span>
															&nbsp;-&nbsp;
															<span style="font-weight: Bold; font-size:medium;">
																#TA.CONTENT#
															</span>
														</td>
													</tr>
													<cfset arrayAppend(date_unique, DL)>
												</cfif>
											</cfloop>
										</cfif>
									</cfloop>
								</cfif>
							</cfif>
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
							<td colspan="11"></td>
							<td style="font-size:13px; text-align:center;">Total: #final_cal_hours#h #final_cal_mins#m</td>
						</tr>
						</tbody><br>
					<cfelse>
						<tfoot>
						<tr>
							<td colspan="14" class="text-center"><center><h5 style="font-family: serif; color:##d61c0f;">No Records Found!</h5></center></td>
						</tr><br>
					</tfoot>
					</cfif>
					</table>
					<cfset grand_total_hours += totaltime_hours>
					<cfset grand_total_mins += totaltime_mins>
					<cfset total_New_hours += New_hours>
					<cfset total_New_mins += New_mins>
					<cfset total_Bug_hours += Bug_hours>
					<cfset total_Bug_mins += Bug_mins>
					<cfset total_M_hours += M_hours>
					<cfset total_M_mins += M_mins>
					<cfset total_billable_hours += New_hours+M_hours>
					<cfset total_billable_mins += New_mins+M_mins>
					<cfdocumentitem type="pagebreak" />
				</cfif>
				</cfloop>


				<!--- Total minutes hours calculations start --->

						<!--- total --->

						<cfset cal_mins_hour_total = listGetAt((grand_total_mins/60), 1,".")>
						<cfif cal_mins_hour_total GT 0>
							<cfset final_cal_hours_total = grand_total_hours+cal_mins_hour_total>
							<cfset final_cal_mins_total = grand_total_mins-(60*cal_mins_hour_total)>
						<cfelse>
							<cfset final_cal_hours_total = grand_total_hours>
							<cfset final_cal_mins_total = grand_total_mins>
						</cfif>

						<!--- New --->

						<cfset cal_mins_hour_new_total = listGetAt((total_New_mins/60), 1,".")>
						<cfif cal_mins_hour_new_total GT 0>
							<cfset final_cal_hours_new_total = total_New_hours+cal_mins_hour_new_total>
							<cfset final_cal_mins_new_total = total_New_mins-(60*cal_mins_hour_new_total)>
						<cfelse>
							<cfset final_cal_hours_new_total = total_New_hours>
							<cfset final_cal_mins_new_total = total_New_mins>
						</cfif>

						<!--- Bug --->

						<cfset cal_mins_hour_Bug_total = listGetAt((total_Bug_mins/60), 1,".")>
						<cfif cal_mins_hour_Bug_total GT 0>
							<cfset final_cal_hours_Bug_total = total_Bug_hours+cal_mins_hour_Bug_total>
							<cfset final_cal_mins_Bug_total = total_Bug_mins-(60*cal_mins_hour_Bug_total)>
						<cfelse>
							<cfset final_cal_hours_Bug_total = total_Bug_hours>
							<cfset final_cal_mins_Bug_total = total_Bug_mins>
						</cfif>

						<!--- Manual Error --->

						<cfset cal_mins_hour_M_total = listGetAt((total_M_mins/60), 1,".")>
						<cfif cal_mins_hour_M_total GT 0>
							<cfset final_cal_hours_M_total = total_M_hours+cal_mins_hour_M_total>
							<cfset final_cal_mins_M_total = total_M_mins-(60*cal_mins_hour_M_total)>
						<cfelse>
							<cfset final_cal_hours_M_total = total_M_hours>
							<cfset final_cal_mins_M_total = total_M_mins>
						</cfif>

						<!--- Billable --->

						<cfset cal_mins_hour_b_total = listGetAt((total_billable_mins/60), 1,".")>
						<cfif cal_mins_hour_b_total GT 0>
							<cfset final_cal_hours_b_total = total_billable_hours+cal_mins_hour_b_total>
							<cfset final_cal_mins_b_total = total_billable_mins-(60*cal_mins_hour_b_total)>
						<cfelse>
							<cfset final_cal_hours_b_total = total_billable_hours>
							<cfset final_cal_mins_b_total = total_billable_mins>
						</cfif>

						<!--- Total minutes hours calculations end --->
				<br/>
					<table class="report-list" width="100%" align="center" border="1" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
						<thead>
							<tr style="font-size:small; text-align: left;height: 50px;">
								<th style="text-align:center;">#ucase("Requirement Type")#</th>
								<th style="text-align:center;">#ucase("Hours")#</th>
							</tr>
						</thead>
						<tr style="font-size:small; text-align: left;height: 35px;">
							<td >Bugs</td>
							<td style = "text-align: center;">#final_cal_hours_Bug_total#h #final_cal_mins_Bug_total#m</td>
						</tr>
						<tr style="font-size:small; text-align: left; height: 35px;">
							<td>Manual Error</td>
							<td style = "text-align: center;">#final_cal_hours_M_total#h #final_cal_mins_M_total#m</td>
						</tr>
						<tr style="font-size:small; text-align: left; height: 35px;">
							<td>New Requirement</td>
							<td style = "text-align: center;">#final_cal_hours_new_total#h #final_cal_mins_new_total#m</td>
						</tr>
						<tr style="font-size:small; text-align: left;height: 35px;">
							<th>Total Hours</th>
							<td style = "text-align: center;"><b>#final_cal_hours_total#h #final_cal_mins_total#m</b></td>
						</tr>
						<tr style="font-size:small; text-align: left;height: 35px;">
							<th style="font-size: 14px;"><b>Total Billable Hours</b></th>
							<td style = "text-align: center;font-size: 14px;"><b>#final_cal_hours_b_total#h #final_cal_mins_b_total#m</b></td>
						</tr>
					</table>
			</body>
		</cfoutput>
		</html>
	</cfdocument>

<cfelse>

	<!--- Individual report --->
	<!--- <cfif structKeyExists(url, "emp_id") AND url.emp_id NEQ "" AND listlen(url.emp_id) GT 1>
		<cfset local.emp_id = []>
		<cfloop list="#url.emp_id#" item="empid">
			<cfset eid = decrypt(empid, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>
			<cfset arrayAppend(local.emp_id, eid)>
		</cfloop>
		<cfset local.emp_id = arrayToList(local.emp_id)>
	<cfelse>
		<cfset local.emp_id=decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>
	</cfif> --->
	

	<cfdocument format="PDF" orientation="landscape" saveasname="Time Sheet Individual Report.pdf" pagetype="A4">
		<cfdocumentitem type="header" evalAtPrint="false">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
	        		<td>
	        			<p style="float:left;font-size:11px;color:grey;">REPORT GENERATED ON <cfoutput>#UCASE(DateTimeFormat(now(), 'dd-MMMM-YYYY hh:nn:ss tt'))# BY #uCase(session.employee.user_name)#</cfoutput></p>
	        		</td>
	        	</tr>
			</table>
		</cfdocumentitem>
		<cfdocumentitem type="footer" evalAtPrint="false">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center" style="font-size: 11px;color: grey;"><cfoutput>Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</cfoutput></td>
				</tr>
			</table>
		</cfdocumentitem>

		<html>
			<head>
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

				<title></title>
				<style type="text/css">

					.headers,h3,h4{color: darkslateblue;font-family: system-ui,serif;}
				        h4, h5, h6, p{margin: 0px; color: darkslateblue;}
				        p, h6 {font-size: 13px}
				        h4.report-title {
				        text-align: center;
				        background-color: beige;
				        padding: 10px;
				        }
	                
				    h4.report-title {
		                text-align: center;
	                    background-color: beige;
		                padding: 10px;
	        		}
					th.sl-no {
		                width: 8%;
		            }
		           
	                table {width:100%}

		            table.report-list thead tr th  {
		                text-align: center;
		                border: 0.5px solid gray;
	                    background-color: #d2e8f7;
	                    color: darkslateblue;
		                font-size: 12px;
		                padding: 10px;
	                    font-family: monospace;
		            }

		            table.report-list tbody tr td {
		                border: 0.5px solid gray;
		                font-size: 11.5px;
		                font-weight: 300;
	                    color: #292b2d;
		            }
		            .pagebreak { page-break-before: always; }
		             .center{
		            	text-align: center;
		            }

		        </style>
			</head>
			<body style="align-content: center;">
				<cfloop list="#url.emp_id#" item="item_emp" delimiters=",">
					<cfinvoke component="models.timesheet" method="getdetails" p1="#url.p_id#" id="#decrypt(item_emp, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"year="#url.year#" month="#url.month#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#" returnvariable="list"/>
					<cfoutput>
						<h4 class="display-4" style="text-align: center; color: ##1a0c4f;">
						<div class="container">
				            <div>

		                		<h4 class="report-title" style="text-align: center;">
		                			<cfif structKeyExists(URL, "p_id") AND URL.p_id NEQ ""> 
									<cfinvoke component="models.timesheet" method="getProject" p1="#URL.p_id#" returnvariable="project">
										#project.name#
									</cfif> 
									TIMESHEET - #list.first_name# (#list.des_name#) 
									<!--- <cfif NOT structKeyExists(URL, "month") OR structKeyExists(URL, "month") AND URL.month EQ "">
										<!--- <tr><th colspan="8" style="font-size:14px;"><b>JANUARY_2023</b></th></tr> --->
									<cfelse>
										<cfif NOT structKeyExists(URL, "year") OR structKeyExists(URL, "year") AND URL.year EQ "">
											<cfset new_date = createDate(year(now()), URL.month, 1)>
											#UCase(dateFormat(new_date,"mmmm"))#-#dateFormat(now(),"yyyy")#
										<cfelse>
											<cfset new_date = createDate(year(now()), URL.month, 1)>
											#UCase(dateFormat(new_date,"mmmm"))#-#URL.year#
										</cfif>
									</cfif> --->
									<cfif dateFormat(url.FSdate,"mm-yyyy") EQ dateFormat(url.FEdate,"mm-yyyy")>
														<!--- <cfset new_date = createDate(year(now()), URL.month, 1)> --->
														#Ucase(dateFormat(url.FSdate,"mmmm-yyyy"))#
									<cfelse>
										<cfoutput>#Ucase(dateFormat(url.FSdate,"MMM-yyyy"))# To #Ucase(dateFormat(url.FEdate,"MMM-yyyy"))#</cfoutput>
									</cfif><br>
		                		</h4>
		            		</div>
						</div><br>
					</cfoutput>
						<!--- <h3 class="display-4" style="text-align: center; color: ##264653;">Time Sheet Report of #list.user_name#</h3> --->
						<!--- <P class="display-4" style="text-align: left; font-size:small; color:##181033; font-family: serif; font-size: medium;">Employee Name:  #list.first_name#</P> --->

					<!--- Background color start --->

					<cfset In_Progress = "##8adb8d">
					<cfset Completed = "##c69cd9">
					<cfset Re_opened = "##d2eff7">
					<cfset R_D = "##facfc8">

					<cfset New = "##d2ebc0">
					<cfset Bug = "##f5a4a9">
					<cfset Manual_Error = "##d7e4fa">

					<!--- Background color end --->
					<cfoutput>
						<table class="report-list" border="1" cellspacing="0" cellpadding="2" style="border-collapse:collapse;">
							<cfoutput>
								<thead style="background-color: ##d0d1f7; color: ##361d45;">
									<tr class="text-center">
										<th style="width:5%;">#UCase("Sl.No")#</th>
										<th style="width:10%;">#UCase("Start Date")#</th>
										<th style="width:20%;">#UCase("Task Id")#</th>
										<th style="width:5%;">#UCase("Risk")#</th>
										<th style="width:10%;">#UCase("Project")#</th>
										<th style="width:10%;">#UCase("Requirement")#</th>
										<th style="width:10%;">#UCase("Module")#</th>
										<th style="width:30%;">#UCase("Description")#</th>
										<th style="width:8%;">#UCase("Status")#</th>
										<th style="width:8%;">#UCase("Time Spent")#</th>
										<th style="width:15%;">#UCase("Productive hours")#</th>
									</tr>
								</thead>
							</cfoutput>
							<tbody>
								<cfset k=1>
								<cfset employee_project_count = arrayNew()>
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
								<cfset timesheet_array = application.timesheet.filltering(
										fillterByThisOrder = "leaves,weekdays,company_leaves,pending_timesheet",
										emp_id = decrypt(item_emp, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX'),
										FSdate = url.FSdate,
										FEdate = url.FEdate
									)/>
								<cfset date_unique = [] />
								<cfloop query="list">
									<cfinvoke component="models.timesheet" method="getTotalWorkedHours"  returnvariable="gethours" taskId="#list.task_id#" emp_id="#list.emp_id#">
									<cfif NOT arrayFindNoCase(employee_project_count, dateFormat(list.start_time,"dd-mm-yyyy"))>
										<cfset arrayAppend(employee_project_count, dateFormat(list.start_time,"dd-mm-yyyy"))>
									</cfif>
									<cfif dateFormat(url.FSdate) NEQ dateFormat(list.start_time)>
										<cfloop  from="#parseDateTime(dateFormat(url.FSdate,"dd-mmm-yyyy"))#" to="#parseDateTime(dateFormat(list.start_time,"dd-mmm-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
											<cfif NOT arrayFindNoCase(date_unique,DL)>
												<cfloop array="#timesheet_array#" index="TA">
													<cfif parseDateTime(dateFormat(DL,"dd-mmm-yyyy")) EQ parseDateTime(dateFormat(TA.DATE,"dd-mmm-yyyy"))>
														<cfif TA.TYPE EQ "pending_timesheet" OR TA.TYPE EQ "company_leaves">
															<cfset backgroundColor = "##f28f94;" />
														<cfelseif TA.TYPE EQ "leave" OR TA.TYPE EQ "company_leaves">
															<cfset backgroundColor = "##e8acac;" />
														<cfelseif TA.TYPE EQ "weekday">
															<cfset backgroundColor = "##f0ced0;" />
														</cfif>
														<tr>
															<td colspan="13" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
																<span style="font-size:medium;">
																	(#dateFormat(TA.DATE,'dd-mmm-yyyy')#)
																</span>
																&nbsp;-&nbsp;
																<span style="font-weight: Bold; font-size:medium;">
																	#TA.CONTENT#
																</span>
															</td>
														</tr>
														<cfset arrayAppend(date_unique, DL)>
													</cfif>
												</cfloop>
											</cfif>
										</cfloop>
									</cfif>
									<tr class="text-center" style="font-size: 11px; text-align: center; color: black; font-family: serif;">
										<td>#k#</td>
										<td>#dateformat(list.start_time,"dd-mmm-yyyy")#</td>
										<cfif list.task_id NEQ "">
											<td style="color:##7d66e3"><b>#list.task_id#</b><br>
												<span >Assigned: #dateformat(list.assigned_on, 'dd-mmm-yy')#</span><br>
				    							<span >ETA Date: #dateformat(list.deliverBefore, 'dd-mmm-yy')#<br>ETA Hours: #list.estimatedHours# Hr(s)</span><br>
				    							<span>Work Hrs: #list.productive_hours# Hrs <cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></span><br>

											<cfset totalhours = 0>
											<cfset totalmins = 0>
											<cfloop query="gethours">
												<cfif gethours.start_time LTE list.start_time>
													<cfset totalhours += gethours.productive_hours />
													<cfset totalmins += gethours.productive_mins />
												</cfif>
											</cfloop>
											<cfset totalhours += int(totalmins / 60) />
											<cfset totalmins = totalmins mod 60 />
											<cfif NOT (totalhours EQ list.productive_hours AND totalmins EQ list.productive_mins)>
										  		<span>Total Hrs:#totalhours# Hr(s) #totalmins# Min(s)</span>
										  	</cfif>
				    						</td>
										<cfelse>
											<td>-</td>
										</cfif>
										<td>
											<cfset workedMinutes = (list.productive_hours * 60) + list.productive_mins>
											<cfset etaMinutes = isNumeric(list.estimatedHours) ? list.estimatedHours * 60 : 0>

											<cfif isNumeric(totalhours) AND isNumeric(totalmins)>
											    <cfset totalMinutes = (totalhours * 60) + totalmins>
											    <cfif totalMinutes GT etaMinutes>
											        <span style="color: red; font-weight: bold;">High</span>
											    <cfelse>
											        <span>-</span>
											    </cfif>
											<cfelse>
											    <cfif workedMinutes GT etaMinutes>
											        <span style="color: red; font-weight: bold;">High</span>
											    <cfelse>
											        <span>-</span>
											    </cfif>
											</cfif>
										</td>
										<td>#ucFirst(list.Pro_name)#</td>
										<cfif list.type EQ "New">
											<td style="background-color: #New#;Color: black">#ucFirst(list.type)#</td>
										<cfelseif list.type EQ "Bug">
											<td style="background-color: #Bug#;Color: black">#ucFirst(list.type)#</td>
										<cfelseif list.type EQ "Manual Error">
											<td style="background-color: #Manual_Error#;Color: black">#ucFirst(list.type)#</td>
										<cfelse>
											<td></td>
										</cfif>
										<td>#ucFirst(list.modules,true)#</td>
										<td style="text-align: justify; padding: 10px;">#ucFirst(list.description)#</td>
										<cfif list.status_id EQ 1>
											<td style="background-color: #In_Progress#;">#ucFirst("Completed")#</td>
										<cfelseif list.status_id EQ 2>
											<td style="background-color:#Completed#;">#ucFirst("In Progress")#</td>
										<cfelseif list.status_id EQ 3>
											<td style="background-color:#Re_opened#;">#ucFirst("Re-opened")#</td>
										<cfelseif list.status_id EQ 4>
											<td style="background-color:#R_D#;">#ucFirst("R&D")#</td>
										<cfelse>
											<td></td>
										</cfif>
										<td>#timeFormat(list.start_time,"hh:nn tt")#<br>to<br>#timeFormat(list.end_time,"hh:nn tt")#</td>
										<!--- <td style="font-size: x-small;">#timeFormat(list.start_time,"hh:nn tt")#<br>to<br>#timeFormat(list.end_time,"hh:nn tt")#</td> --->
										<!--- <td>#dateFormat(list.date,"dd-mmm-yyyy")#</td> --->
										<td>#val(list.productive_hours)#h #val(list.productive_mins)#m</td>
									</tr>
									<cfif queryRecordCount(list) EQ k>
										<cfif dateFormat(url.FEdate) NEQ dateFormat(list.start_time)>
											<cfloop  from="#parseDateTime(dateFormat(list.start_time,"dd-mmm-yyyy"))#" to="#parseDateTime(dateFormat(url.FEdate,"dd-mmm-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
												<cfif NOT arrayFindNoCase(date_unique,DL)>
													<cfloop array="#timesheet_array#" index="TA">
														<cfif parseDateTime(dateFormat(DL,"dd-mmm-yyyy")) EQ parseDateTime(dateFormat(TA.DATE,"dd-mmm-yyyy"))>
															<cfif TA.TYPE EQ "pending_timesheet" OR TA.TYPE EQ "company_leaves">
																<cfset backgroundColor = "##f28f94;" />
															<cfelseif TA.TYPE EQ "leave" OR TA.TYPE EQ "company_leaves">
																<cfset backgroundColor = "##e8acac;" />
															<cfelseif TA.TYPE EQ "weekday">
																<cfset backgroundColor = "##f0ced0;" />
															</cfif>
															<tr>
																<td colspan="13" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
																	<span style="font-size:medium;">
																		(#dateFormat(TA.DATE,'dd-mmm-yyyy')#)
																	</span>
																	&nbsp;-&nbsp;
																	<span style="font-weight: Bold; font-size:medium;">
																		#TA.CONTENT#
																	</span>
																</td>
															</tr>
															<cfset arrayAppend(date_unique, DL)>
														</cfif>
													</cfloop>
												</cfif>
											</cfloop>
										</cfif>
									</cfif>
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
									<cfset working_days_count = ArrayLen(employee_project_count)>
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
									<td colspan="10"></td>
									<td style="font-size:small; text-align:center;">Total:#final_cal_hours#h #final_cal_mins#m</td>

								</tr>
							</tbody>
						</table><br/>
					</cfoutput>
					<cfdocumentitem type="pagebreak" />
					<cfoutput>
						<table class="report-list" width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse:collapse;">
							<thead>
								<tr style="font-size:11px; text-align: left;">
									<th style="text-align:center;">Requirement Type</th>
									<th style="text-align:center;">Hours</th>
								</tr>
							</thead>
							<tr style="font-size:11px; text-align: left;">
								<td>Bugs</td>
								<td style = "text-align: center;">#final_cal_hours_Bug#h #final_cal_mins_Bug#m</td>
							</tr>
							<tr style="font-size:11px; text-align: left;">
								<td>Manual error</td>
								<td style = "text-align: center;">#final_cal_hours_M#h #final_cal_mins_M#m</td>
							</tr>
							<tr style="font-size:11px; text-align: left;">
								<td>New requirement</td>
								<td style = "text-align: center;">#final_cal_hours_new#h #final_cal_mins_new#m</td>
							</tr>
							<tr style="font-size:11px; font-style: bold; text-align: left;">
								<th><b>Total hours</b></th>
								<td style = "text-align: center; font-style: bold;"><b>#final_cal_hours#h #final_cal_mins#m</b></td>
							</tr>
							<tr style="font-size:11px; text-align: left;">
								<th style="font-size: 14px;"><b>Total billable hours</b></th>
								<td style = "text-align: center; font-size: 14px;"><b>#final_cal_hours_b#h #final_cal_mins_b#m</b></td>
							</tr>
							<cfif structKeyExists(url,"emp_id") AND structKeyExists(url,"p_id") AND URL.emp_id NEQ "" AND URL.p_id NEQ "">
								<tr style="font-size:11px; text-align: left;">
									<th style="font-size: 14px;"><b>Employee-Project wise working days</b></th>
									<td style = "text-align: center; font-size: 14px;"><b>#working_days_count#</b></td>
								</tr>
							</cfif>
						</table>
					</cfoutput>
					<cfdocumentitem type="pagebreak" />
				</cfloop>
			</body>
		</html>
	</cfdocument>
	</body>
	</html>
</cfif> 