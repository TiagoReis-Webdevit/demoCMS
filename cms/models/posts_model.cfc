<cfcomponent output="no" accessors="true">
	<cfproperty name="pstId" type="numeric" default="0">
	<cfproperty name="pstTitle" type="string" default="">
	<cfproperty name="pstText" type="string" default="">
	<cfproperty name="pstCreationDate" type="string" default="">
	<cfproperty name="pstPublishDate" type="string" default="">
	<cfproperty name="pstStatus" type="numeric" default="">
	<cfproperty name="pscId" type="int" default="">
	<cfproperty name="usrId" type="int" default="">

	<cfproperty name="error" type="numeric" default="0">
	<cfproperty name="message" type="string" default="">

	<cffunction name="init" access="public" output="no">
		<cfargument name="pk" type="numeric" default="0" required="no">

		<cfif arguments.pk gt "0">
			<cfset this.read(arguments.pk)>
		</cfif>

		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" output="no">
		<cfset this.setPstCreationDate(NOW())>
		<cfset this.setPstPublishDate('')>
		<cfset this.setPstStatus(0)>

		<cfset this.setError(0)>
		<cfset this.setMessage('')>

		<cftry>
			<cfquery name="save" datasource="#application.datasource#">
				INSERT INTO posts (pstTitle, pstText, pstCreationDate, pstPublishDate, pstStatus, pscId, usrId)
				VALUES ('#this.getPstTitle()#', '#this.getPstText()#', #CreateODBCDate(this.getPstCreationDate())#, NULL, #this.getPstStatus()#, #this.getPscId()#, #this.getUsrId()#);
			</cfquery>

			<cfquery name="save" datasource="#application.datasource#">
				SELECT LAST_INSERT_ID() AS pk
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>
				<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				
				<!--- reset object data --->
				<cfset this.init(this.getPstId())>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfset this.setPstId(save.pk)>
		<cfreturn>
	</cffunction>

	<cffunction name="update" access="public" output="no">
		<cfswitch expression="#this.getPstStatus()#">
			<cfcase value="0"><cfset this.setPstPublishDate('NULL')></cfcase>
			<cfcase value="1"><cfset this.setPstPublishDate(CreateODBCDate(NOW()))></cfcase>
		</cfswitch>

		<cfset this.setError(0)>
		<cfset this.setMessage('')>

		<cftry>
			<cfquery name="update" datasource="#application.datasource#">
				UPDATE posts SET
					pstTitle = '#this.getPstTitle()#',
					pstText = '#this.getPstText()#',
					pstPublishDate = #this.getPstPublishDate()#,
					pstStatus = #this.getPstStatus()#,
					pscId = #this.getPscId()#
				WHERE pstId = #this.getPstId()#
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>
				<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				
				<!--- reset object data --->
				<cfset this.init(this.getPstId())>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfreturn>
	</cffunction>

	<cffunction name="delete" access="public" output="no">
		<cfset this.setError(0)>
		<cfset this.setMessage('')>

		<cftry>
			<cfquery name="delete" datasource="#application.datasource#">
				DELETE FROM posts WHERE pstId = #this.getPstId()#
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>
				<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				
				<!--- reset object data --->
				<cfset this.init(this.getPstId())>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfreturn>
	</cffunction>

	<cffunction name="read" access="public" output="no">
		<cfargument name="pk" type="numeric" default="0" required="yes">

		<cfquery name="get" datasource="#application.datasource#">
			SELECT pstId, pstTitle, pstText, pstCreationDate, pstPublishDate, pstStatus, pscId, usrId
			FROM posts
			WHERE pstId = #arguments.pk#
		</cfquery>

		<cfset this.setPstId(get.pstId)>
		<cfset this.setPstTitle(get.pstTitle)>
		<cfset this.setPstText(get.pstText)>
		<cfset this.setPstCreationDate(get.pstCreationDate)>
		<cfset this.setPstPublishDate(get.pstPublishDate)>
		<cfset this.setPstStatus(get.pstStatus)>
		<cfset this.setPscId(get.pscId)>
		<cfset this.setUsrId(get.usrId)>
	</cffunction>

	<cffunction name="readAll" access="public" output="no">
		<cfquery name="get" datasource="#application.datasource#">
			SELECT pstId, pstTitle, pstText, pstCreationDate, pstPublishDate, pstStatus, pscId, usrId
			FROM posts
		</cfquery>

		<cfreturn get>
	</cffunction>

</cfcomponent>