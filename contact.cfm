<cfInclude template="header.cfm">

<cfif IsDefined('FORM.fieldNames')>
	<cfset variables.message = 'Thank you for the contact, this is only a demo only.'>
</cfif>

<div id="custom-header">
	<ul class="breadcrumb">
		<li class="active">Contact Me</li>
	</ul>
</div>

<div id="message"></div>

<form class="form-horizontal" method="post" onSubmit="return checkPage()">
	<div class="control-group">
		<label class="control-label" for="inputEmail">Email</label>
		<div class="controls">
			<input type="text" name="inputEmail" id="inputEmail" placeholder="Email">
			<span id="helpEmail" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="inputMessage">Message</label>
		<div class="controls">
			<textarea name="inputMessage" id="inputMessage" placeholder="Message" class="input" rows="6" cols="70"></textarea>
			<span id="helpMessage" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<button type="submit" class="btn btn-large btn-primary">Send message</button>
		</div>
	</div>
</form>

<script type="text/javascript">
	$(document).ready(function() {
		<cfif IsDefined("variables.message")>
			showMessage('alert alert-success', '<cfoutput>#variables.message#</cfoutput>');
		</cfif>
	});
	
	function checkPage() {
		hideMessage();
		var inputEmail = $('#inputEmail').val();
		var inputMessage = $('#inputMessage').val();
		
		$('.text-error').hide();
		
		inputEmail = $.trim(inputEmail);
		inputMessage = $.trim(inputMessage);
		
		var error = 0;
				
		if (inputEmail.length == 0) {
			$('#helpEmail').html('Please fill in the name!').show();
			error = 1;
		}
		
		if (inputMessage.length == 0 || inputMessage.length > 4000) {
			$('#helpMessage').html('Please fill in the message or the message is to big!').show();
			error = 1;
		}
		
		if (error == 1) {
			showMessage('alert', '<strong>Warning!</strong> Form has errors!');
			return false;
		}

		return true;
	}
	
	function showMessage(type, text) {
		$('#message').attr('class', type).html(text).show();
	}
	
	function hideMessage() {
		$('#message').attr('class', '').html('').hide();
	}
</script>

<cfInclude template="footer.cfm">