<cfcomponent>
 	<!--- Define application settings. --->
	<cfset THIS.ApplicationTimeout = CreateTimeSpan( 0, 0, 5, 0 )>
	<cfset THIS.SessionManagement = true>
	<cfset THIS.SessionTimeout = CreateTimeSpan( 0, 0, 0, 20 )>
	<cfset this.name = hash( getCurrentTemplatePath() ) />

	<cffunction name="OnApplicationStart">
		<cfif findNoCase('localhost', CGI.SERVER_NAME)>
			<cfset application.datasource = "mycms">
			<cfset application.name = "Coldfusion Content Management System">
			<cfset application.root = getDirectoryFromPath(expandPath(CGI.SCRIPT_NAME))>
			<cfset application.urlPath = "http://localhost:81/cms/">
			<cfset application.url = "http://localhost:81/cms/index.cfm">
		<cfelse>
			<cfset application.datasource = "demoCMS">
			<cfset application.name = "Coldfusion Content Management System">
			<cfset application.root = getDirectoryFromPath(expandPath(CGI.SCRIPT_NAME))>
			<cfset application.urlPath = "http://cmsdemo.web-developer-it.com/cms/">
			<cfset application.url = "http://cmsdemo.web-developer-it.com/cms/index.cfm">
		</cfif>
	</cffunction>

	<cffunction name="OnRequestStart">

	</cffunction>

	<cffunction name="OnRequestEnd">

	</cffunction>
</cfcomponent>