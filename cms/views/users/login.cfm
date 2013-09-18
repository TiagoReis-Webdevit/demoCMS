<cfset variables.user = this.getBind('user')>

<div id="custom-header">
	<cfoutput>
		<ul class="breadcrumb">
			<li class="active">#this.getTitle()#</li>
		</ul>
	</cfoutput>
</div>

<form class="form-horizontal" method="post" style="position: relative;">
	<input type="hidden" name="pageAction" id="pageAction" value="1" />
	<div class="control-group">
		<label class="control-label" for="userEmail">Email</label>
		<div class="controls">
			<input type="text" name="userEmail" id="userEmail" placeholder="Email" value="<cfoutput>#variables.user.getUsrEmail()#</cfoutput>">
			<span id="helpEmail" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="userPassword">Message</label>
		<div class="controls">
			<input type="password" name="userPassword" id="userPassword" placeholder="Password" value="<cfoutput>#variables.user.getUsrPassword()#</cfoutput>">
			<span id="helpPassword" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<button type="submit" class="btn btn-primary">Login</button>
		</div>
	</div>
</form>