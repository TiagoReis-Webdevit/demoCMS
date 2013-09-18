<cfcomponent output="no" accessors="true">
	<cfproperty name="usrId" type="numeric" default="0">
	<cfproperty name="usrFName" type="string" default="">
	<cfproperty name="usrLName" type="string" default="">
	<cfproperty name="usrEmail" type="string" default="">
	<cfproperty name="usrPassword" type="string" default="">
	<cfproperty name="usrAdmin" type="numeric" default="0">

	<cfproperty name="error" type="numeric" default="0">
	<cfproperty name="message" type="string" default="">

	<cffunction name="init" access="public">
		<cfargument name="pk" type="numeric" default="0" required="no">

		<cfif arguments.pk gt "0">
			<cfset this.read(arguments.pk)>
		</cfif>

		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" output="no">
		<cfset this.setError(0)>
		<cfset this.setMessage('')>
		<cfset this.setUsrAdmin(0)>

		<cftry>
			<cfquery name="save" datasource="#application.datasource#">
				INSERT INTO users (usrFName, usrLName, usrEmail, usrPassword, usrAdmin)
				VALUES ('#this.getUsrFName()#', '#this.getUsrLName()#', '#this.getUsrEmail()#', '#this.getUsrPassword()#', #this.getUsrAdmin()#);
			</cfquery>

			<cfquery name="save" datasource="#application.datasource#">
				SELECT LAST_INSERT_ID() AS pk
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>

				<cfif findNoCase('usrEmail_UNIQUE', cfcatch.Detail)>
					<cfset this.setMessage('There can only be one email "#this.getUsrEmail()#" in the system. Operation canceled!', '2')>
				<cfelse>
					<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				</cfif>
				
				<!--- reset object data --->
				<cfset this.init(this.getUsrId())>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfset this.setUsrId(save.pk)>
		<cfreturn>
	</cffunction>

	<cffunction name="update" access="public" output="no">
		<cfset this.setError(0)>
		<cfset this.setMessage('')>

		<cftry>
			<cfquery name="update" datasource="#application.datasource#">
				UPDATE users SET
					usrFName = '#this.getUsrFName()#',
					usrLName = '#this.getUsrLName()#',
					usrEmail = '#this.getUsrEmail()#',
					usrPassword = '#this.getUsrPassword()#'
				WHERE usrId = #this.getUsrId()#
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>

				<cfif findNoCase('usrEmail_UNIQUE', cfcatch.Detail)>
					<cfset this.setMessage('There can only be one email "#this.getUsrEmail()#" in the system. Operation canceled!', '2')>
				<cfelse>
					<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				</cfif>
				
				<!--- reset object data --->
				<cfset this.init(this.getUsrId())>
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
				DELETE FROM users WHERE usrId = #this.getUsrId()#
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>
				<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				
				<!--- reset object data --->
				<cfset this.init(this.getUsrId())>
				<cfreturn>
			</cfcatch>
		</cftry>
		<cfreturn>
	</cffunction>

	<cffunction name="read" access="public" output="no">
		<cfargument name="pk" type="numeric" required="no">
		<cfargument name="usrEmail" type="string" required="no">
		<cfargument name="usrPassword" type="string" required="no">

		<cfquery name="get" datasource="#application.datasource#">
			SELECT usrId, usrFName, usrLName, usrEmail, usrPassword, usrAdmin
			FROM users
			WHERE 1 = 1
				<cfif isDefined("arguments.pk")>
					AND usrId = #arguments.pk#
				</cfif>
				<cfif isDefined("arguments.usrEmail") and isDefined("arguments.usrPassword")>
					AND usrEmail = '#arguments.usrEmail#'
					AND usrPassword = '#arguments.usrPassword#'
				</cfif>
		</cfquery>

		<cfif get.recordCount gt 0>
			<cfset this.setUsrId(get.usrId)>
			<cfset this.setUsrFName(get.usrFName)>
			<cfset this.setUsrLName(get.usrLName)>
			<cfset this.setUsrEmail(get.usrEmail)>
			<cfset this.setUsrPassword(get.usrPassword)>
			<cfset this.setUsrAdmin(get.usrAdmin)>
		</cfif>
	</cffunction>

	<cffunction name="readAll" access="public" output="no">
		<cfargument name="usrEmail" type="string" required="no" default="">
		<cfargument name="usrPassword" type="string" required="no" default="">

		<cfquery name="get" datasource="#application.datasource#">
			SELECT usrId, usrFName, usrLName, usrEmail, usrPassword, usrAdmin
			FROM users
			WHERE 1 = 1
			<cfif arguments.usrEmail neq "">AND usrEmail = '#arguments.usrEmail#'</cfif>
			<cfif arguments.usrPassword neq "">AND usrPassword = '#arguments.usrPassword#'</cfif>
		</cfquery>

		<cfreturn get>
	</cffunction>
</cfcomponent>