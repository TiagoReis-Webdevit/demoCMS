<cfset variables.postCat = this.getBind('postCat')>

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
				<li><a href="#application.url#/postCats/">Search Post Categories</a></li>
				<li><a href="#application.url#/postCats/add/">Add Post Category</a></li>
			</ul>
		</div>
	</cfoutput>
</div>

<form class="form-horizontal" method="post" onsubmit="return checkPage();">
	<input type="hidden" name="pageAction" id="pageAction" value="1" />
	<input type="hidden" name="pkId" id="id" value="<cfoutput>#variables.postCat.getPscId()#</cfoutput>">
	<div class="control-group">
		<label class="control-label" for="pscName">Name</label>
		<div class="controls">
			<input type="text" name="pscName" id="pscName" maxlength="45" placeholder="Name" value="<cfoutput>#variables.postCat.getPscName()#</cfoutput>">
			<span id="helpPscName" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<button type="submit" class="btn btn-success">Save</button>
			<button type="submit" class="btn btn-danger" onClick="document.getElementById('pageAction').value = 0;">Delete</button>
		</div>
	</div>
</form>

<script type="text/javascript">
	function checkPage() {
		$('#helpPscName').hide().html('');
		
		var pscName = $('#pscName').val();
		var error = 0;

		if (!validateText(pscName, 1)) {
			$('#helpPscName').html('The field name is mandatory!').show();
			error = error + 1;
		}
		
		if (error > 0) {
			return false;	
		}
		
		return true;
	}
</script>