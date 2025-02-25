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

		<link rel="stylesheet" href="assets/css/style.css">
		<title>RORIRI -Employee Management</title>
		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">
		<style>
			.pointer {
				cursor: pointer;
			}
		</style>	
		<!-- Template Main CSS File -->
		<link href="assets/css/style.css" rel="stylesheet">
		<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
	</head>

	<body>
		<cfoutput>
			<cfif NOT structKeyExists(session, "employee")>
				<cflocation url="logout.cfm">
			</cfif>
			<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
			<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
			<cfif structKeyExists(url, "p_id")>
				<cfinvoke component="models.timesheet" method="getProject" p1=#url.p_id# id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" argumentcollection="#form#" returnvariable="list"/>
			<cfelse>
				<cfinvoke component="models.timesheet" method="getdetails" p1=#url.project# id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#"  argumentcollection="#form#" returnvariable="list"/>
			</cfif>

			<cfinvoke component="models.timesheet" method="getAllProject" returnvariable="projectList"/>
			<cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
			<cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>
			<!--- header --->
			<cfset print="user_dashboard_print">
			<cfset active_status="more">
			<cfinclude template="../includes/header/user_header.cfm" runonce="true">
			<!--- header ends --->
			<div class="alert alert-warning" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">	
				<center><h1><STRONG>TIMESHEET</STRONG></h1></center>
			</div>

			<!--- timesheet filter --->

			<div class="container my-5">
				<div class="row">

					<div class="col-2">
						<input type="date" class="form-control border-dark" name="filter_start_Date" id="filter_start_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "FSdate") AND url.FSdate NEQ  ""> value="#URL.FSdate#"</cfif>>
					</div>

					<div class="col-2">
						<input type="date" class="form-control border-dark" name="filter_end_Date" id="filter_end_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "FEdate") AND url.FEdate NEQ ""> value="#URL.FEdate#"</cfif>>
					</div>

					<div class="col-2">
						<select class="form-select border-dark" name="project" id="project" onchange="filter('#url.emp_id#')">
							<option class="dropdown-item" value="">	Project</option>
							<cfloop query="projectList">
								<option class="dropdown-item" value="#projectList.id#" <cfif structKeyExists(url, "project") AND url.project EQ projectList.id> selected</cfif>>#projectList.name#</option>
							</cfloop>
						</select>
					</div>
					<cfif structKeyExists(url, "project") AND url.project GTE 1>
						<div class="col-2">
							<cfinvoke  component="models.timesheet" method="modulelist" returnvariable="m" pro_id="#url.project#"/>
							<select class="form-select border-dark" name="module" id="module" onchange="filter('#url.emp_id#')">
								<option class="dropdown-item" value="">Module</option>
								<cfloop query="m">
									<option class="dropdown-item" value="#m.name#"<cfif structKeyExists(url, "module") AND url.module EQ #m.name#>selected</cfif>>#m.name#</option>
								</cfloop>
							</select>
						</div>
					</cfif>
					<div class="col-2">
						<select class="form-select border-dark" name="status" id="status" onchange="filter('#url.emp_id#')">
							<option class="dropdown-item" value="">Status</option>
							<option class="dropdown-item" value="1"<cfif structKeyExists(url, "status") AND url.status EQ 1> selected</cfif>>Completed</option>
							<option class="dropdown-item" value="2"<cfif structKeyExists(url, "status") AND url.status EQ 2> selected</cfif>>In-Progress</option>
							<option class="dropdown-item" value="3"<cfif structKeyExists(url, "status") AND url.status EQ 3> selected</cfif>>Re-Opened</option>
							<option class="dropdown-item" value="4"<cfif structKeyExists(url, "status") AND url.status EQ 4> selected</cfif>>R&D</option>
						</select>
					</div>
					<div class="col-2">
						<select class="form-select border-dark" name="req" id="req" onchange="filter('#url.emp_id#')">
							<option class="dropdown-item" value="">Requirement</option>
							<option class="dropdown-item" value="1"<cfif structKeyExists(url, "req") AND url.req EQ "1">selected</cfif>>New</option>
							<option class="dropdown-item" value="3"<cfif structKeyExists(url, "req") AND url.req EQ "3">selected</cfif>>Bug</option>
							<option class="dropdown-item" value="2"<cfif structKeyExists(url, "req") AND url.req EQ "2">selected</cfif>>Manual Error</option>
						</select>
					</div>
					<div class="col-lg-2">
						<cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>
						
						<select class="form-select border-dark" name="assgn" id="assgn" onchange="filter('#url.emp_id#')">
	                        <option class="dropdown-item" value="">Assigned By</option>
	                        <cfloop query="assgnBy">
								<option class="dropdown-item" value="#assgnBy.id#"<cfif structKeyExists(url, "assgn") AND url.assgn EQ "#assgnBy.id#">selected</cfif>>#assgnBy.name#</option>
	                        </cfloop>
	                    </select>
					</div>
				</div>
			</div>

			<!--- listing table --->

			<div class="m-5 my-0">
				<style>
					table{
						border: 5px solid black;
						border-radius: 20px;
					}
				</style>
				<cfset timesheet_array = application.timesheet.filltering(
					fillterByThisOrder = "leaves,weekdays,company_leaves,pending_timesheet",
					emp_id = decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX'),
					FSdate = url.FSdate,
					FEdate = url.FEdate
				)/>
				<table class="table table-striped border-dark table-responsive-sm" style="overflow: hidden;">
					<thead style="background-color:##31394F;">
						<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
							<th>SL.N0</th>
							<th style="width:8%">DATE</th>
							<th style="width: 8%;">PROJECT</th>
							<th style="width:4%">REQUIREMENT</th>
							<th style="width:8%">ASSIGNED BY</th>
							<th style="width: 10%;">MODULE</th>
							<th>DESCRIPTION</th>
							<th style="width:6%">STATUS</th>
							<th style="width:7%">TIME SPENT</th>
							<th style="width:7%">PROD HRS</th>
							<th>ACTION</th>
						</tr>
					</thead>
					<cfset k=1>
					<cfif queryRecordCount(list) GT 0>
						<tbody style="background-color:##FEF7F5">
							<cfset date_unique = [] />
							<cfloop query="list">

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
														<td colspan="11" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
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

								<tr class="text-center" style="font-size:small; vertical-align: middle; height: 50px; ">
									<td>#k#</td>
									<td>#dateFormat(list.start_time,"dd")#<br>#dateFormat(list.start_time,"mmm")#<br>#dateFormat(list.start_time,"yyyy")#</td>

									<td>#list.name#</td>
									<cfif list.type EQ "New">
										<td style="background-color: ##bfd6b8; Color: black">#list.type#</td>
									<cfelseif list.type EQ "Bug">
										<td style="background-color: ##d1b4b9;Color: black">#list.type#</td>
									<cfelseif list.type EQ "Manual Error">
										<td style="background-color: ##e09a7e;Color: black">#list.type#</td>
									<cfelse>
										<td></td>
									</cfif>
									<td>#list.assigned_by_name#</td>
									<td>#list.modules#</td>
									<td style="text-align: justify">#list.description#</td>
									<cfif list.timesheetstatus EQ "In Progress">
										<td style="background-color: ##9491bd;Color: black">#list.timesheetstatus#</td>
									<cfelseif list.timesheetstatus EQ "Completed">
										<td style="background-color:##a1c995;color: Black;">#list.timesheetstatus#</td>
									<cfelseif list.timesheetstatus EQ "Re-opened">
										<td style="background-color:##AFC0E1;color: Black;">#list.timesheetstatus#</td>
									<cfelseif list.timesheetstatus EQ "R&D">
										<td style="background-color:##FEE6DC;color: Black;">#list.timesheetstatus#</td>
									<cfelse>
										<td></td>
									</cfif>
									<td>#timeFormat(list.start_time,"hh:nn tt")# <br>to<br> #timeFormat(list.end_time,"hh:nn tt")#</td>
									<td>#list.productive_hours# Hrs <br> <cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></td>
									<td>
									<!--- edit/delete button --->
									<form method="post" action="./dashboard.cfm?id=#encrypt(id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&##contact"><cfset dateDiff = dateDiff("d", list.created_date,now())>
										<span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="Disabled">
											<button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"<cfif dateDiff GT 1> disabled </cfif> ><i class="bi bi-pencil-square"></i></button>
											<input type="hidden" name="url_data" value='#serializeJSON(URL)#'> 
										</span>
									</form>

									</td>
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
															<td colspan="11" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
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
							</cfloop>
						</tbody>
					<cfelse>
						<tfoot>
							<tr>
								<td colspan="12" class="text-center"><h3 class="my-5">No Records Found!</h3></td>
							</tr>
						</tfoot>	
					</cfif>
				</table>
			</div>
		</cfoutput>
		<script>
			function filter(Uid){
				var FSdate = document.getElementById("filter_start_Date").value;
				var FEdate = document.getElementById("filter_end_Date").value;
				var project = document.getElementById("project").value;
				var status = document.getElementById("status").value;
				var req = document.getElementById("req").value;
				var assgn = document.getElementById("assgn").value;
				<cfif structKeyExists(url, "project") AND url.project NEQ "">
					var mod = document.getElementById("module").value;
					location.href="listing.cfm?emp_id="+Uid+"&year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module="+mod+"&status="+status+"&req="+req +"&assgn="+assgn;
				<cfelse>
					location.href="listing.cfm?emp_id="+Uid+"&year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module=&status="+status+"&req="+req +"&assgn="+assgn;
				</cfif>
			}
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