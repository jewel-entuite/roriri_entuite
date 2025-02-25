<cfcomponent
    displayname="ENTUITE Employee & Project Management"
    output="true"
    hint="ENTUITE PM - Master Application CFC">

    <!--- Set up the application. --->
    <cfset THIS.Name = "RORIRI -Employee Management" />
    <cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 1, 0, 0 ) />
    <cfset THIS.SessionManagement = true />
	<cfset THIS.sessionTimeout     = createTimeSpan( 0, 0, 30, 0 )>
	<cfset THIS.ClientManagement = true />
    <cfset THIS.SetClientCookies = true />
	<cfset THIS.loginstorage="session">
	<cfset THIS.setdomaincookies = true />
	<cfset THIS.scriptProtect = true>
	<cfset THIS.datasource = "stage_entuite_hrms_dsn">
	
    <!--- Define the page request properties.--->
    <cfsetting
        requesttimeout="60000"
        showdebugoutput="false"
        enablecfoutputonly="false"
        /> 

    <cffunction
        name="OnApplicationStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="Fires when the application is first created.">
<!--- app<cfdump var="#arguments#" > --->
		<cfset APPLICATION.timesheet = CreateObject('component', 'models.timesheet') />
		
        <cfreturn true />
    </cffunction>
 

    <cffunction
        name="OnSessionStart"
        access="public"
        returntype="void"
        output="false"
        hint="Fires when the session is first created.">
		
        <cfreturn />
    </cffunction>


    <cffunction
        name="OnRequestStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="Fires at first part of page processing.">

        <!--- Define arguments. --->
        <cfargument
            name="TargetPage"
            type="string"
            required="true"
            />
<!--- req start<cfdump var="#arguments#"> --->
            <!--- <cfif NOT StructKeyExists(session, "employee")>
            	<cfif NOT listFindNoCase(CGI.script_name, "index.cfm","/") OR ( NOT structKeyExists(form, "password"))>
					<cfset StructClear(application)>
					<cflocation url="index.cfm" addtoken="false" />
				</cfif>
			</cfif> --->
            
            <!--- <cfset CreateObject("Component","gblconfig").init() /> --->

			<cfset application.rootPath = GetDirectoryFromPath(GetCurrentTemplatePath()) />
			
			<cfset application.appname = "Employee Management" />
			
			<cfif CGI.https eq 'ON'>
				<cfset application.urlpath= "https://#CGI.SERVER_NAME#"> 
			<cfelse>
				<cfset application.urlpath=	"http://#CGI.SERVER_NAME#">
			</cfif>

			<cfset application.developers = StructNew() />
			<cfset application.developers.email = "entuite@gmail.com" />
			<cfset application.developers.debugip = "202.88.234.141" />

            <cfset application.curdate = dateAdd('h','11',parseDateTime(now(),"yyyy-mm-dd hh:nn:ss"))>
			<cfset application.curdatetime=dateAdd('n','-30',application.curdate)>



<!--- 9-<cfdump var="#application#"> --->
			<!--- <cfset THIS.customtagpaths = ''>
			<cfset customtagpaths = ListAppend(THIS.customtagpaths,"#application.rootPath#\views\pagination")>
    		<cfset THIS.customtagpaths = customtagpaths> --->
			<cfif structKeyExists(url,'reinit')>
				<cfset StructClear(application)>
				<cfset OnApplicationStart() />
			</cfif>
			
        <cfreturn true/>
    </cffunction>


    <cffunction
        name="OnRequest"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after pre page processing is complete.">

        <!--- Define arguments. --->
        <cfargument
            name="TargetPage"
            type="string"
            required="true"
            />
