<cfif NOT structKeyExists(session, "employee")>
    <cflocation url="logout.cfm">
</cfif>
<cfif structKeyExists(url, "employeeid") AND url.employeeid NEQ "">
	<cfif structKeyExists(url, "p_id")>
		<cfinvoke component="models.timesheet" method="getdetails" FSdate="#URL.FSdate#" FEdate="#URL.FEdate#" p1="#url.p_id#" id="#decrypt(url.employeeid, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"year="#url.year#" month="#url.month#" module="#url.module#" status="#url.status#" req="#url.req#" returnvariable="list"/>
	<cfelse>
		<cfinvoke component="models.timesheet" method="getdetails" FSdate="#URL.FSdate#" FEdate="#URL.FEdate#" id="#decrypt(url.employeeid, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" year="#url.year#" month="#url.month#" module="#url.module#" status="#url.status#" req="#url.req#"  returnvariable="list"/>
	</cfif>
	<cfelseif structKeyExists(url, "emp_id") AND url.emp_id NEQ "" AND structKeyExists(url, "employeeid") AND url.employeeid EQ "">
		<cfif structKeyExists(url, "p_id")>
			<cfinvoke component="models.timesheet" method="getdetails" FSdate="#URL.FSdate#" FEdate="#URL.FEdate#" p1="#url.p_id#" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"year="#url.year#" month="#url.month#" module="#url.module#" status="#url.status#" req="#url.req#" returnvariable="list"/>
		<cfelse>
			<cfinvoke component="models.timesheet" method="getdetails" FSdate="#URL.FSdate#" FEdate="#URL.FEdate#" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" year="#url.year#" month="#url.month#" module="#url.module#" status="#url.status#" req="#url.req#"  returnvariable="list"/>
		</cfif>	
<cfelse>
	<cfinvoke component="models.timesheet" method="getdetails" FSdate="#URL.FSdate#" FEdate="#URL.FEdate#" returnvariable="list" id="#decrypt(session.employee.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"/>
