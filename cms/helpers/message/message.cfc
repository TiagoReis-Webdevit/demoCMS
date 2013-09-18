<cfcomponent output="no" accessors="true">
	<cfproperty name="text" type="string" default="">
	<cfproperty name="importance" type="numeric" default="2">

	<cffunction name="init" access="public">
		<cfreturn this>
	</cffunction>

	<cffunction name="set" access="public">
		<cfargument name="text" type="string" required="yes">
		<cfargument name="importance" type="numeric" required="yes">

		<cfset this.setText(arguments.text)>
		<cfset this.setImportance(arguments.importance)>
	</cffunction>

	<cffunction name="clear" access="public">
		<cfset this.setText('')>
		<cfset this.setImportance(2)>
	</cffunction>
</cfcomponent>