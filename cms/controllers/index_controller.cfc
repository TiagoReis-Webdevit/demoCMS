<cfcomponent output="no" accessors="true">
	<cffunction name="init" access="public">
		<cfargument name="action" type="string" required="no" default="index">
		<cfargument name="id" type="string" required="no" default="0">

		<cfswitch expression="#arguments.action#">
			<cfcase value="index"><cfset this.index()></cfcase>
		</cfswitch>

		<cfreturn this>
	</cffunction>

	<cffunction name="index" access="public">
		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Dashboard', view = 'dashboard.cfm')>
		<cfset variables.pageView.show()>
	</cffunction>
</cfcomponent>