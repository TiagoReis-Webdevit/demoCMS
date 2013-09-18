<!DOCTYPE HTML>
<html>
<header>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<cfoutput>
		<script src="#application.urlPath#/bootstrap/js/bootstrap.min.js"></script>
		<link href="#application.urlPath#/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
		<link href="#application.urlPath#/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
	</cfoutput>
	<style type="text/css">
		body { padding-top: 20px; padding-bottom: 40px; }
		.container-narrow { margin: 0 auto; max-width: 700px; }
		.container-narrow > hr { margin: 20px 0; }
		.paddLeft { margin-left: 10px; }
		.btn_page_title { position: relative; top: -51px; left: -4px; }
	</style>
	<script type="text/javascript">
		<cfoutput>
			$(document).ready(function() {
				showMessage('#session.message.getText()#', #session.message.getImportance()#);
				$('input:not([type="hidden"]):not([type="button"]):first, textarea, select').trigger('focus');
			});
			<cfset session.message.clear()>
		</cfoutput>

		function showMessage(text, type) {
			if (text != '') {
				var classType = '';

				switch (parseInt(type)) {
					case 0: classType = 'alert alert-info'; break;
					case 1: classType = 'alert alert-success'; break;
					case 2: classType = 'alert alert-error'; break;
				}

				$('#custom-header').append('<div id="message" class="' + classType + '" style="display: none;">' + text + '</div>');
				$('#message').show();
			}
		}

		function hideMessage() {
			$('#message').hide().remove();
		}
		
		function detail_record(pkId) {
			document.getElementById('pkId').value = pkId;
			document.getElementById('form').submit();
		}
	
		function delete_record(pkId) {
			document.getElementById('pkId').value = pkId;
			document.getElementById('pageAction').value = 0;
			document.getElementById('form').submit();
		}

		// Regular expressions
		var regDate = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
		var regTime = /^\d{1,2}:\d{2}([ap]m)?$/;
		var isNumeric = /^\s*\d+\s*$/;
		var isSecure = /^[A-Za-z0-9_]{5,25}$/;
		var priceValid = /^^(?:(\-\d+\,\d{1,2})|(\d+\,\d{1,2})|(\-\d+)|(\d+))$/;

		function isEmail(str) {
			str = $.trim(str);
			var lastAtPos = str.lastIndexOf('@');
			var lastDotPos = str.lastIndexOf('.');
			return (lastAtPos < lastDotPos && lastAtPos > 0 && str.indexOf('@@') == -1 && lastDotPos > 2 && (str.length - lastDotPos) > 2);
		}
		
		function validateSelect(field, mandatory, dlft) {
			return ((mandatory == 1 && field.options[field.selectedIndex].value == dlft)? false : true);
		}

		function validateText(text, mandatory) {
			text = $.trim(text);
			
			return ((mandatory == 1 && text.length == 0)? false : true);
		}
		
		function validateEmail(email, mandatory) {
			email = $.trim(email);
			
			if (!validateText(email, mandatory)) {
				return false;	
			}
			
			if (email.length > 0 && !isEmail(email)) {
				return false;
			}
			
			return true;
		}
	</script>
</header>
<body>

<div class="container-narrow">
	<div class="page-header">
		<h1>Web Developer IT <small>Consulting - Freelancer</small></h1>
		<cfoutput><h2><small>#application.name#</small></h2></cfoutput>

		<cfif IsDefined("session.cstData")>
			<div class="navbar">
				<div class="navbar-inner">
					<cfinclude template="menu.cfm">
				</div>
			</div>
		<cfelse>
			<hr>
		</cfif>

		<div class="content paddLeft">