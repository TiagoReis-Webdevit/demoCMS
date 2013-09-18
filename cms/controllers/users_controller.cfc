<cfcomponent output="no" accessors="true">
	<cffunction name="init" access="public">
		<cfargument name="action" type="string" required="no" default="index">
		<cfargument name="pkId" type="string" required="no" default="0">

		<!--- If user is not an administrator --->
		<cfif listFind('add,detail,index', arguments.action) and session.cstData.getUsrAdmin() eq 0>
			<!--- If current page call is add or index or is detail but pkId is not current user id --->
			<cfif listFind('add,index', arguments.action) gt 0 or (arguments.action eq 'detail' and arguments.pkId neq session.cstData.getUsrId())>
				<cfset session.message.set('You do not have access rights to requested page!', '2')>
				<cflocation url="#application.url#" addtoken="no">
			</cfif>
		</cfif>

		<cfswitch expression="#arguments.action#">
			<cfcase value="index"><cfset this.index()></cfcase>
			<cfcase value="add"><cfset this.add()></cfcase>
			<cfcase value="detail"><cfset this.detail(arguments.pkId)></cfcase>
			<cfcase value="login"><cfset this.login()></cfcase>
			<cfcase value="logout"><cfset this.logout()></cfcase>
		</cfswitch>

		<cfreturn this>
	</cffunction>

	<cffunction name="add" access="public">	
		<cfset variables.user = CreateObject("component", "models.users_model").init()>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to save --->
			<cfif form.pageAction eq 1>
				<cfset variables.user.setUsrFName(trim(form.usrFName))>
				<cfset variables.user.setUsrLName(trim(form.usrLName))>
				<cfset variables.user.setUsrEmail(trim(form.usrEmail))>
				<cfset variables.user.setUsrPassword(trim(form.usrPassword))>
				<cfset variables.user.save()>
				
				<!--- If save was sucessfully --->
				<cfif variables.user.getError() eq 0>
					<cfset session.message.set("User was saved!", "1")>
					<cflocation url="#application.url#/users/detail/#variables.user.getUsrId()#/" addtoken="no">
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.user.getMessage(), "2")>
					<cfdump var="#session.message#">
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Users: New', view = 'users/add.cfm')>
		<cfset variables.pageView.setBind('user', variables.user)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="detail">
		<cfargument name="pkId" type="numeric" required="yes">

		<cfset variables.user = CreateObject("component", "models.users_model").init(pk = arguments.pkId)>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to update --->
			<cfif form.pageAction eq 1>
				<cfset variables.user.setUsrFName(trim(form.usrFName))>
				<cfset variables.user.setUsrLName(trim(form.usrLName))>
				<cfset variables.user.setUsrEmail(trim(form.usrEmail))>
				<cfset variables.user.setUsrPassword(trim(form.usrPassword))>
				<cfset variables.user.update()>

				<!--- If update was sucessfully --->
				<cfif variables.user.getError() eq 0>
					<cfset session.message.set("User was updated!", "1")>
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.user.getMessage(), "2")>
				</cfif>
			<!--- If action is to delete --->
			<cfelseif form.pageAction eq 0>
				<cfset variables.user.delete()>
				
				<!--- If delete was sucessfully --->
				<cfif variables.user.getError() eq 0>
					<cfset session.message.set("User was deleted!", "1")>
					<cflocation url="#application.url#/users/" addtoken="no">
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set(variables.user.getMessage(), "2")>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Users: Detail', view = 'users/detail.cfm')>
		<cfset variables.pageView.setBind('user', variables.user)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="index" access="public">
		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to go to detail --->
			<cfif form.pageAction eq 1>
				<!--- If pk has value --->
				<cfif form.pkId NEQ "">
					<cflocation url="#application.url#/users/detail/#form.pkId#/" addtoken="no">
				</cfif>
			<!--- If action is to delete --->
			<cfelseif form.pageAction eq 0>
				<!--- If pk has value --->
				<cfif form.pkId NEQ "">
					<cfset variables.user = CreateObject("component", "models.users_model").init()>
					<cfset variables.user.setUsrId(form.pkId)>
					<cfset variables.user.delete()>

					<!--- If delete was sucessfully --->
					<cfif variables.user.getError() eq 0>
						<cfset session.message.set("User was deleted!", "1")>
						<cflocation url="#application.url#/users/" addtoken="no">
					<!--- If an error has ocorrued --->
					<cfelse>
						<cfset session.message.set(variables.user.getMessage(), "2")>
					</cfif>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.users = CreateObject("component", "models.users_model").init().readAll()>

		<!--- if there are no data, return msg --->
		<cfif variables.users.recordCount eq 0>
			<cfset session.message.set('No results found!', '0')>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Users: Search', view = 'users/index.cfm')>
		<cfset variables.pageView.setBind('getUsers', variables.users)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="login" access="public">
		<cfset variables.user = CreateObject("component", "models.users_model").init()>

		<!--- If page was submited --->
		<cfif isDefined("form.pageAction")>
			<!--- If action is to login --->
			<cfif form.pageAction eq 1>
				<cfparam name="form.userEmail" type="string" default="">
				<cfparam name="form.userPassword" type="string" default="">

				<cfset variables.user.read(usrEmail = trim(form.userEmail), usrPassword = trim(form.userPassword))>

				<!--- If login was sucessfully --->
				<cfif variables.user.getUsrId() gt 0>
					<cfset session.cstData = variables.user>

					<cfset session.message.set("Welcome", "0")>
					<cflocation url="#application.url#" addtoken="no">
				<!--- If an error has ocorrued --->
				<cfelse>
					<cfset session.message.set("Email or password is incorrect!", "2")>
				</cfif>
			</cfif>
		</cfif>

		<cfset variables.pageView = CreateObject('component', 'mvc.view').init(title = 'Users: Login', view = 'users/login.cfm')>
		<cfset variables.pageView.setBind('user', variables.user)>
		<cfset variables.pageView.show()>
	</cffunction>

	<cffunction name="logout" access="public">
		<cfset structDelete(session, 'cstData')>
		<cfset session.message.set("Goodbye!", "0")>
		<cflocation url="#application.url#" addtoken="no">
	</cffunction>
</cfcomponent>