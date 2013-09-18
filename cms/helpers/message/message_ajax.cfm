<cfprocessingdirective suppresswhitespace="yes" pageencoding="utf-8">
<cfsetting showdebugoutput="no" enablecfoutputonly="yes">
<cfcontent type="text/xml">

<cfxml casesensitive="yes" variable="xmlOutput">
	<cfoutput>
		<root>
			<message>#XMLFormat(session.message.getText())#</message>
			<importance>#XMLFormat(session.message.getImportance())#</importance>
		</root>
	</cfoutput>
</cfxml>

<cfset session.message.clear()>

<cfoutput>#variables.xmlOutput#</cfoutput>
</cfprocessingdirective>