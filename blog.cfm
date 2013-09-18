<cfInclude template="header.cfm">

<cfquery name="getPosts" datasource="#application.datasource#">
	SELECT	pst.pstId, pst.pstTitle, pst.pstText, pst.pstCreationDate, pst.pstPublishDate, pst.pstStatus, pst.pscId, pst.usrId,
			usr.usrFName, usr.usrLName,
			psc.pscName
	FROM posts pst
		INNER JOIN users usr ON usr.usrId = pst.usrId
		INNER JOIN posts_categories psc ON psc.pscId = pst.pscId
	WHERE pst.pstStatus = 1
	ORDER BY pst.pstPublishDate DESC
</cfquery>

<div id="custom-header">
	<ul class="breadcrumb">
		<li class="active">Blog</li>
	</ul>
</div>

<cfif getPosts.recordCount gt 0>
	<cfoutput query="getPosts">
		<div class="container">
			<div class="row">
				<div class="span4">
					<h4 class="text-success">#pscName# - #pstTitle#</h4>
					<p>#pstText#</p>
					
					<strong>Author:</strong> #usrFName# #usrLName# in #DateFormat(pstPublishDate, "mm/dd/yyyy")#
					
				</div>
			</div>
		</div>

		<cfif currentRow LT recordCount>
			<hr>
		</cfif>		
	</cfoutput>
<cfelse>
	<div class="container">
		<div class="row">
			<div class="span4">
				<p>No entries yet.</p>
			</div>
		</div>
	</div>
</cfif>

<cfInclude template="footer.cfm">