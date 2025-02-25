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
			.row{
				margin-right: 100px;
			}
			.status{
				margin-right: px;
			}
			.container{
				display: flex;
				flex-direction: column;
				flex-wrap: wrap;
				justify-content: center;
				gap: 10px;
			}
			.tag .remove {
     			margin-left: 5px;
      			color: #333;
      			cursor: pointer;
    		}
    		.tag {
		        display: inline-flex;
		        align-items: center;
		        background-color: #e0e0e0;
		        padding: 5px 10px;
		        border-radius: 15px;
		        font-size: 14px;
		        color: #333;
		    }
		    .selected-tags {
/*     		 	margin-top: 10px;*/
      			display: flex;
      			flex-wrap: wrap;
      			gap: 10px;
            }
            .clear-all {
				margin-top: 1px;
				color: gray;
				cursor: pointer;
				font-size: 16px;
				display: none;
				text-decoration: underline; /* Hide initially */
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
            .selected-filter {
                padding: 5px 215px 14px 62px;
                margin-top:50px;
            }
            .custom-btn {
		            background: #fff;
		            color: #7d66e3;
		            border: 1px solid #7d66e3;
		            border-radius: 5px;
		            text-decoration: none;
		          }
            .custom-btn:hover {
          			background: #7d66e3;
          			color: #fff;
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
			<cfset encryptId = structKeyExists(url, "employeeid") AND  len(url.employeeid)?url.employeeid: url.emp_id>
			<cfset employeeID= decrypt(encryptId, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')>

			<cfif structKeyExists(url, "p_id")>
				<cfinvoke component="models.timesheet" method="getProject" p1=#url.p_id# emp_id="#employeeID#" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" argumentcollection="#form#" returnvariable="list"/>
			
			<cfelse>
				<cfinvoke component="models.timesheet" method="getdetails" p1=#url.project# emp_id="#employeeID#" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#"  argumentcollection="#form#" returnvariable="list"/>
			</cfif>

			<cfinvoke component="models.timesheet" method="getAllProject" returnvariable="projectList"/>
			<cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
			<cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>
			<!--- header --->
			<cfset print="user_dashboard_print">
			<cfset active_status="more">
			<cfinclude template="../includes/header/user_header.cfm" runonce="true">
			<!--- header ends --->
			<div class="section-title pb-2 pt-5 mt-5 ">
		            <h2 class="mt-5">Employee Management</h2>
		            <p>Timesheet</p>
				<div class="row me-4 mt-3" style="margin-right: 2.5rem !important;">
	              	   <div class="col-10"></div>
	              	     <div class="col-2 mb-1 d-flex justify-content-end">
	                	    	   <a class="btn btn-sm custom-btn" href="task_listing.cfm" role="button">Update Timesheet</a>
	              	     </div>
	            	</div>
                  </div>
			<!--- timesheet filter --->
            <div class="shadow card m-5 mt-1">
            	<div class="ms-4 mt-3 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
            		<label>TIMESHEET</label>
        		</div>
        		<hr>
			<div class="my-5">
				<div class="row py-2 mx-3">

					<div class="col-3">
						<input type="date" class="form-control border-dark" name="filter_start_Date" id="filter_start_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "FSdate") AND url.FSdate NEQ  ""> value="#URL.FSdate#"</cfif>>
					</div>

					<div class="col-3">
						<input type="date" class="form-control border-dark" name="filter_end_Date" id="filter_end_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "FEdate") AND url.FEdate NEQ ""> value="#URL.FEdate#"</cfif>>
					</div>

					<div class="col-3">
						<select class="form-select border-dark show-selected-tags" name="project" id="project-input" onchange="filter('#url.emp_id#',true); onProjectChange(this.value);">
							<option class="dropdown-item" value="">	Project</option>
							<cfloop query="projectList">
								<option class="dropdown-item" value="#projectList.id#" <cfif structKeyExists(url, "project") AND url.project EQ projectList.id> selected</cfif>>#projectList.name#</option>
							</cfloop>
						</select>
					</div>
					<!--- <cfif structKeyExists(url, "project") AND url.project GTE 1> --->
						<div class="col-3">
							<cfinvoke  component="models.timesheet" method="modulelist" returnvariable="m" pro_id="#structKeyExists(url, 'project') AND url.project GTE 1 ? url.project : 0#" />
							<select class="form-select border-dark show-selected-tags" name="module" id="module" onchange="filter('#url.emp_id#',true)" disabled>
								<option class="dropdown-item" value="">Module</option>
								<cfloop query="m">
									<option class="dropdown-item" value="#m.name#"<cfif structKeyExists(url, "module") AND url.module EQ #m.name#>selected</cfif>>#m.name#</option>
								</cfloop>
							</select>
						</div>
					<!--- </cfif> --->
				</div>
					<div class="row py-2 mx-3">
						<div class=" <cfif structKeyExists(session, "employee" )AND val(session.employee.ROLE_ID) EQ 5> 
						col-3 
					<cfelse> col-3
					</cfif> ">
						<select class="form-select border-dark show-selected-tags" name="status" id="status" onchange="filter('#url.emp_id#',true)">
							<option class="dropdown-item" value="">Status</option>
							<option class="dropdown-item" value="1"<cfif structKeyExists(url, "status") AND url.status EQ 1> selected</cfif>>Completed</option>
							<option class="dropdown-item" value="2"<cfif structKeyExists(url, "status") AND url.status EQ 2> selected</cfif>>In-Progress</option>
							<option class="dropdown-item" value="3"<cfif structKeyExists(url, "status") AND url.status EQ 3> selected</cfif>>Re-Opened</option>
							<option class="dropdown-item" value="4"<cfif structKeyExists(url, "status") AND url.status EQ 4> selected</cfif>>R&D</option>
						</select>
					</div>
					<div class="<cfif structKeyExists(session, "employee" )AND val(session.employee.ROLE_ID) EQ 5> col-3 
					<cfelse> col-3
					</cfif> ">
						<select class="form-select border-dark show-selected-tags" name="req" id="req" onchange="filter('#url.emp_id#',true)">
							<option class="dropdown-item" value="">Requirement</option>
							<option class="dropdown-item" value="1"<cfif structKeyExists(url, "req") AND url.req EQ "1">selected</cfif>>New</option>
							<option class="dropdown-item" value="3"<cfif structKeyExists(url, "req") AND url.req EQ "3">selected</cfif>>Bug</option>
							<option class="dropdown-item" value="2"<cfif structKeyExists(url, "req") AND url.req EQ "2">selected</cfif>>Manual Error</option>
						</select>
					</div>
					<div class="<cfif structKeyExists(session, "employee" )AND val(session.employee.ROLE_ID) EQ 5> col-3 
					<cfelse> col-3 
					</cfif> ">
						<cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>
						
						<select class="form-select border-dark show-selected-tags" name="assgn" id="assgn" onchange="filter('#url.emp_id#',true)">
	                        <option class="dropdown-item" value="">Assigned By</option>
	                        <cfloop query="assgnBy">
								<option class="dropdown-item" value="#assgnBy.id#"<cfif structKeyExists(url, "assgn") AND url.assgn EQ "#assgnBy.id#">selected</cfif>>#assgnBy.first_name# #assgnBy.last_name#</option>
	                        </cfloop>
	                    </select>
					</div>
					<cfset titleName = "" />
					<cfif structKeyExists(session, "employee" )AND val(session.employee.ROLE_ID) EQ 5>
						    <div class="col-3">
								<cfinvoke  component="models.timesheet" method="employeelist"  returnvariable="employeeLists"/>
								<!--- <cfdump var="#employeelists#"> --->
								<select class="form-select border-dark show-selected-tags " onchange="filter('#url.emp_id#',true)"  id="employee_id" name="employeeId" >
			                        <option class="dropdown-item" value="">Employees</option>
			                        <cfloop query="employeeLists">
										<option class="dropdown-item" value="#encrypt(employeeLists.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" <cfif structKeyExists(url, "employeeid") AND url.employeeid EQ "#encrypt(employeeLists.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#"><cfset titleName = employeeLists.first_name /> selected </cfif>>#employeeLists.first_name#</option>
			                        </cfloop>
			                    </select>
							</div>
						</cfif>
				</div>
			</div>
			<div class="row selected-filter mt-2">
	             	<div id="selected-count" class="col-2 selected-count">Filter's Selected:0</div>
	             	<div class="col-1 clear-all" onclick="clearAll()">Clear All</div>
					<div id="selected-tags" class="col-9 selected-tags"></div>
			</div>

			<!--- listing table --->

			<div class="m-3 my-0">
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
				<cfif structKeyExists(session, "employee" )AND val(session.employee.ROLE_ID) EQ 5>
					<cfif titleName NEQ "">
						<center> 
							<div  class="p-2 text-center alert alert-warning rounded-top mb-2" id="display_name" style="width:500px;">
								<h6><b>#ucase(titleName)#</b></h6> 
							</div>
						</center>
					</cfif>
			    </cfif>
				<table class="table table-striped border-dark table-responsive-sm" style="overflow: hidden;">
					<thead style="background-color:##31394F;">
						<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
							<th style="width:1%">##</th>
							<th style="width:4%">DATE</th>
							<th style="width:9%">TASK ID</th>
							<th style="width:4%;">PROJECT</th>
							<th style="width:4%;">MODULE</th>
							<th style="width:6%">TYPE</th>
							<th style="width:6%">ASSIGNER</th>
							<th>SCOPE</th>
							<th>DESCRIPTION</th>
							<th style="width:2%">STATUS</th>
							<th style="width:7%">TIME SPENT</th>
							<th style="width:4%">PROD HRS</th>
							<th style="width:2%">ACTION</th>
						</tr>
					</thead>
					<cfset k=1>
					<cfif queryRecordCount(list) GT 0>
						<tbody style="background-color:##FEF7F5">
							<cfset date_unique = [] />
							<cfloop query="list">
								<cfinvoke component="models.timesheet" method="getTotalWorkedHours"  returnvariable="gethours" taskId="#list.task_id#" emp_id="#list.emp_id#">
								<cfif dateFormat(url.FSdate) NEQ dateFormat(list.start_time)>
									<cfloop  from="#parseDateTime(dateFormat(url.FSdate,"mmm-dd-yyyy"))#" to="#parseDateTime(dateFormat(list.start_time,"mmm-dd-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
										<cfif NOT arrayFindNoCase(date_unique,DL)>
											<cfloop array="#timesheet_array#" index="TA">
												<cfif parseDateTime(dateFormat(DL,"mmm-dd-yyyy")) EQ parseDateTime(dateFormat(TA.DATE,"mmm-dd-yyyy"))>
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
																(#dateFormat(TA.DATE,'mmm-dd-yyyy')#)
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
									<td>#dateFormat(list.start_time,"mmm")#<br>#dateFormat(list.start_time,"dd")#<br>#dateFormat(list.start_time,"yyyy")#</td>
									<cfif list.task_id NEQ "">
									<td>
									    <b style="color: ##7d66e3;">#list.task_id#</b><br>
									    <span style="color: ##666666;">Assigned : #dateformat(list.assigned_on, 'mmm-dd-yy')#</span><br>
										<span style="color: ##666666;">ETA Date : #dateformat(list.deliverBefore, 'mmm-dd-yy')#<br>ETA Hours : #list.estimatedHours# Hr(s)</span><br>
										<span style="color: ##666666;">Worked Hrs : #list.productive_hours# Hrs <cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></span><br>
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
									  		<span style="color: ##666666;">Total Hrs:#totalhours# Hr(s) #totalmins# Min(s)</span>
									  	</cfif>
									 </td>
								<cfelse>
									<td>-</td>
									</cfif>
									<td>#list.name#</td>
									<td>#list.modules#</td>
									<cfif list.type EQ "New">
										<td style="background-color: ##bfd6b8; Color: black">#list.type#</td>
									<cfelseif list.type EQ "Bug">
										<td style="background-color: ##d1b4b9;Color: black">#list.type#</td>
									<cfelseif list.type EQ "Manual Error">
										<td style="background-color: ##e09a7e;Color: black">#list.type#</td>
									<cfelse>
										<td></td>
									</cfif>
									<td>#list.assigned_by_first_name#<br>#list.assigned_by_last_name#</td>
									<cfif list.taskDescription NEQ "">
										<td style="text-align: justify; background-color: ##fce9e3;">#list.taskDescription#</td>
									<cfelse>
										<td>-</td>
									</cfif>
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
											<button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"<cfif dateDiff GT 1 OR (structKeyExists(url, "employeeid") AND url.employeeid NEQ "") > disabled </cfif> ><i class="bi bi-pencil-square"></i></button>
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
															<td colspan="13" align="center" style="background-color: #backgroundColor# font-weight: Bold;">
																<span style="font-size:medium;">
																	(#dateFormat(TA.DATE,'mmm-dd-yyyy')#)
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
								<td colspan="14" class="text-center"><h3 class="my-5">No Records Found!</h3></td>
							</tr>
						</tfoot>	
					</cfif>
				</table>
			</div>
		</div>
		</cfoutput>
		<script>
			function filter(Uid,showTag = false){
				if(showTag){
					addTag();
				}
				var FSdate = document.getElementById("filter_start_Date").value;
				var FEdate = document.getElementById("filter_end_Date").value;
				var project = document.getElementById("project-input").value;
				var status = document.getElementById("status").value;
				var req = document.getElementById("req").value;
				var assgn = document.getElementById("assgn").value;
				var employeeId = document.getElementById("employee_id")==null?"":document.getElementById("employee_id").value;
                 console.log(employeeId);
				<cfif structKeyExists(url, "project") AND url.project NEQ "">
					var mod = document.getElementById("module").value;
					location.href="listing.cfm?emp_id="+Uid+"&year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module="+mod+"&status="+status+"&req="+req +"&assgn="+assgn +"&employeeid="+employeeId;
				<cfelse>
					location.href="listing.cfm?emp_id="+Uid+"&year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module=&status="+status+"&req="+req +"&assgn="+assgn +"&employeeid="+employeeId;
				</cfif>
			}
		</script>
		<script>
	    //     function filter(Uid, showTag = false) {
	    //     if (showTag) {
	    //         addTag();
	    //     }
	    //     var FSdate = document.getElementById("filter_start_Date").value;
	    //     var FEdate = document.getElementById("filter_end_Date").value;
	    //     var project = document.getElementById("project-input").value;
	    //     var status = document.getElementById("status").value;
	    //     var req = document.getElementById("req").value;
	    //     var assgn = document.getElementById("assgn").value;
	    //     var employeeId = document.getElementById("employee_id") ? document.getElementById("employee_id").value : "";
	        
	    //     console.log(employeeId);
	        
	    //     if (document.getElementById("module")) {
	    //         var mod = document.getElementById("module").value;
	    //         location.href = `listing.cfm?emp_id=${Uid}&year=&month=&FSdate=${FSdate}&FEdate=${FEdate}&project=${project}&module=${mod}&status=${status}&req=${req}&assgn=${assgn}&employeeid=${employeeId}`;
	    //     } else {
	    //         location.href = `listing.cfm?emp_id=${Uid}&year=&month=&FSdate=${FSdate}&FEdate=${FEdate}&project=${project}&module=&status=${status}&req=${req}&assgn=${assgn}&employeeid=${employeeId}`;
	    //     }
	    // }

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
	                    case "project-input": return "Project";
	                    case "module": return "Module";
	                    case "status": return "Status";
	                    case "req": return "Requirement";
	                    case "assgn": return "Assigned By";
	                    case "employee_id": return "Employees";
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
	         function onProjectChange(selectedValue) {
        		const moduleDropdown = document.getElementById('module');
		        
		          if (selectedValue) {
		            // Enable the Module dropdown if a project is selected
		            moduleDropdown.disabled = false;
		        } else {
		            // Reset and disable the Module dropdown if no project is selected
		            moduleDropdown.value = "";
		            moduleDropdown.disabled = true;
		        }
		    }

		    // Ensure the initial state matches the current project selection on page load
		    window.addEventListener('DOMContentLoaded', function () {
		        const projectInput = document.getElementById('project-input');
		        onProjectChange(projectInput.value);
		    });
		    function formatDate(input) {
			    let dateValue = input.value;
			    if (dateValue) {
			        let [year, month, day] = dateValue.split("-");
			        let formattedDate = `${month}-${day}-${year}`;
			        console.log("Selected Date (MM-DD-YYYY):", formattedDate);
			    }
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