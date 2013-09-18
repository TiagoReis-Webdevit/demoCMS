<cfcomponent output="no" accessors="true">
	<cfproperty name="title" type="string" default="">
	<cfproperty name="view" type="string" default="">

	<cfset params = []>

	<cffunction name="init" access="public">
		<cfargument name="title" type="string" required="no" default="">
		<cfargument name="view" type="string" required="no" default="">

		<cfset this.setTitle(arguments.title)>
		<cfset this.setView(arguments.view)>

		<cfset params = []>

		<cfreturn this>
	</cffunction>

	<cffunction name="setBind" access="public">
		<cfargument name="paramName" type="string" required="yes">
		<cfargument name="paramValue" type="any" required="yes">

		<cfset param = StructNew()>
		<cfset param.name = arguments.paramName>
		<cfset param.value = arguments.paramValue>

		<cfset ArrayAppend(params, param)>
	</cffunction>

	<cffunction name="getBind" access="public">
		<cfargument name="paramName" type="string" required="yes">

		<cfloop from="1" to="#arrayLen(params)#" index="cParamPos">
			<cfif params[cParamPos].name eq paramName>
				<cfreturn params[cParamPos].value>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="show" access="public">
		<cfinclude template="../views/header.cfm">
		<cfinclude template="../views/#view#">
		<cfinclude template="../views/footer.cfm">
	</cffunction>
</cfcomponent>