<!--- <cfdump var="#now()#"><cfdump var="#application#" abort> --->

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

#successAlert {
	position: fixed;
	top: 50%; /* Vertically center */
	left: 50%; /* Horizontally center */
	transform: translate(-50%, -50%); /* Adjust position by 50% of its own width and height */
	z-index: 2000; /* Higher z-index to appear above the overlay */
	display: none; /* Initially hidden */
}



<div id="overlay" style="display: none;"></div>
<div id="loader" style="display: none;"><img src="../assets/img/loader.gif" width="50" height="50" alt="Loading..."></div>
<div class="alert alert-success" style="display:none;" role="alert" id="successAlert">Task added successfully!</div>

window.onload = function() {
  // Function to get a URL parameter
  function getUrlParameter(name) {
    var url = new URL(window.location.href);
    var paramValue = url.searchParams.get(name);
    return paramValue;
  }

  // Function to remove a URL parameter
  function removeUrlParameter(param) {
    var url = new URL(window.location.href);
    url.searchParams.delete(param);
    window.history.replaceState({}, document.title, url.toString());
  }

  // Check if 'success' exists in the URL
  if (getUrlParameter('success') !== null) {
    // Display the overlay and alert
    document.getElementById('overlay').style.display = 'block';
    document.getElementById('successAlert').style.display = 'block';
    
    // Remove 'success' key from the URL
      removeUrlParameter('success');
    // Reload the page without the 'success' parameter in the URL
      location.reload();

    // Remove 'success' from the URL after a short delay
    setTimeout(function() {
      // Hide the overlay and alert after 3 seconds
      document.getElementById('overlay').style.display = 'none';
      document.getElementById('successAlert').style.display = 'none';

    }, 3000); // Adjust the timeout duration as needed
  }
};