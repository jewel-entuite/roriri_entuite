<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>RORIRI -Employee Management</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">
	<link href="assets/css/style.css" rel="stylesheet">
	<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">



	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>

<!--- modal --->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</head>

<body style="background-color:burlywood;">
	<!--- style="background-color:burlywood;" --->
	<cfoutput>


<!--- invoke --->

<cfinvoke component="models.leaves" method="calendar_list" returnvariable="calendar_list"/>
<!--- <cfdump var="#calendar_list#"> --->
<!--- <cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#> --->


<cfset active_status = "calendar">
<!--- header --->
	<cfif session.employee.role_id EQ 1 OR session.employee.role_id EQ 2 OR session.employee.role_id EQ 3>
		<cfinclude template="../includes/header/admin_header.cfm" runonce="true">
	<cfelse>
		<cfinclude template="../includes/header/user_header.cfm" runonce="true">
	</cfif>
<!--- header ends --->
<cfset now=dateAdd("yyyy", 0, now())>
	<div class="container p-5">
	</div>
	<cfset first_day_of_year = createDate(year(now), 1, 1)>
	<div class="header">
		<h1 class="text-center fw-b" style=" font-size: 98px; font-weight: bold; color:##4a2f0c; font-family: serif;">#year(first_day_of_year)#</h1>
	</div>

	<cfset first_day_of_next_year = createDate(year(now+1)+1)>
	<cfset last_day_of_this_year = dateAdd("d", -1, first_day_of_next_year)>
	
	<div class="container p-5">
		<div class="row">
			<cfset k=0>
			<cfloop from="#first_day_of_year#" to="#last_day_of_this_year#" index="i" step="#createTimespan(1, 0, 0, 0)#">

				<cfif day(i) EQ 1>
					<div class="col-lg-4 my-1">
						<div class="card shadow-lg" style="height: 300px; background-color: wheat;">
							<center><h2 class="mt-4" style="font-weight:bold; color: peru;">#monthAsString(month(i))#</h2></center>
							<table class="mx-3 mb-3">
								<thead>
									<tr>
										<cfloop from="1" to="7" index="w">
											<th class="py-3" style="color:saddlebrown;">#dayOfWeekShortAsString(w)#</th>
										</cfloop>
									</tr>
							</thead>
							<tbody>
								<tr>
									<cfif dayOfWeek(i) EQ 1>

									<cfelse>
										<td colspan="#dayOfWeek(i)-1#"></td>
									</cfif>
				</cfif>
							<cfset leave=false>
							<cfset reason="">
							<cfloop query="calendar_list">
								<cfset calender  = #deserializeJSON(calendar_list.company_leaves_JSON)#>
								<cfloop array="#calender#" index="f">
									<cfif parseDateTime(dateFormat(f.date)) EQ parseDateTime(dateformat(i))>
										<cfset leave=f.date>
										<cfset reason=f.REASON>
									</cfif>
								</cfloop>
							</cfloop>
				<cfset k++>
						<td align="center"><button id="btnShow#k#" style=" background-color:wheat; border:none;<cfif dayOfWeek(i) EQ 1>color: indianred;font-weight: bold; <cfelseif leave NEQ false>color: orangered; font-weight: bold;<cfelse>color:black;</cfif>" data-toggle="modal" data-target="##exampleModalCenter"<cfif leave NEQ false>  onclick = "reason(#k#,'#reason#')"</cfif> >#dateTimeFormat(i, "d")#</button></td>

						<cfif dayOfWeek(i) EQ 7>
							</tr>
						</cfif>
				<cfif daysInMonth(i) EQ day(i)>
								</tr>
							</tbody>
						</table>
						</div>
						<br>
					</div>
				</cfif>
			</cfloop>
			<!--- modal --->
					<div class="modal"  id="testModal">
			      <div class="modal-dialog modal-sm modal-dialog-centered" id="modal-dialog">
			        <div class="modal-content" style="background-color:wheat;">
			          <div class="modal-header my-2 justify-content-center border-0">
			            <h5 class="modal-title"><span id="h_reason" style="font-size:25px; font-weight: bold; color:maroon;"></span></h5>
			            <!--- <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button> --->
			          </div>
			        </div>
			      </div>
			    </div>
<!--- modal ends --->
		</div>
	</div>
  
    
    <script>

      const container = document.getElementById("testModal");
      const modal = new bootstrap.Modal(container);
      function reason(k, h_reason){
      	if (h_reason!="") {
      		if (h_reason.length >15){
      			console.log("true")
      			document.getElementById("modal-dialog").classList.remove("modal-sm");
      			document.getElementById("modal-dialog").classList.add("modal-lg");
      		}else{
      			console.log("false")
      			document.getElementById("modal-dialog").classList.remove("modal-lg");
      			document.getElementById("modal-dialog").classList.add("modal-sm");
      		}
      		document.getElementById("h_reason").innerHTML=h_reason;
      	}else {
      		document.getElementById("h_reason").innerHTML="No Holidays :(";
      	}
      	modal.show();

      }
      // document.getElementById("btnShow").addEventListener("click", function () {
      //   modal.show();
      // });
      // document.getElementById("btnSave").addEventListener("click", function () {
      //   modal.hide();
      // });
    </script>
</cfoutput>

 <!-- Vendor JS Files -->
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>


</body>
</html>