</cfif>
<cfdocument format="PDF" orientation="landscape" saveasname="Time Sheet Individual Report.pdf" pagetype="A4">
	<cfdocumentitem type="header" evalAtPrint="true">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
        		<td>
        			<p style="float:left;font-size:11px;color:grey;">REPORT GENERATED ON <cfoutput>#UCASE(DateTimeFormat(now(), 'dd-MMMM-YYYY hh:nn:ss tt'))# BY #uCase(list.first_name)# #uCase(list.last_name)#</cfoutput></p>
        		</td>
        	</tr>
		</table>
	</cfdocumentitem>
	<cfdocumentitem type="footer" evalAtPrint="true">
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
		<body style="align-content: center;">
			<cfoutput>
				<div class="container">
		            <div>
                		<h4 class="report-title" style="text-align: center;">TIMESHEET - #list.first_name# (#list.des_name#) 
                	<!--- <cfif NOT structKeyExists(URL, "month") OR structKeyExists(URL, "month") AND URL.month EQ "">
						<!--- <tr><th colspan="8" style="font-size:14px;"><b>JANUARY_2023</b></th></tr> --->
					<cfelse>
						<cfif NOT structKeyExists(URL, "year") OR structKeyExists(URL, "year") AND URL.year EQ "">
							<cfset new_date = createDate(year(now()), URL.month, 1)>
							#UCase(dateFormat(new_date,"mmmm"))#-#dateFormat(now(),"yyyy")#
						<cfelse>
							<cfset new_date = createDate(year(now()), URL.month, 1)>
							#UCase(dateFormat(new_date,"mmmm"))#-#URL.year#
						</cfif> --->
						<cfif dateFormat(url.FSdate,"mm-yyyy") EQ dateFormat(url.FEdate,"mm-yyyy")>
							#Ucase(dateFormat(url.FSdate,"mmmm-yyyy"))#
						<cfelse>
							<cfoutput>#Ucase(dateFormat(url.FSdate,"MMM-yyyy"))# To #Ucase(dateFormat(url.FEdate,"MMM-yyyy"))#</cfoutput>
						</cfif>
						<br>
                		</h4>
            		</div>
				</div>
				<br>
			</cfoutput>
			<!--- <h2 class="display-4" style="text-align: center; color: #1a0c4f;">TIME SHEET</h2> --->
			<!--- <h3 class="display-4" style="text-align: center; color: #264653;">Time Sheet Report of <cfoutput>#list.user_name#</cfoutput></h3> --->
			<!--- <P class="display-4" style="text-align: left; font-size:small; color:#181033; font-family: serif; font-size: medium;">Employee Name:  <cfoutput>#list.first_name#</cfoutput></P> --->

			<!--- Background color start --->

			<cfset In_Progress = "##8adb8d">
			<cfset Completed = "##c69cd9">
			<cfset Re_opened = "##d2eff7">
			<cfset R_D = "##facfc8">

			<cfset New = "##d2ebc0">
			<cfset Bug = "##f5a4a9">
			<cfset Manual_Error = "##d7e4fa">

			<!--- Background color end --->

			<table class="report-list" border="1" cellspacing="0" cellpadding="2" style="border-collapse:collapse;">
				<cfoutput>
					<thead>
						<tr class="text-center">
							<th style="width:3%;">#UCase("Sl.No")#</th>
							<th style="width:7%;">#UCase("Start Date")#</th>
							<th style="width:18%;">#UCase("Task Id")#</th>
							<th style="width:5%;">#UCase("Risk")#</th>
							<th style="width:10%;">#UCase("Project")#</th>
							<th style="width:8%;">#UCase("Requirement")#</th>
							<th style="width:10%;">#UCase("Module")#</th>
							<th style="width:25%;">#UCase("Scope")#</th>
							<th style="width:25%;">#UCase("Description")#</th>
							<th style="width:8%;">#UCase("Status")#</th>
							<th style="width:8%;">#UCase("Time spent")#</th>
							<!--- <th>#UCase("Duration")#</th> --->
							<!--- <th>Updated On</th> --->
							<th style="width:15%;">#UCase("Productive hours")#</th>
						</tr>
					</thead>
				</cfoutput>
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
				<cfoutput>
				<cfloop query="list">
					<cfinvoke component="models.timesheet" method="getTotalWorkedHours"  returnvariable="gethours" taskId="#list.task_id#" emp_id="#list.emp_id#">
						<tr class="text-center" style="font-size: 14px; text-align: center; font-family: serif;">
							<td>#k#</td>
							<td>#dateformat(list.start_time,"dd-mm-yyyy")#</td>
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
								<cfset etaMinutes = list.estimatedHours * 60>
								<cfset totalHoursDisplayed = NOT (totalhours EQ list.productive_hours AND list.productive_mins EQ totalmins)>

								<cfif totalHoursDisplayed>
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
							<td>#ucFirst(list.name)#</td>
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
					<td style="font-size:small; text-align:center;">Total:#final_cal_hours#h #final_cal_mins#m</td>

				</tr>
				</tbody>
			</table>
			<br/>
			<table class="report-list" border="1" cellspacing="0" cellpadding="2" style="border-collapse:collapse;">
				<tr style="font-size:smaller; text-align: left;">
					<th style="text-align:center;">Requirement Type</th>
					<th style="text-align:center;">Hours</th>
				</tr>
				<tr style="font-size:smaller; text-align: left;background-color: #Bug#;">
					<td >Bugs</td>
					<td style = "text-align: center;">#final_cal_hours_Bug#h #final_cal_mins_Bug#m</td>
				</tr>
				<tr style="font-size:smaller; text-align: left; background-color: #Manual_Error#;">
					<td>Manual error</td>
					<td style = "text-align: center;">#final_cal_hours_M#h #final_cal_mins_M#m</td>
				</tr>
				<tr style="font-size:smaller; text-align: left; background-color: #New#;">
					<td>New requirement</td>
					<td style = "text-align: center;">#final_cal_hours_new#h #final_cal_mins_new#m</td>
				</tr>
				<tr style="font-size:smaller; text-align: left;">
					<th>Total hours</th>
					<td style = "text-align: center;">#final_cal_hours#h #final_cal_mins#m</td>
				</tr>
				<tr style="font-size:smaller; text-align: left;">
					<th style="font-size: 11px;"><b>Total billable hours</b></th>
					<td style = "text-align: center; font-size: 11px;"><b>#final_cal_hours_b#h #final_cal_mins_b#m</b></td>
				</tr>
			</table>
			</cfoutput>
		</body>
	</html>
</cfdocument> 
</body>
</html>