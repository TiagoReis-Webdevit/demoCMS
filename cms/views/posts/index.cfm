<cfset variables.getPosts = this.getBind('getPosts')>
<cfset variables.getPostCats = this.getBind('getPostCats')>

<div id="custom-header">
	<cfoutput>
		<ul class="breadcrumb">
			<li class="active">#this.getTitle()#</li>
		</ul>
		<div class="btn-group pull-right btn_page_title">
			<a class="btn dropdown-toggle btn-info" data-toggle="dropdown" href="##">
				Options
				<span class="caret"></span>
			</a>
			<ul class="dropdown-menu">
				<li><a href="#application.url#/posts/add/">Add Post</a></li>
			</ul>
		</div>
	</cfoutput>
</div>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pageContent">
<tr><td colspan="4">
	<cfif variables.getPosts.recordCount gt 0>
		<form method="post" name="form" id="form">
		<input type="hidden" name="pageAction" id="pageAction" value="1">
		<input type="hidden" name="pkId" id="pkId" value="">

		<table class="table table-striped">
		<thead>
			<tr>
				<th>Id</th>
				<th>Title</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="variables.getPosts">
				<tr><td>
					#pstId#
				</td><td>
					#pstTitle#
				</td><td>
					<input type="button" class="btn btn btn-info" name="btnFrmSubmit" value="Detail" onClick="detail_record(#pstId#);">
					<input type="button" class="btn btn btn-danger" name="btnFrmSubmit" value="Delete" onClick="delete_record(#pstId#);">
				</td></tr>
			</cfoutput>
		</tbody>
		</table>
		</form>
	</cfif>
</td></tr>
</table>