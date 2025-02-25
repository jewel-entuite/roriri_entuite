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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <title>RORIRI -Human Resource Management : Department</title>

    <!-- Google Fonts -->

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,600,600i,700,700i" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Cabin&family=Inconsolata&family=Merriweather+Sans&family=Nunito&family=Nunito+Sans&family=Pacifico&family=Quicksand&family=Rubik&family=VT323&display=swap" rel="stylesheet">  

    <!-- Template Main CSS File -->

    <link href="assets/css/style.css" rel="stylesheet">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
    <style>
      .table thead {
/*        background-color: #c8c4d9 !important; */
        background-color: #6e6884 !important; 
      }

      .table thead th {
/*        background-color: #c8c4d9 !important;*/
        background-color: #6e6884 !important;
        color: #fff; 
        padding: 10px; 
        text-align: left; 
      }
      .custom-icon-btn {
          border-color: #b3a6ed !important; /* Matches header color */
          color: #b3a6ed !important;
      }

      .custom-btn:hover {
          background-color: #b3a6ed !important;
          color: white !important;
      }
      #output.image-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-gap: 30px; /* Optional: Add some spacing between images */
      }
        .pointer {
          cursor: pointer;
        }
        .custom-btn {
            background: #fff;
            color: #7d66e3;
            border: 1px solid #7d66e3;
            border-radius: 5px;
            text-decoration: none;
            width:185px;
            padding: 4px;
            display: flex;
            justify-content:center;
        }
         .custom-btn:hover {
            background: #7d66e3;
            color: #fff;
        }
        .custom-modal-title {
            color: #6c5ce7; /* Custom purple color */
            font-weight: bold; /* Make it bold */
        }
        .custom-save-btn {
            background-color: #6c5ce7; /* Custom purple */
            color: #fff; /* White text */
            border: none; /* Remove default border */
            padding: 8px 16px; /* Adjust padding */
            border-radius: 5px; /* Slightly rounded corners */
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        .custom-save-btn:hover {
            background-color: #5a4dbd; /* Darker shade on hover */
        }


    </style>

  </head>
  <body>
    <cfif NOT structKeyExists(session, "employee")>
        <cflocation url="logout.cfm">
    </cfif>

    <!--- header --->

    <cfset active_status="workforce_structure">
    <cfinclude template="../includes/header/admin_header.cfm" runonce="true">
    <cfinvoke method="getDepartments" component="models.department" returnvariable="dept">
    <!--- header ends --->

    <cfoutput>
      <div class="container" style="margin-top:100px;">
        <div class="row">
          <div class="col-sm-12 col-md-12 col-lg-12 page-heading mb-5">
            <section id="contact" class="contact">
              <div data-aos="fade-up">
                <div class="section-title">
                  <h2 style="font-size: 24px;font-weight: 1000;padding-bottom: 0;line-height: 1px;margin-bottom: 15px;color: ##b3a6ed;">Workforce Structure</h2>
                  <p>Departments List</p>
                  <div class="row mb-3">
                    <div class="col-6"></div>
                    <div class="col-6 d-flex justify-content-end">
                      <a class="custom-btn btn-sm me-2" href="##" data-bs-toggle="modal" data-bs-target="##addDepartmentModal">Add New Department</a>
                    </div>
                  </div>
                  <div class="shadow card px-5 py-4 mt-4">
                    <table class="table table-striped mt-3 rounded-4 overflow-hidden">
                      <thead>
                        <tr class="table-header">  <!-- Apply the class to <tr>, not <thead> -->
                          <th>NO</th>
                          <th>DEPARTMENT</th>
                          <th>ACTION</th>
                        </tr>
                      </thead>
                      <tbody>
                        <cfset index =1/>
                        <cfloop query="dept">
                          <tr>
                            <td align="left" class="ps-3">#index#</td>
                            <td align="left">#dept.name#</td>
                            <td align="left" class="ps-4">
                              <button type="submit" class="btn custom-icon-btn btn-sm" data-bs-toggle="tooltip" data-bs-placement="top" value="#dept.id#" title="Edit">
                                <i class="bi bi-pencil-square"></i>
                              </button>
                            </td>
                          </tr>
                          <cfset index++/>
                        </cfloop>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </section>
          </div>
        </div>
      </div>
      <!-- Bootstrap Modal -->
      <div class="modal fade" id="addDepartmentModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md"> <!-- Centered and medium size -->
          <div class="modal-content m-3">
            <div class="modal-header">
              <h5 class="custom-modal-title" id="modalLabel">Add New Department</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form>
                <div class="m-2">
                  <label for="departmentName" class="form-label mb-3" style="font-size: small;">Department Name</label>
                  <input type="text" class="form-control" style="font-size: small;" id="departmentName" placeholder="Enter department name">
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="button" class="btn custom-save-btn">Save</button>
            </div>
          </div>
        </div>
      </div>
    </cfoutput>
  </body>
</html>
