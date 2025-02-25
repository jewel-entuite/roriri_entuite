<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="style.css">
    <title>RORIRI -Employee Management</title>
    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
    <!-- Template Main CSS File -->
        <link href="assets/css/style.css" rel="stylesheet">
		<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">

</head>

<body>
	<cfoutput>
		<cfif NOT structKeyExists(session, "USER")>
			<cflocation url="logout.cfm">
		</cfif>
<!--- <cfdump var="#session.USER.ROLE#" abort> --->
		<cfif structKeyExists(url, "p_id")>
				<cfinvoke component="../models/login" method="getProject" p1=#url.p_id# id="#url.userid#" argumentcollection="#form#" returnvariable="list"/>
			<cfelse>
				<cfinvoke component="../models/login" method="getdetails" id="#url.userid#" argumentcollection="#form#" returnvariable="list"/>
			</cfif>
<!--- header --->

		<header id="header" class="fixed-top d-flex align-items-center">
            <div class="container d-flex align-items-center justify-content-between">
                <div class="logo">
                    <h1 class="text-light"><a href="listing.cfm"><span><img class="img-fluid" src="../images/logo.jpeg" alt="" width="40" height="40"></span></a></h1>
                </div>
    <!--- navbar --->
                <nav id="navbar" class="navbar">
                    <ul>
                        <li>
                        	<cfif structKeyExists(session, "USER") AND session.USER.ROLE EQ "1">
                        		<a class="nav-link scrollto active" href="admin_dashboard.cfm">Home</a>
                        	<cfelse>
                        		<a class="nav-link scrollto active" href="dashboard.cfm">Home</a>
                        	</cfif>
                        </li>
                        <!--- <li class="dropdown"><a href="">Projects<i class="bi bi-chevron-down"></i></a>
                            <ul>
                                <li><a href="listing.cfm?p_id=1&userid=#url.userid#">VCCS</a></li>
                                <li><a href="listing.cfm?p_id=2&userid=#url.userid#">Maurya CRM</a></li>
                                <li><a href="listing.cfm?&userid=#url.userid#">All</a></li>
                            </ul>
                        </li> --->

                        <!--- <li><cfif structKeyExists(url, "userid")>
                        		<cfif structKeyExists(url, "p_id")>
                        			<a class="nav-link scrollto active" href="./reports/timesheet_individual_report.cfm?userid=#url.userid#&p_id=#url.p_id#">Print</a>
                        		<cfelse>
                        			<a class="nav-link scrollto active" href="./reports/timesheet_individual_report.cfm?userid=#url.userid#">Print</a>
                        		</cfif>
                        	<cfelse>
                        		<a class="nav-link scrollto active" href="./reports/timesheet_individual_report.cfm">Print</a>
                        	</cfif>
                        </li> --->
                        <li>
                        	<cfif structKeyExists(session, "USER") AND session.USER.ROLE EQ "1">
                        		<a class="getstarted scrollto" href="admin_dashboard.cfm">Back</a>
                        	<cfelse>
                        		<a class="getstarted scrollto" href="dashboard.cfm">Back</a>
                        	</cfif>
                        </li>
                    </ul>
                    <i class="bi bi-list mobile-nav-toggle"></i>
                </nav>
    <!--navbar ends -->
            </div>
        </header>
    </cfoutput>
        <div class="p-2 text-center" style="margin-top:75px; background-color:##e3a388;">
        	<center><h1>Daily Attendance</h1></center>
        </div>

