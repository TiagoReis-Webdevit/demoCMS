<cfcomponent output="no" accessors="true">
	<cfproperty name="pscId" type="numeric" default="0">
	<cfproperty name="pscName" type="string" default="">

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

		<cftry>
			<cfquery name="save" datasource="#application.datasource#">
				INSERT INTO posts_categories (pscName)
				VALUES ('#this.getPscName()#')
			</cfquery>

			<cfquery name="save" datasource="#application.datasource#">
				SELECT LAST_INSERT_ID() AS pk
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>

				<cfif findNoCase('pscName_UNIQUE', cfcatch.Detail)>
					<cfset this.setMessage('There can only be one category "#this.getPscName()#" in the system. Operation canceled!', '2')>
				<cfelse>
					<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				</cfif>

				<!--- reset object data --->
				<cfset this.init()>
				
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfset this.setPscId(save.pk)>
		<cfreturn>
	</cffunction>

	<cffunction name="update" access="public" output="no">
		<cfset this.setError(0)>
		<cfset this.setMessage('')>

		<cftry>
			<cfquery name="update" datasource="#application.datasource#">
				UPDATE posts_categories SET
					pscName = '#this.getPscName()#'
				WHERE pscId = #this.getPscId()#
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>

				<cfif findNoCase('pscName_UNIQUE', cfcatch.Detail)>
					<cfset this.setMessage('There can only be one category "#this.getPscName()#" in the system. Operation canceled!', '2')>
				<cfelse>
					<cfset this.setMessage(XmlFormat(cfcatch.Detail), '2')>
				</cfif>
				
				<!--- reset object data --->
				<cfset this.init(this.getPscId())>

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
				DELETE FROM posts_categories
				WHERE pscId = #this.getPscId()#
			</cfquery>

			<cfcatch type="database">
				<cfset this.setError(1)>
				<cfset this.setMessage(XmlFormat(cfcatch.detail), '2')>
				
				<!--- reset object data --->
				<cfset this.init(this.getPscId())>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfreturn>
	</cffunction>

	<cffunction name="read" access="public" output="no">
		<cfargument name="pk" type="numeric" default="0" required="yes">

		<cfquery name="get" datasource="#application.datasource#">
			SELECT pscId, pscName
			FROM posts_categories
			WHERE pscId = #arguments.pk#
		</cfquery>

		<cfset this.setPscId(get.pscId)>
		<cfset this.setPscName(get.pscName)>
	</cffunction>

	<cffunction name="readAll" access="public" output="no">
		<cfquery name="get" datasource="#application.datasource#">
			SELECT pscId, pscName FROM posts_categories
		</cfquery>

		<cfreturn get>
	</cffunction>
</cfcomponent>