<!--- start-<cfdump var="#arguments#"> --->

			<cfif structkeyexists(url,"reinit")>
				<cfset StructClear(application)>
				<cfset OnApplicationStart()>
			</cfif>
        <!--- Include the requested page. --->
        <cfinclude template="#ARGUMENTS.TargetPage#" />

        <!--- Return out. --->
        <cfreturn />
    </cffunction>


    <cffunction
        name="OnRequestEnd"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after the page processing is complete.">

        <!--- Return out. --->
        <cfreturn />
    </cffunction>


    <cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true" />
		<cfargument name="appScope" type="struct" required="false" />

		<cfset StructDelete(Arguments, "sessionScope") />
		<cflocation url="logout.cfm" addtoken="false">
	</cffunction>


    <cffunction
        name="OnApplicationEnd"
        access="public"
        returntype="void"
        output="false"
        hint="Fires when the application is terminated.">

        <!--- Define arguments. --->
        <cfargument
            name="ApplicationScope"
            type="struct"
            required="false"
            default="#StructNew()#"
            />

        <!--- Return out. --->
        <cfreturn />
    </cffunction>

	<cffunction name="onError">
		<cfargument name="Except" required="true"/>
		<cfargument name="EventName" type="String" required="true"/>
			 <!--- onError <Cfdump var="#arguments#"><Cfdump var="#application#"><cfabort>  --->
		<!--- <cfif application.global.environment EQ "dev" OR cgi.remote_addr EQ application.developers.debugip>
			<cfdump var="#Except#" abort="true"/>
		</cfif> --->
		<!--- <cfinclude template="/unauth.cfm"> --->
		<!--- err-<cfdump var="#arguments#" abort/> --->
		<cfset errorID = dateFormat(now(), "MMDD") & right(createUUID(), '7')>

		<!--- <cfmail from="entuite@gmail.com" to="entuite@gmail.com" cc="thanumalayan94@gmail.com" subject="EMP management onError #errorID#" type="text/html">
			
			ERROR ID: <cfdump var="#errorID#"><br><br>
			IST TIME: <cfdump var="#now()#"><br><br>
			<cfif isDefined("session")>
				SESSION:
				<cfdump var="#session#">
			</cfif>
			<cfif isDefined("form")>
				FORM DATA:
				<cfdump var="#form#">
			</cfif>
			<cfif isDefined("URL")>
				URL PARAMETERS:
				<cfdump var="#url#">
			</cfif>
			<cfif isDefined("CGI")>
				CGI PARAMETERS:
				<cfdump var="#cgi#">
			</cfif><br><br>
			<Cfdump var="#arguments#">
		</cfmail> --->
		<!--- <cfif structKeyExists(session, "user")>
			<Cfdump var="#arguments#" abort>
		<div style="width: 50%; color: red; border: 2px dotted red; background-color: ##f9f9f9; padding: 10px;">
			<h1 style="color: red;">ALERT! It seems to be some issue with this Process.</h1>
			<div style="width: 100%; text-align: left;">
				<p><b>Please go back and recheck and try the Process again! Sorry for the inconvenience!</b></p>
				<p><b>Administrator has been notified on this with the ERROR LOG ID: #errorID#</b></p>
			</div>
		</div>
		<cfelse>
			<cfinclude template="/unauthserver.cfm">
		</cfif> --->
		<cfif structKeyExists(url, "debug") AND url.debug EQ true>
			<cfdump var="#arguments#">
		</cfif>

		<cfabort>
	</cffunction>
	
	<cffunction name="onMissingTemplate" returnType="boolean">
		<cfargument type="string" name="targetPage" required=true/>
			<!--- onMissingTemplate <Cfdump var="#arguments#"><Cfdump var="#application#"><cfabort> --->
		<!--- <cfif application.global.environment EQ "dev" OR cgi.remote_addr EQ application.developers.debugip>
			<cfinclude template = "usrError404.cfm">
			<cfabort>
		</cfif> --->
		<!--- <cfinclude template="/unauth.cfm"> --->
		<!--- miss<cfdump var="#arguments#"/> --->
		<cftry>
			<cfsavecontent variable="errorLog">
				<div style="width: 50%; color: red; border: 2px dotted red; background-color: ##f9f9f9; padding: 10px;">
					<h1 style="color: red;">Page not found</h1>
					<div style="width: 100%; text-align: left;">
						<p><b>User tried to request page, but without any success :(</b></p>
						<cfdump var="#targetPage#" />
						<cfdump var="#arguments#"/>
					</div>
				</div>
			</cfsavecontent>
			<!--- <cfmail to="entuite@gmail.com" from="entuite@gmail.com" subject="Page not found" type="html"> --->
				#errorLog#
				<cfif isDefined("session")>
					SESSION:
					<cfdump var="#session#">
				</cfif>
				<cfif isDefined("form")>
					FORM DATA:
					<cfdump var="#form#">
				</cfif>
				<cfif isDefined("URL")>
					URL PARAMETERS:
					<cfdump var="#url#">
				</cfif>
				<cfif isDefined("CGI")>
					CGI PARAMETERS:
					<cfdump var="#cgi#">
				</cfif>
			<!--- </cfmail> --->

			<!--- <cfinclude template = "usrError404.cfm"> --->
			<cfreturn true />
		<cfcatch>
			<cfreturn false />
			<cfthrow message="An error has occured.  Additionally an error was encountered when processing the site's error handling routine. <br><br> #cfcatch.message#">
		</cfcatch>
		</cftry>
		
	</cffunction>
</cfcomponent>