<!--- timesheet filter --->

        <div class="container my-5">
        	<div class="row">
        		<!--- <div class="col-2">
	        			<cfset curr_year = year(now())>
						<cfset prev_year = curr_year-1>
						<cfset next_year = curr_year+1>
						<select class="form-select border-dark" name="year" id="year" onchange="filter(#url.userid#)">
	                        <option class="dropdown-item" value="">Year</option>
	                        <option class="dropdown-item" value="#curr_year#"<cfif structKeyExists(url, "year") AND url.year EQ #curr_year#> selected</cfif>>Current Year</option>
	                        <option class="dropdown-item" value="#prev_year#"<cfif structKeyExists(url, "year") AND url.year EQ #prev_year#> selected</cfif>>Previous Year</option>
	                        <option class="dropdown-item" value="#next_year#"<cfif structKeyExists(url, "year") AND url.year EQ #next_year#> selected</cfif>>Next Year</option>
	                    </select>
				</div>
        		<div class="col-2">
					<select class="form-select border-dark" name="month" id="month" onchange="filter(#url.userid#)">
                        <option class="dropdown-item" value="">Month</option>
                        <option class="dropdown-item" value="1"<cfif structKeyExists(url, "month") AND url.month EQ 1> selected</cfif>>January</option>
                        <option class="dropdown-item" value="2"<cfif structKeyExists(url, "month") AND url.month EQ 2> selected</cfif>>February</option>
                        <option class="dropdown-item" value="3"<cfif structKeyExists(url, "month") AND url.month EQ 3> selected</cfif>>March</option>
                        <option class="dropdown-item" value="4"<cfif structKeyExists(url, "month") AND url.month EQ 4> selected</cfif>>April</option>
                        <option class="dropdown-item" value="5"<cfif structKeyExists(url, "month") AND url.month EQ 5> selected</cfif>>May</option>
                        <option class="dropdown-item" value="6"<cfif structKeyExists(url, "month") AND url.month EQ 6> selected</cfif>>June</option>
                        <option class="dropdown-item" value="7"<cfif structKeyExists(url, "month") AND url.month EQ 7> selected</cfif>>July</option>
                        <option class="dropdown-item" value="8"<cfif structKeyExists(url, "month") AND url.month EQ 8> selected</cfif>>August</option>
                        <option class="dropdown-item" value="9"<cfif structKeyExists(url, "month") AND url.month EQ 9> selected</cfif>>September</option>
                        <option class="dropdown-item" value="10"<cfif structKeyExists(url, "month") AND url.month EQ 10> selected</cfif>>October</option>
                        <option class="dropdown-item" value="11"<cfif structKeyExists(url, "month") AND url.month EQ 11> selected</cfif>>November</option>
                        <option class="dropdown-item" value="12"<cfif structKeyExists(url, "month") AND url.month EQ 12> selected</cfif>>December</option>
                    </select>
				</div>
				<div class="col-2">
					<select class="form-select border-dark" name="project" id="project" onchange="filter(#url.userid#)">
                        <option class="dropdown-item" value="">Project</option>
                        <option class="dropdown-item" value="1"<cfif structKeyExists(url, "project") AND url.project EQ 1>selected</cfif>>VCCS</option>
                        <option class="dropdown-item" value="2"<cfif structKeyExists(url, "project") AND url.project EQ 2>selected</cfif>>MCRM</option>
                    </select>
				</div>
				<cfif structKeyExists(url, "project") AND url.project GTE 1>
					<div class="col-2">
					<cfinvoke  component="../models/login" method="modulelist" returnvariable="m" pro_id="#url.project#"/>
						<select class="form-select border-dark" name="module" id="module" onchange="filter(#url.userid#,this.value)">
	                        <option class="dropdown-item" value="">Module</option>
	                        <cfloop query="m">
                               	<option class="dropdown-item" value="#m.module_name#"<cfif structKeyExists(url, "module") AND url.module EQ #m.module_name#> selected</cfif>>#m.module_name#</option>
                                </cfloop>
	                    </select>
					</div>
				</cfif>
				<div class="col-2">
						<select class="form-select border-dark" name="status" id="status" onchange="filter(#url.userid#)">
	                        <option class="dropdown-item" value="">Status</option>
	                        <option class="dropdown-item" value="1"<cfif structKeyExists(url, "status") AND url.status EQ 1> selected</cfif>>Completed</option>
	                        <option class="dropdown-item" value="2"<cfif structKeyExists(url, "status") AND url.status EQ 2> selected</cfif>>In-Progress</option>
	                        <option class="dropdown-item" value="3"<cfif structKeyExists(url, "status") AND url.status EQ 3> selected</cfif>>Re-Opened</option>
	                        <option class="dropdown-item" value="4"<cfif structKeyExists(url, "status") AND url.status EQ 4> selected</cfif>>R&D</option>
	                    </select>
				</div>
				<div class="col-2">
					<select class="form-select border-dark" name="task_type" id="task" onchange="filter(#url.userid#)">
                        <option class="dropdown-item" value="">Task Type</option>
                        <option class="dropdown-item" value="N"<cfif structKeyExists(url, "task") AND url.task EQ "N">selected</cfif>>New</option>
                        <option class="dropdown-item" value="B"<cfif structKeyExists(url, "task") AND url.task EQ "B">selected</cfif>>Bug</option>
                        <option class="dropdown-item" value="M"<cfif structKeyExists(url, "task") AND url.task EQ "M">selected</cfif>>Manual Error</option>
                    </select>
				</div> --->
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
			<table class="table table-striped border-dark" style="overflow: hidden;">
				<thead style="background-color:##31394F;">
					<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
						<th>SL.N0</th>
						<th style="width:8%">DATE</th>
						<th style="width: 7%;">PROJECT</th>
						<th style="width:7%">TASK TYPE</th>
						<th style="width: 10%;">MODULE</th>
						<th>DESCRIPTION</th>
						<th style="width:7%">STATUS</th>
						<th style="width:10%">TIME SPENT</th>
						<th style="width:10%">UPDATED ON</th>
						<th style="width:12%">PRODUCTIVE HOURS</th>
						<th>ACTION</th>
					</tr>
				</thead>
				<!--- <cfset k=1>
				<cfif queryRecordCount(list) GT 0> --->
				<tbody style="background-color:##FEF7F5">
					<!--- <cfloop query="list"> --->
						<tr class="text-center" style="font-size:small; vertical-align: middle; height: 50px; ">
							<td>#k#</td>
							<td>#dateFormat(list.start_time,"dd-mmm-yyyy")#</td>
							<td>#list.project_name#</td>
							<cfif list.task_type EQ "New">
								<td style="background-color: ##bfd6b8; Color: black">#list.task_type#</td>
							<cfelseif list.task_type EQ "Bug">
								<td style="background-color: ##d1b4b9;Color: black">#list.task_type#</td>
							<cfelseif list.task_type EQ "Manual Error">
								<td style="background-color: ##e09a7e;Color: black">#list.task_type#</td>
							</cfif>
							<td>#list.modules#</td>
							<td style="text-align: justify">#list.description#</td>
							<cfif list.status_name EQ "In Progress">
								<td style="background-color: ##9491bd;Color: black">#list.status_name#</td>
							<cfelseif list.status_name EQ "Completed">
								<td style="background-color:##a1c995;color: Black;">#list.status_name#</td>
							<cfelseif list.status_name EQ "Re-opened">
								<td style="background-color:##AFC0E1;color: Black;">#list.status_name#</td>
							<cfelseif list.status_name EQ "R&D">
								<td style="background-color:##FEE6DC;color: Black;">#list.status_name#</td>
							</cfif>
							<td>#timeFormat(list.start_time,"hh:nn tt")# - #timeFormat(list.end_time,"hh:nn tt")#</td>
							<td>#dateFormat(list.date,"dd-mmm-yyyy")#</td>
							<td>#list.productive_hours# Hour/s</td>
							<td>
