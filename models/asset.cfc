<cfcomponent>
<cffunction name="insert_asset">
		<cftry>
		<cfset first3digit = left(form.make, 3)>
		<cfset last4digit = right(form.slno, 4)>
		<cfquery name="asset" result="asset_result">
			INSERT INTO asset set
			asset_type_id=<cfqueryparam value="#form.asset_type#" cfsqltype="cf_sql_integer"/>,
			serial_number=<cfqueryparam value="#uCase(form.slno)#" cfsqltype="cf_sql_varchar"/>,
			model_number=<cfqueryparam value="#uCase(form.ModelNo)#" cfsqltype="cf_sql_varchar"/>,
			make=<cfqueryparam value="#uCase(form.make)#" cfsqltype="cf_sql_varchar"/>,
			asset_code=<cfqueryparam value="null" cfsqltype="cf_sql_varchar">,
			image=<cfqueryparam value="null" cfsqltype="cf_sql_varchar">,
			images=<cfqueryparam value="null" cfsqltype="cf_sql_varchar">,
			created_by=<cfqueryparam value="#session.employee.id#" cfsqltype="cf_sql_integer">,
			updated_by=<cfqueryparam value="#session.employee.id#" cfsqltype="cf_sql_integer">,
			<cfif structKeyExists(form, "processor") AND form.processor NEQ "">
				processor=<cfqueryparam value="#form.processor#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			<cfif structKeyExists(form, "processor_type") AND form.processor_type NEQ "">
				processor_type=<cfqueryparam value="#form.processor_type#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			<cfif structKeyExists(form, "generation") AND form.generation NEQ "">
				processor_gen=<cfqueryparam value="#form.generation#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			vendor_id=<cfqueryparam value="#form.vendor#" cfsqltype="cf_sql_integer"/>,
			<cfif structKeyExists(form, "start_warranty") AND form.start_warranty NEQ "">
				warranty_start_date=<cfqueryparam value="#dateFormat(form.start_warranty,"yyyy-mm-dd")#" cfsqltype="cf_sql_varchar">,
			</cfif>
			<cfif structKeyExists(form, "end_warranty") AND form.end_warranty NEQ "">
				warranty_end_date=<cfqueryparam value="#dateFormat(form.end_warranty,"yyyy-mm-dd")#" cfsqltype="cf_sql_varchar">,
			</cfif>
			<cfif structKeyExists(form, "ex_warranty") AND form.ex_warranty NEQ "">
				extended_warranty=<cfqueryparam value="#form.ex_warranty#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			<cfif structKeyExists(form, "branch") AND form.branch NEQ "">
				branch_id=<cfqueryparam value="#form.branch#" cfsqltype="cf_sql_integer">,
			</cfif>
			personal_asset=<cfqueryparam value="#form.personal#" cfsqltype="cf_sql_integer">
			
		</cfquery>
		<!--- <cfquery name="get_last_asset">
			SELECT * FROM asset
			WHERE asset_type_id=<cfqueryparam value="#form.asset_type#" cfsqltype="cf_sql_integer"/>
			AND serial_number=<cfqueryparam value="#form.slno#" cfsqltype="cf_sql_varchar"/>
			AND	model_number=<cfqueryparam value="#form.ModelNo#" cfsqltype="cf_sql_varchar"/>
			AND	make=<cfqueryparam value="#form.make#" cfsqltype="cf_sql_varchar"/>
			ORDER BY id DESC;
		</cfquery> --->
		<cfset asset_code = #uCase("#first3digit#-#last4digit#-#asset_result.generatedkey#")#>
		<cfscript>

			code128= createobject("java","
				com.lowagie.text.pdf.Barcode128");
			code128.setCodeType(code128.CODE128);
			/* Set the code to generate */
			code128.setCode("#asset_code#");
			color =  createobject("java","java.awt.Color");
			image = code128.createAwtImage(color.black, color.white);
			bufferedImage = createObject("java", "java.awt.image.BufferedImage");
			bufferedImageType = bufferedImage.TYPE_BYTE_GRAY;
			bufferedImage = bufferedImage.init(image.getWidth(JavaCast("null", "")),image.getHeight(JavaCast("null", "")), bufferedImageType);
			graphics2D = bufferedImage.createGraphics();
			graphics2D.drawImage(image,0,0,JavaCast("null", ""));
			barcodeImage = imageNew(bufferedImage);

		</cfscript>

		<cfif NOT directoryExists("#expandPath("../images/barcode")#")>
			<cfdirectory action="create" directory="#expandPath("../images/barcode")#">
		</cfif>

		<cfimage source="#barcodeImage#" action="convert" destination="#expandPath("../images/barcode/#asset_code#.png")#">
		<cfset imageName = "#asset_code#.png">
		<cfset image1 = "#asset_code#-1">
		<cfset image2 = "#asset_code#-2.png">
		<cfset inx = 1>
		<!--- <cftry> --->

			<!--- <cfif structKeyExists(form, "upload")> --->
		<cfif NOT directoryExists("#expandPath("../assets/Asset_files")#/#asset_result.generatedkey#")>
			<cfdirectory action="create" directory="#expandPath("../assets/Asset_files")#/#asset_result.generatedkey#">
		</cfif>
    <cfset uploadDir = "#expandPath("../assets/Asset_files")#/#asset_result.generatedkey#">
    <cffile action="uploadAll" 
            destination="#uploadDir#"
            nameconflict="makeunique"
            result="files">
<!--- </cfif> --->


		<!--- <cfloop array="#form.imagesrc#" index="IM">
		<cfdump var="#IM#">		
			<cffile 
				action = "upload"
				destination = "#expandPath("../images/Asset")#/#image1#(#inx#).png" 
				fileField = "IM" 
				result = "result"
				nameConflict = "MakeUnique">
		<cfset inx++>
		</cfloop>
		<cfcatch>
<cfdump var="#cfcatch#">
		</cfcatch>
		</cftry> --->
	<!--- 	<cfif NOT directoryExists("#expandPath("../assets/Asset_files/Files")#/#asset_result.generatedkey#")>
			<cfdirectory action="create" directory="#expandPath("../assets/Asset_files/Files")#/#asset_result.generatedkey#">
		</cfif>
    <cfset uploadDirec = "#expandPath("../assets/Asset_files/Files")#/#asset_result.generatedkey#/file"> --->
    <!--- <cffile action="uploadAll" 
            destination="#uploadDirec#"
            accept="image/png,image/jpg,image/jpeg,.png,.jpg,.jpeg"
            allowedextensions="png,jpg,jpeg,cfm"
            nameconflict="makeunique"
            result="doc"> --->
            <!--- <cffile action="uploadAll" 
        destination="#uploadDirec#"
        accept="application/pdf,.pdf"
        allowedextensions="pdf,cfm"
        nameconflict="makeunique"
        result="doc"> --->

		<cfquery name="update_asset_code">
			UPDATE asset SET 
			asset_code=<cfqueryparam value="#asset_code#" cfsqltype="cf_sql_varchar">,
			barcode_image = <cfqueryparam value="#imageName#" cfsqltype="cf_sql_varchar">,
			image=<cfqueryparam null="true" cfsqltype="cf_sql_varchar">,
			images=<cfqueryparam null="true" cfsqltype="cf_sql_varchar">
			WHERE id=<cfqueryparam value="#asset_result.generatedkey#" cfsqltype="cf_sql_integer"/>
		</cfquery>
		<cfreturn 1>
			<cfcatch><cfdump var="#cfcatch#"abort></cfcatch>
	</cftry>

	</cffunction>

	<!--- <cffunction name="get_asset">
		<cfquery name="asset" >
	</cfquery>
	</cffunction>
 --->
	<cffunction name="get_asset">
		<cfargument name="a" default="">
		<cfquery name="asset" >
			SELECT A.*,T.*,V.*,ATY.name AS asset_name,ATY.id AS asset_id,B.name AS branch,V.name AS ven_name, AA.assigned_on, P.name AS Pro_name,PT.name AS Pro_type_name, PG.genaration AS gen FROM asset_type T
			LEFT JOIN asset A ON A.asset_type_id = T.id
			LEFT JOIN asset_type ATY ON ATY.id=A.asset_type_id
			LEFT JOIN processor P ON P.id=A.processor
			LEFT JOIN processor_type PT ON PT.id=A.processor_type
			LEFT JOIN processor_generation PG ON PG.id=A.processor_gen
			LEFT JOIN asset_assign AA ON AA.assigned_asset_code= A.asset_code
			LEFT JOIN vendor V ON V.id=A.vendor_id
			LEFT JOIN branch B ON B.id=A.branch_id
			WHERE 1=1
			<cfif structKeyExists(form, "asset_type") AND form.asset_type NEQ "">
				AND t.id = <cfqueryparam value="#form.asset_type#" cfsqltype="cf_sql_integer"/>
			<cfelseif structKeyExists(arguments, "a") AND arguments.a NEQ "">
				AND t.id = <cfqueryparam value="#arguments.a#" cfsqltype="cf_sql_integer"/>
			<cfelse>
				AND A.id IS NOT NULL
			</cfif>
		</cfquery>
		<cfreturn asset>
	</cffunction>



	<cffunction name="assign_emp">
		<cfargument name="ae" default="">
		<cfargument name="a_id" default="">
		<cfquery name="assign" >
		SELECT A.*,T.*,AA.*,E.first_name,AA.id AS aa_id FROM asset A
		LEFT JOIN asset_type T ON T.id = A.asset_type_id
		LEFT JOIN asset_assign AA ON AA.assigned_asset_code = A.asset_code
		LEFT JOIN employee E ON E.id = AA.employee_id
		WHERE 1=1 
		<cfif structKeyExists(arguments,"ae") AND len(arguments.ae)>
		AND T.id = <cfqueryparam value="#arguments.ae#" cfsqltype="cf_sql_integer"/>
		</cfif>
		</cfquery>
		<cfreturn assign>
	</cffunction>

	<cffunction name="get_asset_code">
		<cfargument name="device" default="">
		<cfquery name="getCode" >
			SELECT asset_code FROM asset
			WHERE asset_type_id=<cfqueryparam value="#arguments.device#" cfsqltype="cf_sql_integer" >
			AND asset_code IS NOT NULL
			ORDER BY asset_code DESC;
		</cfquery>

		<cfreturn getCode> 
	</cffunction>


<cffunction name="assign_asset">

	<!--- Unassign --->
	<cfif structKeyExists(form, "unassign") AND form.unassign NEQ "">
		<cfloop from="1" to="#listlen(form.unassign,",")#" index="k">
			<cfset id ="#listGetAt(form.unassign, k,",")#">
			<cfquery name="unassign">
				UPDATE asset_assign SET
				assigned_status=<cfqueryparam value="0" cfsqltype="cf_sql_integer">,
				employee_id=<cfqueryparam value="" cfsqltype="cf_sql_integer">
				WHERE id=<cfqueryparam value="#id#" cfsqltype="cf_sql_varchar">
			</cfquery>
		</cfloop>
	</cfif>

	<!--- Assign --->
	<cfif structKeyExists(form, "assign") AND form.assign NEQ "">
		<cfloop from="1" to="#listlen(form.assign,",")#" index="k">
			<cfset code ="#listGetAt(form.assign, k,",")#">
			<cfquery name="get_assign">
				SELECT * FROM asset_assign
				WHERE assigned_asset_code=<cfqueryparam value="#code#" cfsqltype="cf_sql_varchar">
			</cfquery>
			<cfif queryRecordCount(get_assign) GT 0>
				<cfquery name="assign">
					UPDATE asset_assign SET
					assigned_status=<cfqueryparam value="1" cfsqltype="cf_sql_integer">,
					employee_id=<cfqueryparam value="#decrypt(form.employee, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" cfsqltype="cf_sql_integer">,
					assigned_on = <cfqueryparam value="#dateTimeFormat(now())#" cfsqltype="cf_sql_timestamp">
					WHERE assigned_asset_code=<cfqueryparam value="#code#" cfsqltype="cf_sql_varchar">
				</cfquery>
			<cfelse>
				<cfquery name="in_asset" >
					INSERT INTO asset_assign SET
					employee_id=<cfqueryparam value="#decrypt(form.employee, 'RHMm64ACs6qftCFBz4j+5Q==', 'AES','HEX')#" cfsqltype="cf_sql_integer">,
					assigned_asset_code=<cfqueryparam value="#code#" cfsqltype="cf_sql_varchar">,
					assigned_on = <cfqueryparam value="#dateTimeFormat(now())#" cfsqltype="cf_sql_timestamp">,
					assigned_status=<cfqueryparam value="1" cfsqltype="cf_sql_integer">
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
	<!--- <cfquery name="update_status">
		UPDATE asset SET 
		status=<cfqueryparam value="1" cfsqltype="cf_sql_integer">
		WHERE asset_code=<cfqueryparam value="#form.asset_code#" cfsqltype="cf_sql_varchar">
	</cfquery> --->

	<cfreturn 1>
	
</cffunction>

<cffunction name="get_asset_type">
	<cfquery name="asset_type">
	SELECT * FROM asset_type
	</cfquery>
	<cfreturn asset_type>
</cffunction>

<cffunction name="get_processor">
	<cfquery name="processor">
	SELECT * FROM processor
	</cfquery>
	<cfreturn processor>
</cffunction>

<cffunction name="get_processor_type">
	<cfargument name="process" default="">
	<cfquery name="processor_type">
	SELECT * FROM processor_type
	WHERE 1=1
	<cfif structKeyExists(arguments, "process")>
		AND processor_id=<cfqueryparam value="#arguments.process#" cfsqltype="cf_sql_integer">
	</cfif>
	</cfquery>
	<cfreturn processor_type>
</cffunction>

<cffunction name="get_processor_generation">
	<cfquery name="processor_generation">
	SELECT * FROM processor_generation
	</cfquery>
	<cfreturn processor_generation>
</cffunction>

<cffunction name="get_vendor_details">
	<cfquery name="vendor_details">
	SELECT * FROM vendor
	</cfquery>
	<cfreturn vendor_details>
</cffunction>

<cffunction name="get_assets">
	<cfargument name="id" required="false">
	<cftry>
	<cfquery name="assets">
		SELECT A.*,T.*,V.*,ATY.name AS asset_name,ATY.id AS asset_id,B.name AS branch,V.name AS ven_name, AA.assigned_on, P.name AS Pro_name,PT.name AS Pro_type_name, PG.genaration AS gen FROM asset_type T
		LEFT JOIN asset A ON A.asset_type_id = T.id
		LEFT JOIN asset_type ATY ON ATY.id=A.asset_type_id
		LEFT JOIN processor P ON P.id=A.processor
		LEFT JOIN processor_type PT ON PT.id=A.processor_type
		LEFT JOIN processor_generation PG ON PG.id=A.processor_gen
		LEFT JOIN asset_assign AA ON AA.assigned_asset_code= A.asset_code
		LEFT JOIN vendor V ON V.id=A.vendor_id
		LEFT JOIN branch B ON B.id=A.branch_id
		WHERE 1=1
		AND A.id IS NOT NULL
		<cfif structKeyExists(arguments, "id") AND len(arguments.id)>
			AND A.id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfif>
	</cfquery>
	<cfcatch><cfreturn cfcatch> </cfcatch>
	</cftry>
	<cfreturn assets>
</cffunction>
<cffunction name="deletefiles" access="remote" returnformat="JSON">
	<cfargument name="filename" required="true">
	<cfargument name="folderid" required="true">
	<cftry>
		<cffile action="delete" file="#expandPath("../assets/Asset_files")#/#arguments.folderid#/#arguments.filename#">
		<cfcatch>
			<cfreturn cfcatch>
		</cfcatch>
	</cftry>
	<cfreturn "Deleted Successfully">

</cffunction>

<!--- update assets --->

<cffunction name="update_asset">
	<cfargument name="id" default="">
	<cftry>
		<cfset first3digit = left(form.make, 3)>
		<cfset last4digit = right(form.slno, 4)>
		<cfset asset_code = #uCase("#first3digit#-#last4digit#-#arguments.id#")#>
	
	<cfquery name="get_asset" >
		SELECT * FROM asset
		WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar"
	>
	</cfquery>
	<cfset barcode = "#asset_code#.png">
		<!--- <cfset image1 = "#asset_code#-1.png">
		<cfset image2 = "#asset_code#-2.png"> --->
	<cfset nowdatetime = now()>

<cfif structKeyExists(form, "file") AND form.file NEQ "" OR structKeyExists(form, "documents") AND form.documents NEQ "">

	<cfset uploadDir = "#expandPath("../assets/Asset_files")#/#arguments.id#">
    <cffile action="uploadAll" 
            destination="#uploadDir#"
            nameconflict="makeunique"
            result="files">


</cfif>
<!--- 
<cfif structKeyExists(form, "imagessrc") AND form.imagessrc NEQ "">

	<cffile action = "delete" file = "#expandPath("../images/Asset")#/#get_asset.images#" >
	<cffile action = "upload" destination = "#expandPath("../images/Asset")#/#image2#" 
			fileField = "#form.imagessrc#" 
			result = "result"
			nameConflict = "MakeUnique" >
</cfif> --->

<cfif get_asset.barcode_image NEQ barcode>

	<cffile action = "delete" file = "#expandPath("../images/barcode/#get_asset.barcode_image#")#" >

		<cfscript>

			code128= createobject("java","
				com.lowagie.text.pdf.Barcode128");
			code128.setCodeType(code128.CODE128);
			/* Set the code to generate */
			code128.setCode("#asset_code#");
			color =  createobject("java","java.awt.Color");
			image = code128.createAwtImage(color.black, color.white);
			bufferedImage = createObject("java", "java.awt.image.BufferedImage");
			bufferedImageType = bufferedImage.TYPE_BYTE_GRAY;
			bufferedImage = bufferedImage.init(image.getWidth(JavaCast("null", "")),image.getHeight(JavaCast("null", "")), bufferedImageType);
			graphics2D = bufferedImage.createGraphics();
			graphics2D.drawImage(image,0,0,JavaCast("null", ""));
			barcodeImage = imageNew(bufferedImage);

		</cfscript>

		<cfif NOT directoryExists("#expandPath("../images/barcode")#")>
			<cfdirectory action="create" directory="#expandPath("../images/barcode")#">
		</cfif>

		<cfimage source="#barcodeImage#" action="convert" destination="#expandPath("../images/barcode/#asset_code#.png")#">

</cfif>
		<cfquery name="asset" >
			UPDATE asset set
			asset_type_id=<cfqueryparam value="#form.asset_type#" cfsqltype="cf_sql_integer"/>,
			serial_number=<cfqueryparam value="#uCase(form.slno)#" cfsqltype="cf_sql_varchar"/>,
			model_number=<cfqueryparam value="#uCase(form.ModelNo)#" cfsqltype="cf_sql_varchar"/>,
			make=<cfqueryparam value="#uCase(form.make)#" cfsqltype="cf_sql_varchar"/>,
			asset_code=<cfqueryparam value="#asset_code#" cfsqltype="cf_sql_varchar">,
			image=<cfqueryparam value="null" cfsqltype="cf_sql_varchar">,
			images=<cfqueryparam value="null" cfsqltype="cf_sql_varchar">,
			updated_date=<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
			updated_by=<cfqueryparam value="#session.employee.id#" cfsqltype="cf_sql_integer">,
			<cfif structKeyExists(form, "processor") AND form.processor NEQ "">
				processor=<cfqueryparam value="#form.processor#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			<cfif structKeyExists(form, "processor_type") AND form.processor_type NEQ "">
				processor_type=<cfqueryparam value="#form.processor_type#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			<cfif structKeyExists(form, "generation") AND form.generation NEQ "">
				processor_gen=<cfqueryparam value="#form.generation#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			vendor_id=<cfqueryparam value="#form.vendor#" cfsqltype="cf_sql_integer"/>,
			<cfif structKeyExists(form, "start_warranty") AND form.start_warranty NEQ "">
				warranty_start_date=<cfqueryparam value="#dateFormat(form.start_warranty,"yyyy-mm-dd")#" cfsqltype="cf_sql_varchar">,
			</cfif>
			<cfif structKeyExists(form, "end_warranty") AND form.end_warranty NEQ "">
				warranty_end_date=<cfqueryparam value="#dateFormat(form.end_warranty,"yyyy-mm-dd")#" cfsqltype="cf_sql_varchar">,
			</cfif>
			<cfif structKeyExists(form, "ex_warranty") AND form.ex_warranty NEQ "">
				extended_warranty=<cfqueryparam value="#form.ex_warranty#" cfsqltype="cf_sql_varchar"/>,
			</cfif>
			<cfif structKeyExists(form, "branch") AND form.branch NEQ "">
				branch_id=<cfqueryparam value="#form.branch#" cfsqltype="cf_sql_integer">,
			</cfif>
			personal_asset=<cfqueryparam value="#form.personal#" cfsqltype="cf_sql_integer">,
			barcode_image = <cfqueryparam value="#barcode#" cfsqltype="cf_sql_varchar">
			WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		</cfquery>
		<cfreturn 1>
		<cfcatch><cfdump var="#cfcatch#" abort></cfcatch>
	</cftry>
	</cffunction>

<cffunction name="emp_asset">
	<cfargument name="id" default="">
	<cfquery name="emp_asset">
		SELECT A.*,T.*,V.*,ATY.name AS asset_name,ATY.id AS asset_id,B.name AS branch,
		V.name AS ven_name,P.name AS Pro_name,PT.name AS Pro_type_name,
		PG.genaration AS gen, E.first_name AS emp_first, E.last_name AS emp_last, AA.assigned_on
		FROM asset_type T
		LEFT JOIN asset A ON A.asset_type_id = T.id
		LEFT JOIN asset_type ATY ON ATY.id=A.asset_type_id
		LEFT JOIN processor P ON P.id=A.processor
		LEFT JOIN processor_type PT ON PT.id=A.processor_type
		LEFT JOIN processor_generation PG ON PG.id=A.processor_gen
		LEFT JOIN vendor V ON V.id=A.vendor_id
		LEFT JOIN branch B ON B.id=V.branch_id
		LEFT JOIN asset_assign AA ON AA.assigned_asset_code= A.asset_code
		LEFT JOIN employee E ON E.id = AA.employee_id
		WHERE 1=1
		<cfif structKeyExists(arguments, "id") AND arguments.id NEQ "">
			AND AA.employee_id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
		<cfelse>
			AND AA.employee_id IS NOT null
		</cfif>
		ORDER BY AA.employee_id
	</cfquery>
	<cfreturn emp_asset>
</cffunction>

<cffunction name="get_branch_details">
	<cfquery name="branch_details">
		SELECT * FROM branch
	</cfquery>
	<cfreturn branch_details>
</cffunction>

</cfcomponent>
