<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
		  .pointer {
		    cursor: pointer;
		  }
		</style>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

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
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>

<body>
<cfoutput>
	<cfinvoke component="models.employee" method="getemployee" id="#session.employee.id#" returnvariable="employeeList"/>
	<cfif NOT structKeyExists(session, "employee")>
		<cflocation url="logout.cfm">
	</cfif>
<cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
<!--- header --->

<!--- header --->
	<cfset active_status="more">
	<cfinclude template="../includes/header/user_header.cfm" runonce="true">
<!-- End Header -->
	<div class="section-title pt-5 mt-5 ">
        <h2 class="mt-5">Employee Management</h2>
        <p>Daily Logs</p>
  </div>
<!--- Logs filter --->
  <div class="shadow card m-5">
  	<div class="fw-bold ms-3 mt-4" style="font-size: 0.9rem; color:##7d66e3;">
 	  	<label>DAILY LOGS</label>
 		</div>
 		<hr>
	<cfset loopcount = 5>
	<cfif structKeyExists(URL, "selectCount")>
	<cfset loopCount = #URL.selectCount#>
	</cfif>
<!--- <cfdump var="#loopCount#" abort> --->

	<div class="container my-5">
		<div class="row">
			<div class="col-2" style="margin-left: -5.75rem !important;">
				<select class="form-select border-dark" name="count" id="count" onchange="checkCount('#url.emp_id#')">
					<option class="dropdown-item" value="5">Select Count</option>
					<option class="dropdown-item" value="5" <cfif structKeyExists(url, "selectCount") AND url.selectCount EQ 5> selected</cfif>>5</option>
					<option class="dropdown-item" value="15" <cfif structKeyExists(url, "selectCount") AND url.selectCount EQ 15> selected</cfif>>15</option>
					<option class="dropdown-item" value="30" <cfif structKeyExists(url, "selectCount") AND url.selectCount EQ 30> selected</cfif>>30</option>
				</select>
			</div>
		</div>
	</div>
<!--- Logs filter ends--->

