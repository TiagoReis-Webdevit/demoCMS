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
				<li><a href="#application.url#/postCats/add/">Add Post Category</a></li>
			</ul>
		</div>
	</cfoutput>
</div>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="pageContent">
<tr><td colspan="4">
	<cfif variables.getPostCats.recordCount gt 0>
		<form method="post" name="form" id="form">
		<input type="hidden" name="pageAction" id="pageAction" value="1">
		<input type="hidden" name="pkId" id="pkId" value="">

		<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>Name</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="variables.getPostCats">
				<tr><td align="center">
					#pscId#
				</td><td>
					#pscName#
				</td><td>
					<input type="button" class="btn btn btn-info" name="btnFrmSubmit" value="Detail" onClick="detail_record(#pscId#);">
					<input type="button" class="btn btn btn-danger" name="btnFrmSubmit" value="Delete" onClick="delete_record(#pscId#);">
				</td></tr>
			</cfoutput>
		</tbody>
		</table>
		</form>
	</cfif>
</td></tr>
</table>