<!--- edit/delete button --->
								<form method="post">
								<cfset dateDiff = dateDiff("d", list.date,now())>
									<span class="d-inline-block" tabindex="0" data-bs-toggle="tooltip" title="Disabled">
			  	 						<button type="submit" class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="Edit"<cfif dateDiff GT 1> disabled </cfif> formaction="./dashboard.cfm?id=#ts_id#&##contact"><i class="bi bi-pencil-square"></i></button> 
			  	 					</span>
		  	 					</form>
						  	 			<!--- <form method="post" style="margin-left: 15%; margin-top: 20%;">
						  	 				<input type="hidden" name="Delete">
						  	 				<button formaction="" type="Delete" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash3-fill"></i></button>
						  	 			</form> --->
		  	 				</td>
						</tr>
						<!--- <cfset k++> --->
					<!--- </cfloop> --->
				</tbody>
				<!--- <cfelse> --->
				<tfoot>
					<tr>
						<td colspan="12" class="text-center"><h3 class="my-5">No Records Found!</h3></td>
					</tr>
				</tfoot>	
				<!--- </cfif> --->
			</table>
		</div>
	<!--- </cfoutput> --->
	<script>
			function filter(Uid,m){
				var year = document.getElementById("year").value;
				var month = document.getElementById("month").value;
				var project = document.getElementById("project").value;
				if(m){
				var modules = m;}
				var status = document.getElementById("status").value;
				var task = document.getElementById("task").value;
				console.log(year);
				console.log(Uid);
				location.href="listing.cfm?userid="+Uid+"&year="+year+"&month="+month+"&project="+project+"&module="+modules+"&status="+status+"&task="+task;
			}
		</script>
</body>
