<cfcomponent output="no" accessors="true">
	<cffunction name="init" access="public">
		<cfargument name="action" type="string" required="no" default="index">
		<cfargument name="pkId" type="string" required="no" default="0">

		<cfswitch expression="#arguments.action#">
			<cfcase value="index"><cfset this.index()></cfcase>
			<cfcase value="add"><cfset this.add()></cfcase>
			<cfcase value="detail"><cfset this.detail(arguments.pkId)></cfcase>
		</cfswitch>

		<cfreturn this>
	</cffunction>

	<cffunction name="add" access="public">
		<cfset variables.postCat = CreateObject("component", "models.postCats_model").init()>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to save --->
			<cfif form.pageAction eq 1>
				<cfset variables.postCat.setPscName(trim(form.pscName))>
				<cfset variables.postCat.save()>
				
				<!--- If save was sucessfully --->
				<cfif variables.postCat.getError() eq 0>
					<cfset session.message.set("Post category was saved!", "1")>
					<cflocation url="#application.url#/postCats/detail/#variables.postCat.getPscId()#/" addtoken="no">
				<!--- If an error ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.postCat.getMessage(), "2")>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Post Categories: New', view = 'postCats/add.cfm')>
		<cfset variables.pageView.setBind('postCat', variables.postCat)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="detail">
		<cfargument name="pkId" type="numeric" required="yes">

		<cfset variables.postCat = CreateObject("component", "models.postCats_model").init(pk = arguments.pkId)>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to update --->
			<cfif form.pageAction eq 1>
				<cfset variables.postCat.setPscName(trim(form.pscName))>
				<cfset variables.postCat.update()>
				
				<!--- If update was sucessfully --->
				<cfif variables.postCat.getError() eq 0>
					<cfset session.message.set("Post category was updated!", "1")>
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.postCat.getMessage(), "2")>
				</cfif>
			<!--- If action is to delete --->
			<cfelseif form.pageAction eq 0>
				<cfset variables.postCat.delete()>

				<!--- If delete was sucessfully --->
				<cfif variables.postCat.getError() eq 0>
					<cfset session.message.set("Post category was deleted!", "1")>
					<cflocation url="#application.url#/postCats/" addtoken="no">
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.postCat.getMessage(), "2")>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Post Categories: Detail', view = 'postCats/detail.cfm')>
		<cfset variables.pageView.setBind('postCat', variables.postCat)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="index" access="public">
		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to go to detail --->
			<cfif form.pageAction eq 1>
				<!--- If pk has a value --->
				<cfif form.pkId NEQ "">
					<cflocation url="#application.url#/postCats/detail/#form.pkId#/" addtoken="no">
				</cfif>
			<!--- If action is to delete --->
			<cfelseif form.pageAction eq 0>
				<!--- If pk has a value --->
				<cfif form.pkId NEQ "">
					<cfset variables.postCat = CreateObject("component", "models.postCats_model").init(pk = form.pkId)>
					<cfset variables.postCat.delete()>

					<!--- If delete was sucessfully --->
					<cfif variables.postCat.getError() eq 0>
						<cfset session.message.set("Post category was deleted!", "1")>
					<!--- If an error has ocorrued --->
					<cfelse>
						<cfset session.message.set(variables.postCat.getMessage(), "2")>
					</cfif>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.postCats = CreateObject("component", "models.postCats_model").init().readAll()>
		
		<!--- if there are no data, return msg --->
		<cfif variables.postCats.recordCount eq 0>
			<cfset session.message.set('No results found!', '0')>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Post Categories: Search', view = 'postCats/index.cfm')>
		<cfset variables.pageView.setBind('getPostCats', variables.postCats)>
		<cfset variables.pageView.show()>
	</cffunction>
</cfcomponent>