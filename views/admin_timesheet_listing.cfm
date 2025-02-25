<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    
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
	      	.tag .remove {
     			margin-left: 5px;
      			color: #333;
      			cursor: pointer;
              /*display: none;*/
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
              	padding: 0px 258px 10px 44px;
              	margin-top:18px;
            }
            .custom-btn {
	          	background: #fff;
		        color: #7d66e3;
		        border: 1px solid #7d66e3;
		        border-radius: 5px;
		        text-decoration: none;
		        width:150px;
		        padding: 4px;
	            justify-content:center;
		    }
		    .custom-btn:hover {
		        background: #7d66e3;
		        color: #fff;
            }
            /* Style for the custom dropdown */
			.custom-dropdown .dropdown-menu {
			    max-height: 200px; /* Limit the height of the dropdown for scrolling */
			    overflow-y: auto;  /* Enable vertical scrolling if items exceed max height */
			    padding: 10px;     /* Add padding around the items */
			    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Add a subtle shadow for depth */
			}

			/* Align the checkboxes and labels */
			.custom-dropdown .form-check-input {
			    margin-right: 10px; /* Add spacing between checkbox and label */
			    cursor: pointer;    /* Change cursor to pointer for interactivity */
			}

			/* Style each list item in the dropdown */
			.custom-dropdown li {
			    display: flex;          /* Align items horizontally */
			    align-items: center;    /* Center vertically */
			    padding: 5px 0;         /* Add spacing between items */
			}

			/* Button style for the dropdown */
			.custom-dropdown button {
			    text-align: left;             /* Align text to the left */
			    border: 1px solid #ced4da;    /* Add a border to match Bootstrap styling */
			    background-color: #fff;       /* White background */
			    color: #495057;               /* Standard text color */
			    padding: 6px;                /* Add padding inside the button */
			    font-size: 16px;              /* Font size for readability */
			    border-radius: 4px;           /* Rounded corners */
			    box-shadow: none;             /* Remove Bootstrap default shadow */
			}

			/* Change button appearance on hover */
			.custom-dropdown button:hover {
			    background-color: #f8f9fa;    /* Light gray background on hover */
			    color: #343a40;               /* Darker text color */
			}

			/* Style for selected dropdown button when active */
			.custom-dropdown .dropdown-toggle::after {
			    content: ''; /* Remove default arrow icon */
			    display: inline-block;
			    margin-left: 0.5rem;
			    vertical-align: middle;
			    width: 0;
			    height: 0;
			    border-style: solid;
			    border-width: 0.4em 0.4em 0 0.4em;
			    border-color: transparent transparent transparent #495057;
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;
			}

			/* Scrollbar styling (optional for modern browsers) */
			.custom-dropdown .dropdown-menu::-webkit-scrollbar {
			    width: 8px;
			}

			.custom-dropdown .dropdown-menu::-webkit-scrollbar-thumb {
			    background-color: #adb5bd; /* Gray color for scrollbar thumb */
			    border-radius: 4px;        /* Rounded edges */
			    justify-content:right; /* Set scrollbar width */
			}

			.custom-dropdown .dropdown-menu::-webkit-scrollbar-thumb:hover {
			    background-color: #6c757d; /* Darker gray on hover */
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
    <!-- Template Main CSS File -->
    	<link rel="stylesheet" type="text/css" href="assets/css/style.css">
		<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>

<body>
	<cfoutput>
		<cfif NOT structKeyExists(session, "employee")>
			<cflocation url="logout.cfm">
		</cfif>
		

<cfif structKeyExists(url, "emp_id") AND url.emp_id NEQ "">
	<!--- <cfinvoke component="models.timesheet" emp_id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" method="getEmployeesDetails" returnvariable="employeeDetails"/> --->
<cfelse>
	<cfinvoke component="models.timesheet" method="getEmployeesDetails" returnvariable="employeeDetails"/>
</cfif>

<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
<cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
<cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>
        <!--- header --->
	<cfset print="admin_dashboard_print">
	<cfset active_status="employee_management">
	<cfinclude template="../includes/header/admin_header.cfm" runonce="true">
<!--- header ends --->
<cfinvoke component="models.timesheet" method="getTimesheetEmployees" returnvariable="employeeList"/>

<cfif structKeyExists(url, "emp_id") AND structKeyExists(url, "FSdate") AND structKeyExists(url, "FEdate") AND url.FEdate NEQ "" AND url.FEdate NEQ "">
        <!--- <div class="card shadow p-3 alert alert-warning" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
        	<center><h3><strong>TIME SHEET<span>&nbsp;[#dateFormat(url.FSdate,"d-mmm-yy")#&nbsp; TO &nbsp;#dateFormat(url.FEdate,"d-mmm-yy")#]</span></strong></h3></center>
        </div> --->
        <div class="section-title pt-5 mt-5 " role="alert">
        	<h2 class="mt-5">Employee Management</h2>
        	<p>TIME SHEET<span>&nbsp;[ #dateFormat(url.FSdate,"mmm-dd-yy")#&nbsp; TO &nbsp;#dateFormat(url.FEdate,"mmm-dd-yy")# ]</span></p>
    	</div>
    <cfelse>
    	<div class="section-title pt-5 mt-5 " style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
    		<h2 class="mt-5">Employee Management</h2>
        	<center><h3><strong>TIME SHEET</strong></h3></center>
        </div>
    	<!--- <div class="card shadow p-3 alert alert-warning" style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
        	<center><h3><strong>TIME SHEET</strong></h3></center>
        </div> --->
</cfif>
 <div class="row mt-5 me-5" style="margin-right: 2rem !important;">
       <div class="col-6"></div>
          <div class="col-6 d-flex justify-content-end">
                <!--- <a class="d-flex custom-btn btn-sm me-2" href="add_user.cfm" role="button">New Employee</a> --->
                <a class="d-flex custom-btn btn-sm me-2" href="task_listing.cfm" role="button">Update Timesheet</a>
                <!--- <a class="d-flex custom-btn btn-sm me-2" href="all_employee_details.cfm" role="button">Employee List</a> --->
                <!--- <form action="../views/resigned_employee_list.cfm" method="post"> --->
                <!--- <div style="margin-left: 53%; margin-top:-5%" class="mb-5 pb-5"> --->
                <!--- <a class="d-flex custom-btn btn-sm me-1" type="submit" href="resigned_employee_list.cfm">Resigned Employees</a> --->
                <!--- </div> --->
              <!--- </form>  --->
          </div>
    </div>
<!--- timesheet filter --->
        <div class="shadow card m-5 mt-3">
         <div class="ms-4 mt-3 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
            <label>TIMESHEET</label>
         </div>
        <hr>
        <div id="overlay" style="display: none;"></div>
  	 	<div id="loader" style="display: none;">
            <img src="../assets/img/loader.gif" width="50" height="50" alt="Loading...">
        </div>
        <div class="mx-5">
        	<div class="row my-4">
        		<!--- <div class="col-lg-2"></div> --->
        		<div class="col-lg-3">
        			<label for="admin_filter_start_Date">Start Date</label>
					<input type="date" class="form-control border-dark" name="admin_filter_start_Date" id="admin_filter_start_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "FSdate") AND url.FSdate NEQ  ""> value="#URL.FSdate#"</cfif>>
				</div>
				
				<div class="col-lg-3">
					<label for="admin_filter_end_Date">End Date</label>
					<input type="date" class="form-control border-dark" name="admin_filter_end_Date" id="admin_filter_end_Date" onchange="filter('#url.emp_id#')"<cfif structKeyExists(url, "FEdate") AND url.FEdate NEQ ""> value="#URL.FEdate#"</cfif>>
				</div>
				<cfif structKeyExists(url, "emp_id") AND len(trim(url.emp_id))>
				    <cfset all_emp_id = [] />
				    <cfloop list="#url.emp_id#" index="item" delimiters=",">
				        <cfset arrayAppend(all_emp_id, decrypt(item, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')) />
				    </cfloop>
				<cfelse>
				    <cfset all_emp_id = [] />
				</cfif>
				<div class="col-lg-3">
				    <label for="custom-dropdown-employee">Choose Employee</label>
				    <div class="dropdown custom-dropdown">
				        <button class="dropdown-toggle-item w-100 border-dark show-selected-tags" type="button" id="dropdownMenuButtonEmployee" data-bs-toggle="dropdown" aria-expanded="false">
				            All Employees
				        </button>
				        <ul class="dropdown-menu w-100 all-employees-dropdown" aria-labelledby="dropdownMenuButtonEmployee">
				        	 <!--- <cfloop query="#employeeList#"> --->
				            <li>
				                <input type="checkbox" class="form-check-input" id="all-employees-checkbox" value="all">
				                <label class="form-check-label border-dark" for="all-employees-checkbox" >All Employees</label>
				            </li>
				            <!--- </cfloop> --->
				            <cfloop query="#employeeList#">
				            <li>
				                <input type="checkbox" class="form-check-input emp-checkbox" id="emp-checkbox-#employeeList.id#" value="#encrypt(employeeList.id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" 
				                <cfif arrayFindNoCase(all_emp_id, employeeList.id)> checked </cfif>>
				                <label class="form-check-label" for="emp-checkbox-#employeeList.id#">#employeeList.first_name#</label>
				            </li>
				            </cfloop>
				        </ul>
				    </div>
				</div>
				<div class="col-lg-3">
					<cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>
					<label for="assgn">Assigned By</label>
					<select class="form-select border-dark show-selected-tags" name="assgn" id="assgn" onchange="filter()">
                        <option class="dropdown-item" value="">Assigned By</option>
                        <cfloop query="assgnBy">
							<option class="dropdown-item" value="#assgnBy.id#"<cfif structKeyExists(url, "assgn") AND url.assgn EQ "#assgnBy.id#">selected</cfif>>#assgnBy.first_name# #assgnBy.last_name#</option>
                        </cfloop>
                    </select>
				</div>
			</div>
			<div class="row my-4">
				<!--- <cfif structKeyExists(url, "project") AND url.project EQ "">
					<div class="col-2"></div>
				</cfif> --->
				<div class="col-lg-3">
					<label for="project">Project</label>
					<select class="form-select border-dark show-selected-tags" name="project" id="project" onchange="filter(); onProjectChange(this.value);" >
						<cfinvoke component="models.timesheet" method="getAllProject" returnvariable="projectList"/>
                        <option class="dropdown-item" value="">Project</option>
                        <cfloop query="projectList">
                            <option class="dropdown-item" value="#projectList.id#" <cfif structKeyExists(url, "project") AND url.project EQ projectList.id> selected</cfif>>#projectList.name#</option>
                        </cfloop>
                    </select>
				</div>
				<!--- <cfif structKeyExists(url, "project") AND url.project NEQ ""> --->
					<div class="col-lg-3">
					<cfinvoke  component="models.timesheet" method="modulelist" returnvariable="m" pro_id="#structKeyExists(url, 'project') AND url.project GTE 1 ? url.project : 0#"/>
					<label for="module">Module</label>
						<select class="form-select border-dark show-selected-tags" name="module" id="module" onchange="filter()" disabled>
	                        <option class="dropdown-item" value="">Module</option>
	                        <cfloop query="m">
                               	<option class="dropdown-item" value="#m.name#"<cfif structKeyExists(url, "module") AND url.module EQ #m.name#>selected</cfif>>#m.name#</option>
                                </cfloop>
	                    </select>
					</div>
				<!--- </cfif> --->
				    <div class="col-lg-3">
					<label for="status">Status</label>
						<select class="form-select border-dark show-selected-tags" name="status" id="status" onchange="filter()">
	                        <option class="dropdown-item" value="">Status</option>
	                        <option class="dropdown-item" value="1"<cfif structKeyExists(url, "status") AND url.status EQ 1> selected</cfif>>Completed</option>
	                        <option class="dropdown-item" value="2"<cfif structKeyExists(url, "status") AND url.status EQ 2> selected</cfif>>In-Progress</option>
	                        <option class="dropdown-item" value="3"<cfif structKeyExists(url, "status") AND url.status EQ 3> selected</cfif>>Re-Opened</option>
	                        <option class="dropdown-item" value="4"<cfif structKeyExists(url, "status") AND url.status EQ 4> selected</cfif>>R&D</option>
	                    </select>
				</div>
				<div class="col-lg-3">
					<label for="req">Requirement</label>
					<select class="form-select border-dark show-selected-tags" name="req" id="req" onchange="filter()">
                        <option class="dropdown-item" value="">Requirement</option>
                        <option class="dropdown-item" value="1"<cfif structKeyExists(url, "req") AND url.req EQ "1">selected</cfif>>New</option>
                        <option class="dropdown-item" value="3"<cfif structKeyExists(url, "req") AND url.req EQ "3">selected</cfif>>Bug</option>
                        <option class="dropdown-item" value="2"<cfif structKeyExists(url, "req") AND url.req EQ "2">selected</cfif>>Manual Error</option>
                    </select>
				</div>
				<!--- <div class="col-lg-3">
					<cfinvoke  component="models.timesheet" method="getAllAssignedBy" returnvariable="assgnBy"/>
					<label for="assgn">Assigned By</label>
					<select class="form-select border-dark show-selected-tags" name="assgn" id="assgn" onchange="filter()">
                        <option class="dropdown-item" value="">Assigned By</option>
                        <cfloop query="assgnBy">
							<option class="dropdown-item" value="#assgnBy.id#"<cfif structKeyExists(url, "assgn") AND url.assgn EQ "#assgnBy.id#">selected</cfif>>#assgnBy.first_name# #assgnBy.last_name#</option>
                        </cfloop>
                    </select>
				</div> --->
			</div>
		</div>
		 <div class="row selected-filter ">
	             	<div id="selected-count" class="col-2 selected-count">Filter's Selected:0</div>
	             	<div class="col-1 clear-all" onclick="clearAll()">Clear All</div>
	             	<div id="selected-tags" class="col-9 selected-tags "></div>
	             	<!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
	             	<!--- <div id="selected-tags" class="col-2 selected-tags"></div> --->
			   </div>	
<!--- listing table --->

		<div class="m-5 my-0">
			<style>
				table{
					border: 5px solid black;
					border-radius: 20px;

				}
			</style>

			<cfif structKeyExists(url, "emp_id") AND url.emp_id EQ "">
				<cfset km=0>
				<cfloop query="employeeList">
					<cfif structKeyExists(URL, "today")>
						<cfinvoke component="models.timesheet" today="1" method="getdetails" p1=#url.project# id="#employeeList.id#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#"  returnvariable="list"/>
					<cfelse>
						<cfinvoke component="models.timesheet" method="getdetails" p1=#url.project# id="#employeeList.id#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#" returnvariable="list"/>
					</cfif>

					<cfif queryRecordCount(list) GT 0>
						<center><div class="p-2 text-center alert alert-warning rounded-top mb-2" style="width:500px;"><h6><b>#ucase(employeeList.first_name)# #ucase(employeeList.last_name)#</b></h6></div></center>
						<table class="table table-striped border-dark" style="overflow: hidden;">
							<thead style="background-color:##31394F;">
								<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
									<th style="width:1%">##</th>
									<th style="width:4%">DATE</th>
									<th style="width:8%">TASK ID</th>
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
							<cfset km++>
							<cfset timesheet_array = application.timesheet.filltering(
								fillterByThisOrder = "leaves,weekdays,company_leaves,pending_timesheet",
								emp_id = employeeList.id,
								FSdate = url.FSdate,
								FEdate = url.FEdate
							)/>
							<tbody style="background-color:##FEF7F5">
								<cfset date_unique = [] />
								<cfloop query="list">
									<cfinvoke component="models.timesheet" method="getTotalWorkedHours" taskId="#list.task_id#" emp_id="#list.emp_id#" returnvariable="gethours">
										<!--- <cfdump var="#gethours#"><cfabort> --->
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
											<span style="color: ##666666;">Work Hrs : #list.productive_hours# Hrs <cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></span><br>

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
										<td>#list.assigned_by_first_name# #list.assigned_by_last_name#</td>
										<cfif list.taskDescription NEQ "">
											<td style="text-align: justify; background-color:##fce9e3;">#list.taskDescription#</td>
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
										<td>#timeFormat(list.start_time,"hh:nn tt")#<br>to<br>#timeFormat(list.end_time,"hh:nn tt")#</td>
											<td>#list.productive_hours# Hrs<br><cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></td>
										<td>
			<!--- edit/delete button --->
											<form method="post" action="./admin_dashboard.cfm?id=#encrypt(id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&##update_timesheet">									
											<cfset dateDiff = dateDiff("d", list.created_date,now())>
												<span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip">
					  	 						<button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"><i class="bi bi-pencil-square"></i></button> 
						  	 					</span>
						  	 					<input type="hidden" name="url_data" value='#serializeJSON(URL)#'>
					  	 					</form>
					  	 				</td>
									</tr>
									<cfif queryRecordCount(list) EQ k>
										<cfif dateFormat(url.FEdate) NEQ dateFormat(list.start_time)>
											<cfloop  from="#parseDateTime(dateFormat(list.start_time,"mmm-dd-yyyy"))#" to="#parseDateTime(dateFormat(url.FEdate,"mmm-dd-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
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
					</cfif>
				</cfloop>
				<cfif structKeyExists(URL, "today") AND km EQ 0>
                    <table class="table border-dark" style="overflow: hidden;">
						<thead style="background-color:##31394F;">
							<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 10px;">
							<th style="width:1%">##</th>
							<th style="width:4%">DATE</th>
							<th style="width:8%">TASK ID</th>
							<th style="width:4%;">PROJECT</th>
							<th style="width:4%;">MODULE</th>
							<th style="width:6%">TYPE</th>
							<th style="width:6%">ASSIGNER</th>
							<th>SCOPE</th>
							<th>DESCRIPTION</th>
							<th style="width:6%">STATUS</th>
							<th style="width:7%">TIME SPENT</th>
							<th style="width:7%">PROD HRS</th>
							<th>ACTION</th>
							</tr>
						</thead>
					<center><div><tr><td colspan="13" class="text-center"><h3 class="my-5">No Records Found!</h3></td></tr> </div></center>
				<cfelseif km EQ 0>
					<table class="table border-dark" style="overflow: hidden;">
					    <thead style="background-color:##31394F;">
							<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 10px;">
							<th style="width:1%">##</th>
							<th style="width:4%">DATE</th>
							<th style="width:8%">TASK ID</th>
							<th style="width:4%;">PROJECT</th>
							<th style="width:4%;">MODULE</th>
							<th style="width:6%">TYPE</th>
							<th style="width:6%">ASSIGNER</th>
							<th>SCOPE</th>
							<th>DESCRIPTION</th>
							<th style="width:6%">STATUS</th>
							<th style="width:7%">TIME SPENT</th>
							<th style="width:7%">PROD HRS</th>
							<th>ACTION</th>
							</tr>
						</thead>
					<center><div><tr><td colspan="13" class="text-center"><h3 class="my-5">No Records Found!</h3></td></tr> </div></center>
				</table>
				</cfif>
			<cfelse>
				<cfloop list="#url.emp_id#" index="item_emp" delimiters=",">
					<cfinvoke component="models.timesheet" emp_id="#decrypt(item_emp, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" method="getEmployeesDetails" returnvariable="employeeDetails"/>
					<!--- <cfdump var="#item_emp#"> --->
					<center>
						<div class="p-2 text-center alert alert-warning rounded-top mb-2" style="width:500px;">
							<h6><b>#ucase(employeeDetails.first_name)# #ucase(employeeDetails.last_name)#</b></h6>
						</div>
					</center>
					<!--- <cfdump var="#url#"> --->
					<cfinvoke component="models.timesheet" method="getdetails" p1=#url.project# id="#decrypt(item_emp, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" FSdate="#url.FSdate#" FEdate="#url.FEdate#" module="#url.module#" status="#url.status#" req="#url.req#" assgn="#url.assgn#" argumentcollection="#form#" returnvariable="list"/>
					<table class="table table-striped border-dark" style="overflow: hidden;">
						<thead style="background-color:##31394F;">
							<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
							<th style="width:1%">##</th>
							<th style="width:4%">DATE</th>
							<th style="width:8%">TASK ID</th>
							<th style="width:4%;">PROJECT</th>
							<th style="width:4%;">MODULE</th>
							<th style="width:6%">TYPE</th>
							<th style="width:6%">ASSIGNER</th>
							<th>SCOPE</th>
							<th>DESCRIPTION</th>
							<th style="width:6%">STATUS</th>
							<th style="width:7%">TIME SPENT</th>
							<th style="width:7%">PROD HRS</th>
							<th>ACTION</th>
							</tr>
						</thead>
						<cfset k=1>
						<cfset timesheet_array = application.timesheet.filltering(
							fillterByThisOrder = "leaves,weekdays,company_leaves,pending_timesheet",
							emp_id = decrypt(item_emp, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX'),
							FSdate = url.FSdate,
							FEdate = url.FEdate
						)/>
						<cfif queryRecordCount(list) GT 0>
							<tbody style="background-color:##FEF7F5">
								<cfset date_unique = [] />
								<cfset cumulativeWorkedMinutes = structNew() />
								<cfloop query="list">
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
										    <span style="color: ##666666;">Assigned : #dateformat(list.assigned_on, 'dd-mmm-yy')#</span><br>
											<span style="color: ##666666;">ETA Date : #dateformat(list.deliverBefore, 'dd-mmm-yy')#<br>ETA Hours : #list.estimatedHours# Hr(s)</span><br>
											<span style="color: ##666666;">Work Hrs : #list.productive_hours# Hrs <cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></span><br>

											<cfset taskId = list.task_id>
										    <cfset totalWorkedMinutes = (list.productive_hours * 60) + list.productive_mins>
										    <cfif NOT structKeyExists(cumulativeWorkedMinutes, taskId)>
										        <cfset cumulativeWorkedMinutes[taskId] = totalWorkedMinutes>
										    <cfelse>
										        <cfset cumulativeWorkedMinutes[taskId] = cumulativeWorkedMinutes[taskId] + totalWorkedMinutes>
										    </cfif>
										    <cfset cumulativeHours = int(cumulativeWorkedMinutes[taskId] / 60)>
										    <cfset cumulativeMinutes = cumulativeWorkedMinutes[taskId] mod 60>
										    <cfif NOT (cumulativeHours EQ list.productive_hours AND list.productive_mins EQ cumulativeMinutes)>
											    <span style="color: ##666666;">Total Hrs : 
									                #cumulativeHours# Hr(s) 
									                #cumulativeMinutes# Min(s)
									            </span>
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
										</cfif>
										<td>#list.assigned_by_first_name# #list.assigned_by_last_name#</td>
										<cfif list.taskDescription NEQ "">
											<td style="text-align: justify; background-color:##fce9e3;">#list.taskDescription#</td>
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
										<td>#timeFormat(list.start_time,"hh:nn tt")#<br>to<br>#timeFormat(list.end_time,"hh:nn tt")#</td>
										<td>#list.productive_hours# Hrs<br><cfif list.productive_mins GT 0>#list.productive_mins# Mins<cfelse>0 Min</cfif></td>
										<td>
										<!--- edit/delete button --->
										<!--- <cfdump var="#id#"> --->
										<form method="post" action="./admin_dashboard.cfm?id=#encrypt(id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#&##update_timesheet">
											<cfset dateDiff = dateDiff("d", list.created_date,now())>
											<span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip">
											<button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"><i class="bi bi-pencil-square"></i></button> 
											</span>
											<input type="hidden" name="url_data" value='#serializeJSON(URL)#'>
										</form>
										</td>
									</tr>
									<cfif queryRecordCount(list) EQ k>
										<cfif dateFormat(url.FEdate) NEQ dateFormat(list.start_time)>
											<cfloop  from="#parseDateTime(dateFormat(list.start_time,"mmm-dd-yyyy"))#" to="#parseDateTime(dateFormat(url.FEdate,"mmm-dd-yyyy"))#" index="DL" step="#createTimespan(1, 0, 0, 0)#">
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
				</cfloop>
			</cfif>
		</div>
	</div>
	</cfoutput>
	<script>
		function filter() {
		    var FSdate = document.getElementById("admin_filter_start_Date").value;
		    var FEdate = document.getElementById("admin_filter_end_Date").value;
		    var project = document.getElementById("project").value;
		    document.getElementById("loader").style.display = 'block';
            document.getElementById("overlay").style.display = 'block';
		    // Get all selected employee IDs
		    var emp_id = Array.from(document.querySelectorAll(".emp-checkbox:checked"))
		        .map(checkbox => checkbox.value)
		        .join(",");
		    var status = document.getElementById("status").value;
		    var req = document.getElementById("req").value;
		    var assgn = document.getElementById("assgn").value;
		<cfif structKeyExists(url, "project") AND url.project NEQ "">
		if(project!=""){
			var mod = document.getElementById("module").value;
			}
			else{
				var mod = "";
			}
			var FSD= new Date(FSdate) 
			var FSM = FSD.getMonth()+1;
			var FED= new Date(FEdate) 
			var FEM = FED.getMonth()+1;
			if (FSM==FEM) {
				location.href="admin_timesheet_listing.cfm?year=&month="+FSM+"&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module="+mod+"&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+emp_id;
			}
			else {
				location.href="admin_timesheet_listing.cfm?year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module="+mod+"&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+emp_id;
			}
				
		<cfelse>
			var FSD= new Date(FSdate) 
			var FSM = FSD.getMonth()+1;
			var FED= new Date(FEdate) 
			var FEM = FED.getMonth()+1;
			if (FSM==FEM) {
				location.href="admin_timesheet_listing.cfm?year=&month="+FEM+"&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module=&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+emp_id;
			}
			else {
				location.href="admin_timesheet_listing.cfm?year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module=&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+emp_id;
			}
		</cfif>

		}
		function getEmp(field){
			let emp_id = field.value;
			let values = [...field.options].filter(option => option.selected).map(option => option.value).join(",");
			var FSdate = document.getElementById("admin_filter_start_Date").value;
			var FEdate = document.getElementById("admin_filter_end_Date").value;
			var project = document.getElementById("project").value;
			var status = document.getElementById("status").value;
			var req = document.getElementById("req").value;
			var assgn=document.getElementById("assgn").value;
			<cfif structKeyExists(url, "project") AND url.project NEQ "">
			
				var mod = document.getElementById("module").value;
			
				var FSD= new Date(FSdate) 
				var FSM = FSD.getMonth()+1;
				var FED= new Date(FEdate) 
				var FEM = FED.getMonth()+1;
				if (FSM==FEM) {
					location.href="admin_timesheet_listing.cfm?year=&month="+FSM+"&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module="+mod+"&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+values;
				}
				else {
					location.href="admin_timesheet_listing.cfm?year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module="+mod+"&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+values;
				}
				
			<cfelse>
			var FSD= new Date(FSdate) 
				var FSM = FSD.getMonth()+1;
				var FED= new Date(FEdate) 
				var FEM = FED.getMonth()+1;
				if (FSM==FEM) {
					location.href="admin_timesheet_listing.cfm?year=&month="+FEM+"&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module=&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+values;
				}
				else {
					location.href="admin_timesheet_listing.cfm?year=&month=&FSdate="+FSdate+"&FEdate="+FEdate+"&project="+project+"&module=&status="+status+"&req="+req+"&assgn="+assgn+"&emp_id="+values;
				}
			
				
			</cfif>
		}
		
		</script>
		<script>
		  function addTag() {
		    const selectedTagsDiv = document.getElementById("selected-tags");
		    const allElements = document.querySelectorAll(".show-selected-tags");

	      allElements.forEach(dropdown => {
	        let valueText = ""; // Declare once for reuse
	        const dropdownId = dropdown.id;

	        if (dropdown.type === "select-one" || dropdown.type === "button") {
	            const selectedValue = $(dropdown).val();
	            if (selectedValue) {
	                const selectedValues = selectedValue.toString().split(",");
	                valueText = selectedValues.map((s) => {
	                    const option = dropdown.querySelector(`option[value="${s}"]`);
	                    return option ? option.innerHTML : "";
	                }).join(", ");
	            }

	            // Handle checkboxes
	            const allInputs = dropdown.parentElement.querySelectorAll(".emp-checkbox");
	            if (allInputs.length) {
	                const arrInputValue = [...allInputs]
	                    .filter(input => input.checked)
	                    .map(input => input.parentElement.querySelector("label").innerHTML);
	                valueText = arrInputValue.join(", ");
	            }
	        } else if (dropdown.type === "date") {
	            // Handle date inputs
	            valueText = dropdown.value ? formatDate(dropdown.value) : "";
	        }

	        // Prevent adding empty or duplicate tags
	        if (!valueText.trim() || Array.from(selectedTagsDiv.children).some(tag => tag.getAttribute("data-dropdown") === dropdownId)) {
	            return;
	        }

	        const labelText = getLabelForDropdown(dropdownId);

	        // Create or update the tag
	        const tag = document.createElement("div");
	        tag.id = `select-tags${dropdown.id}`;
	        tag.className = "tag";
	        tag.setAttribute("data-dropdown", dropdownId);
	        tag.innerHTML = `<strong>${labelText}:</strong>&nbsp;${valueText}<span class="remove" onclick="removeTag(this)">&nbsp;&times;</span>`;

	        const existingTag = document.getElementById(`select-tags${dropdown.id}`);
	        if (existingTag) {
	            if (valueText.trim() !== "") {
	                existingTag.outerHTML = tag.outerHTML;
	            } else {
	                existingTag.remove();
	            }
	        } else if (valueText.trim() !== "") {
	            selectedTagsDiv.appendChild(tag);
	        }

	        showClearAllButton();
	        updateSelectedCount();
	    });
	}

	        function getLabelForDropdown(dropdownId) {
	            switch(dropdownId) {
	                    case "project": return "Project";
	                    case "module": return "Module";
	                    case "status": return "Status";
	                    case "req": return "Requirement";
	                    case "assgn": return "Assigned By";
	                    case "dropdownMenuButtonEmployee": return "Choose Employee";
	                    default: return "Label";
	                }
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
	        const checkboxes = document.querySelectorAll('[id^="emp-checkbox"]');
          	checkboxes.forEach(check => {
            check.checked = false; 
          });

	        // Hide the "Clear All" button after clearing
	        hideClearAllButton();

	        // Update selected count
	        updateSelectedCount();
	        // location.reload();
	        document.getElementById("admin_filter_start_Date").value = new Date().toISOString().split('T')[0];
			console.log(dropdowns[0]);
	        dropdowns[1].dispatchEvent(new Event('change'));
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

	        // Module disabled when project not selected 
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
		        window.addEventListener('DOMContentLoaded',function(){
		        	const projectInput = document.getElementById('project');
		        	onProjectChange(projectInput.value);
		        });
		</script>
		<script>
	         function initializeDropdown() {
		    // console.log("Dropdown initialized");

		    const dropdownEmployee = document.getElementById("dropdownMenuButtonEmployee");
		    const checkboxesEmployee = document.querySelectorAll(".emp-checkbox");
		    const allCheckboxEmployee = document.getElementById("all-employees-checkbox");
		    const allEmployeecheckbox = document.querySelector(".all-employees-dropdown").querySelectorAll("input[type='checkbox']");

		    // Function to update dropdown text based on selected checkboxes
		    function updateEmployeeDropdownText() {
		        const selected = Array.from(checkboxesEmployee)
		            .filter(cb => cb.checked)
		            .map(cb => cb.nextElementSibling.textContent);

		        dropdownEmployee.textContent = selected.length
		            ? selected.join(", ")
		            : "All Employees";
		    }

		    // Function to handle the "Select All" checkbox
		    allCheckboxEmployee.addEventListener("change", function () {
		        const isChecked = this.checked;
		        checkboxesEmployee.forEach(cb => cb.checked = isChecked);
		        updateEmployeeDropdownText();
		        filter();
		    });
		    allEmployeecheckbox.forEach(cb => {
		        cb.addEventListener("click", function () {
		            if (!this.checked) {
		                allCheckboxEmployee.checked = false; // Uncheck "All Employees" if any checkbox is unchecked
		            } else if (Array.from(checkboxesEmployee).every(cb => cb.checked)) {
		                allCheckboxEmployee.checked = true; // Check "All Employees" if all checkboxes are selected
		            }
		            updateEmployeeDropdownText();
		        });
		    });

		    // Function to handle individual checkbox clicks
		    checkboxesEmployee.forEach(cb => {
		        cb.addEventListener("change", function () {
		            if (!this.checked) {
		                allCheckboxEmployee.checked = false; // Uncheck "All Employees" if any checkbox is unchecked
		            } else if (Array.from(checkboxesEmployee).every(cb => cb.checked)) {
		                allCheckboxEmployee.checked = true; // Check "All Employees" if all checkboxes are selected
		            }
		            updateEmployeeDropdownText();
		            filter();
		        });
		    });

		    // Initialize dropdown text on page load
		    updateEmployeeDropdownText();
		}

		// Ensure the function runs after the page is fully loaded
		window.onload = initializeDropdown;
		</script>
		<!-- Vendor JS Files -->
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>
</body>
