<cfcomponent output="no" accessors="true">
	<cfproperty name="controller" type="string" default="index">
	<cfproperty name="action" type="string" default="index">
	<cfproperty name="id" type="numeric" default="0">

	<cffunction name="init" access="public">
		<cfargument name="path" type="string" default="" required="no">

		<cfset this.setController('index')>
		<cfset this.setAction('index')>
		<cfset this.setId(0)>

		<cfset variables.pathLen = listLen(arguments.path, '/')>

		<cfif listlen(variables.pathLen, '/') gt 0>
			<cfif variables.pathLen gte "3">
				<cfset this.setId(listLast(arguments.path, '/'))>
			</cfif>

			<cfif variables.pathLen gte 2>
				<cfset this.setAction(listGetAt(arguments.path, 2, '/'))>
			</cfif>

			<cfif variables.pathLen gte 1>
				<cfset this.setController(listFirst(arguments.path, '/'))>
			</cfif>
		</cfif>

		<cfif fileExists("#application.root#controllers\#this.getController()#_controller.cfc")>
			<cfset variables.controller = CreateObject("component", "controllers.#this.getController()#_controller").init(action = this.getAction(), pkId = this.getId())>
		<cfelse>
			<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Page not Found', view = 'pageNotFound.cfm')>
			<cfset variables.pageView.show()>
		</cfif>

		<cfreturn this>
	</cffunction>
</cfcomponent>