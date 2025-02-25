<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
        <link rel="stylesheet" href="assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
      <!-- Favicons -->
        
        
      <!-- Google Fonts -->
        <!--- <link href="../views/TimeSheet_files/css" rel="stylesheet"> --->
      <!-- Vendor CSS Files -->
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
		<!--- modal --->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


        <style>
        	
        	.card{
        		box-shadow: 1px 1px white;
        	}

        	.card:hover{
        		background-color: wheat;

        	}



        </style>

</head>
<body>
	<cfoutput>
		<cfif structKeyExists(url,"id")>
		    <cfdirectory action="list" directory="#expandPath("../assets/Asset_files")#/#url.id#" recurse="false" name="myList">
		    <div class="row my-5 py-2">
		        <cfset pdffiles = queryFilter(myList, function(obj){
		           return listFindNoCase(obj.name,"pdf",".");
		        })>

		        <cfset imagefiles = queryFilter(myList, function(obj){
		           return listFindNoCase(obj.name,"jpg",".")||listFindNoCase(obj.name,"jpeg",".")||listFindNoCase(obj.name,"png",".")||listFindNoCase(obj.name,"gif",".") ;
		        })>
			  		<!--- <cfdump var="#imagefiles.recordCount#"><cfabort> --->
			  	<cfif imagefiles.recordCount GT 0>
			  		<cfloop query="imagefiles">
				    		<!--- <cfdump var="testjkjhi"> --->
				        <div class="col-4 m-5" >
				            <div class="card container" style="width: 448px; height: 333px;">
				              	<img class="card-img-top" style="width: auto; height: 300px" src="../assets/Asset_files/#url.id#/#imagefiles.name#">
				              	<div class="card-body text-center">
				                	<!--- <button style="background: ##7d66e3;border: 0;padding: 3px 2px;color: ##fff;border-radius: 4px;" id="conformation" onclick="showConfirmation(event,'#listlast(imagefiles.directory,"\")#','#imagefiles.name#')" ></button> --->
				              	</div>
				            </div>
				      	</div>
			    	</cfloop>
				  <cfelse>
			    	<div class="col-4 my-3" >
			    		<h2 style="color: red; size: 20px;">Sorry! No images are uploaded for this asset</h2>
			    		<!--- <cfdump var="testjkjhi"> --->
			    	</div>
			    </cfif>
		  	</div>
		</cfif>
	</cfoutput>
</body>
</html>