<cfset variables.user = this.getBind('user')>

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
				<li><a href="#application.url#/users/">Search Users</a></li>
				<li><a href="#application.url#/users/add/">Add User</a></li>
			</ul>
		</div>
	</cfoutput>
</div>

<form class="form-horizontal" method="post" onsubmit="return checkPage();">
	<input type="hidden" name="pageAction" id="pageAction" value="1" />
	<input type="hidden" name="pkId" id="pkId" value="<cfoutput>#variables.user.getUsrId()#</cfoutput>">
	<div class="control-group">
		<label class="control-label" for="usrFName">First Name</label>
		<div class="controls">
			<input type="text" name="usrFName" id="usrFName" maxlength="45" placeholder="First Name" value="<cfoutput>#variables.user.getUsrFName()#</cfoutput>">
			<span id="helpUsrFName" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="usrLName">Last Name</label>
		<div class="controls">
			<input type="text" name="usrLName" id="usrLName" maxlength="45" placeholder="Last Name" value="<cfoutput>#variables.user.getUsrLName()#</cfoutput>">
			<span id="helpUsrLName" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="usrEmail">Email</label>
		<div class="controls">
			<input type="text" name="usrEmail" id="usrEmail" maxlength="100" placeholder="Email" value="<cfoutput>#variables.user.getUsrEmail()#</cfoutput>">
			<span id="helpUsrEmail" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="usrPassword">Password</label>
		<div class="controls">
			<input type="password" name="usrPassword" id="usrPassword" maxlength="100" placeholder="Password" value="<cfoutput>#variables.user.getUsrPassword()#</cfoutput>">
			<span id="helpUsrPassword" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<button type="submit" class="btn btn-success">Save</button>
			
			<cfif session.cstData.getUsrId() neq variables.user.getUsrId()>
				<button type="submit" class="btn btn-danger" onClick="document.getElementById('pageAction').value = 0;">Delete</button>
			</cfif>
		</div>
	</div>
</form>

<script type="text/javascript">
	function checkPage() {
		$('#helpUsrFName').hide().html('');
		$('#helpUsrLName').hide().html('');
		$('#helpUsrEmail').hide().html('');
		$('#helpUsrPassword').hide().html('');
		
		var usrFName = $('#usrFName').val();
		var usrLName = $('#usrLName').val();
		var usrEmail = $('#usrEmail').val();
		var usrPassword = $('#usrPassword').val();
		var error = 0;

		if (!validateText(usrFName, 1)) {
			$('#helpUsrFName').html('This is mandatory!').show();
			error = error + 1;
		}

		if (!validateText(usrLName, 1)) {
			$('#helpUsrLName').html('This is mandatory!').show();
			error = error + 1;
		}

		if (!validateEmail(usrEmail, 1)) {
			$('#helpUsrEmail').html('This is mandatory and is an email field!').show();
			error = error + 1;
		}
		
		console.log(!validateEmail(usrEmail, 1))

		if (!validateText(usrPassword, 1)) {
			$('#helpUsrPassword').html('This is mandatory!').show();
			error = error + 1;
		}
		
		if (error > 0) {
			return false;	
		}
		
		return true;
	}
</script>