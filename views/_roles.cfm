<cfinclude template="../includes/head.cfm" runonce="true">
<body>
  <cfoutput>
  <!--- 
    <cfinvoke component="models.logsheet" method="getLogs" returnvariable="userClock"/>
    <cfinvoke component="models.employee" method="getAllEmployees" returnvariable="employeeDetails"/> --->
    <cfinvoke component="models.employee" method="getrole" returnvariable="roles"/>
    <cfinvoke component="models.employee" method="getAllcandidates" returnvariable="referBy"/>
    
    <cfif NOT structKeyExists(session, "employee")>
      <cflocation url="logout.cfm">
    </cfif>  
    
    <!-- header -->
    <cfset active_status="employee_management">
    <cfinclude template="../includes/header/header.cfm" runonce="true">
    <!-- End Header -->
    
    <main>
      <section id="contact" class="contact">
        <div class="m-3" data-aos="fade-up">
          <div class="section-title pt-5">
            <h2 class="mt-5">Employees Roles</h2>
            <p>Roles and Modules</p>
          </div>
          <div class="row justify-content-between">                     
            <div class="container px-5 py-3">
              <div class="card p-2">
                <div class="mb-2 ms-2 mt-3 fs-7 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                  <label>USERS AND ROLES</label>
                </div>
                <hr>
                <div class="card">
                  <div class="card-body">
                    <form name="RolesToUsers" action="" class="row g-3" method="post">
                      <div class="col-md-12">
                        <p class="text-danger user-role-error"></p>
                      </div>
                      <div class="row">
                      <div class="col-md-3">
                        <label for="users" class="form-label">Users</label>
                        <select class="form-select" name="" id="users">
                          <option value="">Select User</option>
                          <cfloop query="referBy">
                            <option class="dropdown-item" value="referBy.id">#referBy.first_name#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="col-md-3">
                        <label for="roles" class="form-label">Roles</label>
                        <select class="form-select" name="roleId" id="user_roles">
                          <option value="">Select Role</option>
                          <cfloop query="roles">
                            <option class="dropdown-item" value="#roles.id#">#roles.role#</option>
                          </cfloop>
                        </select>
                      </div>
                      <div class="col-md-3">
                        <label class="form-label mt-4"></label>
                        <input type="hidden" name="hdnUserRoleid" id="hdn_User_Roleid" value="hdnUserRoleid">           
                        <input type="submit" id="update_role" class="btn btn-success btn-block form-control" value="UPDATE ROLE" >
                      </div>
                    </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
                <div class="row justify-content-between">                     
            <div class="container px-5 py-3">
              <div class="card p-2">
                <div class="mb-2 ms-2 mt-3 fs-7 fw-bold" style="font-size: 0.9rem; color:##7d66e3;">
                  <label>ROLES AND MODULES</label>
                </div>
                <hr>
                <div class="card">
                <div class="card-body">
                    <form name="RolesToUsers" action="" class="row g-3" method="post">
                      <div class="col-md-12">
                        <p class="text-danger user-role-error"></p>
                      </div>
                      <div class="row">
                          <div class="col-md-3">
                            <label for="roles" class="form-label">Roles</label>
                            <select class="form-select" name="roleId" id="user_roles">
                              <option value="">Select Role</option>
                              <cfloop query="roles">
                                <option class="dropdown-item" value="#roles.id#">#roles.role#</option>
                              </cfloop>
                            </select>
                          </div>
                          <div class="col-md-6">
                              <p class="text-danger error"></p>
                              <label>Select Menu</label>
                      <!--- <cfinvoke component="models.user" method="getMenuList" returnvariable="getMenuList"/>
                      <cfloop query="getMenuList">
                                <label class="custom-control custom-checkbox ">
                                <input  type="checkbox" name="menuId" class="custom-control-input menu-check-box chk-m-#getMenuList.id#" value="#getMenuList.id#"  
                                  <cfif ListFind(menuId, getMenuList.id)>checked</cfif>> <span class="custom-control-label"></span>&nbsp;&nbsp;&nbsp;<span class="badge badge-pill badge-info font-weight-bold">#getMenuList.menu# </span>
                        <cfinvoke component="models.user" method="getSubMenuList" menuId= "#getMenuList.id#"returnvariable="getSubMenuList"/>
                          <cfloop query="getSubMenuList">
                                        <label class="custom-control custom-checkbox ">
                                        <input type="checkbox" name="subMenuId" class="custom-control-input chk-#getMenuList.id#" value="#getSubMenuList.id#"<cfif ListFind(subMenuId, getSubMenuList.id)>checked</cfif> > <span class="custom-control-label"></span>&nbsp;&nbsp;&nbsp;<span class="badge badge-pill badge-info font-weight-bold">#getSubMenuList.sub_menu# </span>
                                        </label>
                                        
                                      </cfloop>

                                  </label>
                                  <br>
                              </cfloop> --->
                          </div>
                          <div class="col-md-3">
                              <label class="form-label mt-4"></label>
                              <input type="button" id="submit_role" class="btn btn-success btn-block form-control" value="SAVE" >
                          </div>
                      </div>
                    </form>
                  </div>
              </div>
                </div>
              </div>
            </div>
          </div>
        <!--- </div> --->
      </section>
    </main>
  </cfoutput>
  
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