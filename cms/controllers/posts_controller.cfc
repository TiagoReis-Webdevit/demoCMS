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
		<cfset variables.post = CreateObject("component", "models.posts_model").init()>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to save --->
			<cfif form.pageAction eq 1>
				<cfset variables.post.setPstTitle(trim(form.pstTitle))>
				<cfset variables.post.setPscId(form.pscId)>
				<cfset variables.post.setPstText(trim(form.pstText))>
				<cfset variables.post.setUsrId(session.cstData.getUsrId())>
				<cfset variables.post.save()>

				<!--- If save was sucessfully --->
				<cfif variables.post.getError() eq 0>
					<cfset session.message.set("Post category was saved!", "1")>
					<cflocation url="#application.url#/posts/detail/#variables.post.getPstId()#/" addtoken="no">
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.post.getMessage(), "2")>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.postCats = CreateObject("component", "models.postCats_model").init().readAll()>
		
		<cfif variables.postCats.recordCount eq 0>
			<cfset session.message.set('Please had some categories, before adding posts!', '2')>
			<cflocation url="#application.url#/posts/" addtoken="no">
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Posts: New', view = 'posts/add.cfm')>
		<cfset variables.pageView.setBind("post", variables.post)>
		<cfset variables.pageView.setBind("getPostCats", variables.postCats)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="detail">
		<cfargument name="pkId" type="numeric" required="yes">

		<cfset variables.post = CreateObject("component", "models.posts_model").init(pk = arguments.pkId)>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to update --->
			<cfif form.pageAction eq 1>
				<cfset variables.post.setPstTitle(trim(form.pstTitle))>
				<cfset variables.post.setPscId(form.pscId)>
				<cfset variables.post.setPstText(trim(form.pstText))>
				<cfset variables.post.setPstStatus(form.pstStatus)>
				<cfset variables.post.update()>

				<!--- If update was sucessfully --->
				<cfif variables.post.getError() eq 0>
					<cfset session.message.set("Post category was updated!", "1")>
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.post.getMessage(), "2")>
				</cfif>
			<!--- If action is to delete data --->
			<cfelseif form.pageAction eq 0>
				<cfset variables.post.delete()>

				<!--- If delete was sucessfully --->
				<cfif variables.post.getError() eq 0>
					<cfset session.message.set("Post category was deleted!", "1")>
					<cflocation url="#application.url#/posts/" addtoken="no">
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.post.getMessage(), "2")>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.postCats = CreateObject("component", "models.postCats_model").init()>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Posts: Detail', view = 'posts/detail.cfm')>
		<cfset variables.pageView.setBind('post', variables.post)>
		<cfset variables.pageView.setBind('getPostCats', variables.postCats.readAll())>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="index" access="public">
		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action it to go to detail --->
			<cfif form.pageAction eq 1>
				<!--- If pk has a value --->
				<cfif form.pkId NEQ "">
					<cflocation url="#application.url#/posts/detail/#form.pkId#/" addtoken="no">
				</cfif>
			<!--- If action is to delete --->
			<cfelseif form.pageAction eq 0>			
				<!--- If pk has a value --->
				<cfif form.pkId NEQ "">
					<cfset variables.post = CreateObject("component", "models.posts_model").init(pk = form.pkId)>
					<cfset variables.post.delete()>

					<!--- If delete was sucessfully --->
					<cfif variables.post.getError() eq 0>
						<cfset session.message.set("Post was deleted!", "1")>
					<!--- If an error has ocorrued --->
					<cfelse>
						<cfset session.message.set(variables.post.getMessage(), "2")>
					</cfif>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.getPosts = CreateObject("component", "models.posts_model").init().readAll()>
		<cfset variables.getPostCats = CreateObject("component", "models.postCats_model").init().readAll()>
		
		<!--- if there are no data, return msg --->
		<cfif variables.getPosts.recordCount eq 0>
			<cfset session.message.set('No results found!', '0')>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Posts: Search', view = 'posts/index.cfm')>
		<cfset variables.pageView.setBind('getPosts', variables.getPosts)>
		<cfset variables.pageView.setBind('getPostCats', variables.getPostCats)>
		<cfset variables.pageView.show()>
	</cffunction>
</cfcomponent>