<!--- listing table --->

	<div class="m-5 my-0">
		<style>
		table{
		border: 5px solid black;
		border-radius: 20px;

		}
		</style>
		<table class="table table-striped border-dark" style="overflow: hidden; margin-top: -4.95rem !important;">
			<thead style="background-color:##31394F;">
				<tr class="text-center" style="font-size:large; vertical-align: middle; color: white; height: 50px;">
					<th>DATE</th>
					<th>WORKING HOURS</th>
					<th>NUMBER OF BREAKS</th>
					<th>STATUS</th>
				</tr>
			</thead>

			<cfset dtStart = Now() />

			<cfset dtToday = dtStart />


			<cfloop from="#dtStart#" to="#dateAdd("d", -#loopcount#, dtStart)#" index="dateindex"  step="#createTimespan(-1, 0, 0, 0)#">
			<cfinvoke component="models.logsheet" method="getDailyWorkhours" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" date="#dateindex#" returnvariable="dailyWorkTime"/>
			<cfinvoke component="models.logsheet" method="getDailyBreakCount" id="#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" date="#dateindex#" returnvariable="breakCount"/>
			<cfinvoke component="models.logsheet" method="getTotalLogs" id=#decrypt(url.emp_id, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')# date="#dateindex#" returnvariable="totalDayLogs"/>

			<cfset time = #dateTimeFormat(dailyWorkTime.total_hours,"HH:nn:ss")#>
			<cfset checktime = createTime(08, 30, 00)>

			<tbody style="background-color:##FEF7F5;">

				<tr class="text-center" style="font-size:medium; vertical-align: middle; height: 50px; " data-toggle="collapse" data-target="##rw-accordion-#dateindex#" class="clickable">
					<td style="cursor: pointer;">#dateformat(dateindex,"mm-dd-yyyy")#</td>
					<td style="cursor: pointer;">
					<cfif len(dailyWorkTime.total_hours) GT 0>#dateTimeformat(dailyWorkTime.total_hours,"HH:nn:ss")#<cfelse><span style="color: red;">NA</span></cfif>
					</td>
					<td style="cursor: pointer;">
					<cfif breakCount.breaks GT 0>#breakCount.breaks#<cfelse>0</cfif>
					</td>
					
					<td style="cursor: pointer;"><cfif len(dailyWorkTime.total_hours) GT 0>
					<cfif time GTE #dateTimeFormat(checktime,"HH:nn:ss")#>
					<strong style="color:Blue;">P</strong>
					<cfelseif time LT #dateTimeFormat(checktime,"HH:nn:ss")# AND time NEQ "">
					<strong style="color:red;">AN</strong>
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
								<tr style="font-size:medium; vertical-align: middle;color:white;">
									<th class="center">SL No.</th>
									<th class="center">CHECK-IN TIME</th>
									<th class="center">CHECK-OUT TIME</th>
									<th class="center">TOTAL HOURS</th>
								</tr>
							</thead>
							<tbody style="background-color:##FEF7F5;">
								<cfset previous_checkout_time = "">
								<cfloop query="#totalDayLogs#">
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

										<cfif hour_remaing EQ 0 AND min_remaing NEQ 0>
											<cfset Break_duration = "#min_remaing# Minutes&nbsp;#sec_remaing# Seconds">

										<cfelseif hour_remaing EQ 0 AND min_remaing EQ 0>
											<cfset Break_duration = "#sec_remaing# Seconds">

										<cfelse>
											<cfset Break_duration = "#hour_remaing# Hours&nbsp;#min_remaing# Minutes&nbsp;#sec_remaing# Seconds">
										</cfif>

										<tr style="font-size:small; vertical-align: middle; height: 50px;">
											<td colspan="4" class="alert alert-warning mt-5 text-left" style="font-weight:bold;">
												<center><span style="font-size:medium; color: black;">BREAK DURATION : </span><span style="font-size:medium">#Break_duration#</span></center>
											</td>
										</tr>
										</cfif>
									<tr style="font-size:small; vertical-align: middle; height: 50px;">
										<td>#totalDayLogs.currentrow#</td>
										<td>
											<cfif totalDayLogs.checked_in_time NEQ "">
												<strong>Time in:</strong>
												#dateTimeFormat(totalDayLogs.checked_in_time,"hh:nn:ss tt")#
												<cfif totalDayLogs.ip_in NEQ "">
													<br><br><strong>IP :</strong>
													#totalDayLogs.ip_in#
												</cfif>
											<cfelse>
												<strong>--</strong>
											</cfif>
										</td>
										<td >
											<cfif totalDayLogs.checked_out_time NEQ "">
												<strong>Time out:</strong>
												#dateTimeFormat(totalDayLogs.checked_out_time,"hh:nn:ss tt")#
												<cfif totalDayLogs.ip_out NEQ "">
													<br><br><strong>IP :</strong>
													#totalDayLogs.ip_out#
											</cfif>
											<cfelse>
												<strong>--</strong>
											</cfif>
										</td>
										<td>#dateTimeFormat(totalDayLogs.total_hours,"HH:nn:ss")#</td>

									</tr>
									<cfset previous_checkout_time = "#totalDayLogs.checked_out_time#">
								</cfloop>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>

			</cfloop>

			<tfoot>
				<tr>
					<td colspan="4" ><b>Note :</b> <b style="color:orangered;">NA</b> <B>-</B> No records; <b style="color: blue;">P</b> <b>-</b> Present; <b style="color:red;">AN</b> <b> -</b> Anomalies; <b>A -</b> Absent.</td>
				</tr>
			</tfoot>	
		</table>
	</div>
</div>
</cfoutput>
	
	<script>
		function checkCount(Uid) {
			let count = document.getElementById("count").value;
			console.log(count);
			// document.getElementById('daysCount').value = count;

			location.href="attendance_log.cfm?emp_id="+Uid+"&selectCount="+count;
		} 
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
