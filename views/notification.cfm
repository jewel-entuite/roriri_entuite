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
			
    <!-- Template Main CSS File -->
    	<link rel="stylesheet" type="text/css" href="assets/css/style.css">
		<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">

</head>
<style>
				table{
					border: 5px solid black;
					border-radius: 20px;

				}
			</style>

<body>

		<!--- <cfif NOT structKeyExists(session, "employee")>
			<cflocation url="logout.cfm">
		</cfif> --->
<!--- 
<cfinvoke component="models.timesheet" method="getTimesheetEmployees" returnvariable="employeeList"/>

<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/> --->
<!--- header --->
	

	<cfinclude template="../includes/header/admin_header.cfm" runonce="true">

<!--- header ends --->
<cfoutput>

<!--- invokes --->
<cfinvoke component="models.leaves" method="getleaveapproval" returnvariable="leave_history">
<!--- <cfinvoke component="models.leaves" method="getwfhapproval" returnvariable="wfh_history"> --->

<!--- invokes --->

<div class="card shadow p-3 alert alert-warning "style="margin-top:100px;MAX-HEIGHT: 75PX;" role="alert">
        	<center><h3><strong>NOTIFICATION</strong></h3></center>
        </div> 	
<div>
	
<!--- <div class="card shadow p-3 alert alert-warning container" style="margin-top:100px;MAX-HEIGHT:50PX;width: 300PX;" role="alert"> --->
        	<!--- <center><h5><strong>LEAVE REQUESTS</strong></h5></center>
        	 </div> --->
      
       

		<!--- <table class="table table-striped border-dark container" style="overflow: hidden;">
						<thead style="background-color:##31394F;">
							<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
								<th>SL.N0</th>
								<th>NAME</th>
								<th style="width:10%">APPLY DATE</th>
								<th style="width:10%">START DATE</th>
								<th style="width:10%">END DATE</th>
								<th>NUMBER OF DAYS</th>
								<th>REASON</th>
								<th>ACTION</th>
							</tr>
						</thead>
						<tbody>
							<cfloop query="leave_history">
							<tr class="text-center">
								<cfset Y=queryCurrentRow(leave_history)>
								<td>#Y#</td>
								<td>#leave_history.first_name# #leave_history.last_name#</td>
								<td>#dateFormat(leave_history.created_date,"dd-mm-yyyy")#</td>
								<td>#dateFormat(leave_history.from_date,"dd-mm-yyyy")# (#leave_history.start_period#)</td>
								<td>#dateFormat(leave_history.to_date,"dd-mm-yyyy")# (#leave_history.end_period#)</td>
								<td>#leave_history.total_days#</td>
								<td>#leave_history.reason#</td>
								<td>
									<form action="../controller/_notification.cfm" method="post"onsubmit="return checks(#Y#)">
										<button class="btn btn-success" id="leave_sub#Y#"<cfif leave_history.approved_status EQ 1> disabled </cfif>>Approve</button>
										<input type="hidden" name="leave_approve" value="#leave_history.id#">
									</form></td>
							</tr>
							</cfloop>
								
						</tbody>
					</table> --->
					 
					<!--- <div class="card shadow p-3 alert alert-warning container" style="margin-top:100px;HEIGHT:50PX;width: 400PX;" role="alert">
        				<center><h5><strong>WORK FROM HOME REQUEST</strong></h5 ></center></div>
        
					<table class="table table-striped border-dark container" style="overflow: hidden;">
						<thead style="background-color:##31394F;">
							<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
								<th>SL.N0</th>
								<th>NAME</th>
								<th style="width:10%">APPLY DATE</th>
								<th style="width:10%">START DATE</th>
								<th style="width:10%">END DATE</th>
								<th>NUMBER OF DAYS</th>
								<th>REASON</th>
								<th>ACTION</th>
							</tr>
						</thead>
						<tbody>
							 <cfloop query="wfh_history">
							 <tr class="text-center">
							 	<cfset R=queryCurrentRow(wfh_history)>
								<td>#R#</td>
								<td>#wfh_history.first_name# #wfh_history.last_name#</td>
								<td>#dateFormat(wfh_history.created_date,"dd-mm-yyyy")#</td>
								<td>#dateFormat(wfh_history.start_date,"dd-mm-yyyy")# (#wfh_history.start_period#)</td>
								<td>#dateFormat(wfh_history.end_date,"dd-mm-yyyy")# (#wfh_history.end_period#)</td>
								<td>#wfh_history.total_days#</td>
								<td>#wfh_history.reason#</td>
							<td>
								<form action="../controller/_notification.cfm" method="post" onsubmit="return check(#R#)">
								<button class="btn btn-success" id="wfh_sub#R#"<cfif wfh_history.approved_status EQ 1> disabled </cfif>>Approve</button>
								<input type="hidden" name="wfh_approve"value="#wfh_history.id#">
								</form>
							</td>
							</tr>
							</cfloop>
								
						</tbody>
					</table>
				</div> --->
				<table class="table table-striped border-dark container" style="overflow: hidden;">
						<thead style="background-color:##31394F;">
							<tr class="text-center" style="font-size:small; vertical-align: middle; color: white; height: 50px;">
								<th>SL.N0</th>
								<th>NAME</th>
								<th style="width:10%">APPLY DATE</th>
								<th style="width:10%">START DATE</th>
								<th style="width:10%">END DATE</th>
								<th>NUMBER OF DAYS</th>
								<th>REASON</th>
								<th>ACTION</th>
							</tr>
						</thead>
						<tbody>
							<cfloop query="leave_history">
							<tr class="text-center">
								<cfset Y=queryCurrentRow(leave_history)>
								<td>#Y#</td>
								<td>#leave_history.first_name# #leave_history.last_name#</td>
								<td>#dateFormat(leave_history.created_date,"dd-mm-yyyy")#</td>
								<td>#dateFormat(leave_history.from_date,"dd-mm-yyyy")# (#leave_history.start_period#)</td>
								<td>#dateFormat(leave_history.to_date,"dd-mm-yyyy")# (#leave_history.end_period#)</td>
								<td>#leave_history.total_days#</td>
								<td>#leave_history.reason#</td>
								<td>
									<form action="../controller/_notification.cfm" method="post"onsubmit="return checks(#Y#)">
										<button class="btn btn-success" id="leave_sub#Y#"<cfif leave_history.approved_status EQ 1> disabled </cfif>>Approve</button>
										<input type="hidden" name="leave_approve" value="#leave_history.id#">
									</form></td>
							</tr>
							</cfloop>
								
						</tbody>
					</table>
					
				</cfoutput>

			<script>
    function check(R){
    // console.log(R)
    document.getElementById("wfh_sub"+R).style.background="rgba(120, 204, 172, 0.4)";
    document.getElementById("wfh_sub"+R).innerHTML="please wait...";
  }
    function checks(Y){
    // console.log(Y)
    document.getElementById("leave_sub"+Y).style.background="rgba(120, 204, 172, 0.4)";
    document.getElementById("leave_sub"+Y).innerHTML="please wait...";
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