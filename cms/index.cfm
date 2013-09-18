<!---<cfif not IsDefined("session.mvc.controller")>
	<cfset session.mvc.controller = CreateObject('component', 'mvc.controller')>
</cfif>

<cfset session.mvc.controller.init(CGI.PATH_INFO)>
--->

<cfset variables.controller = CreateObject('component', 'mvc.controller').init(CGI.PATH_INFO)>