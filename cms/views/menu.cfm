<cfoutput>	
	<ul class="nav">
		<li><a href="#application.url#/">Dashboard</a></li>
		<li><a href="#application.url#/posts/">Posts</a></li>
		<li><a href="#application.url#/postCats/">Post Categories</a></li>
		<cfif session.cstData.getUsrAdmin() eq 1>
			<li><a href="#application.url#/users/">Users</a></li>
		</cfif>
		<li><a href="#application.url#/users/detail/#session.cstData.getUsrId()#/">Own Detail</a></li>
		<li><a href="#application.url#/users/logout/">Sign Out</a></li>
	</ul>
</cfoutput>