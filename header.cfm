<cfcache>
<!DocType html>
<html>
<header>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
		  body {
			padding-top: 20px;
			padding-bottom: 40px;
		  }
	
		  /* Custom container */
		  .container-narrow {
			margin: 0 auto;
			max-width: 700px;
		  }
		  .container-narrow > hr {
			margin: 20px 0;
		  }
		  .paddLeft {
			margin-left: 10px;
		  }
		</style>
	</style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <link href="css/main.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
</header>
<body>

<div class="container-narrow">
	<div class="page-header">
		<h1>Web Developer IT <small>CMS - Demo</small></h1>

		<div class="navbar">
			<div class="navbar-inner">
				<ul class="nav">
					<li<cfif findNoCase('index', CGI.SCRIPT_NAME)> class="active"</cfif>><a href="index.cfm">Home</a></li>
					<li<cfif findNoCase('projects', CGI.SCRIPT_NAME)> class="active"</cfif>><a href="projects.cfm">Projects</a></li>
					<li<cfif findNoCase('blog', CGI.SCRIPT_NAME)> class="active"</cfif>><a href="blog.cfm">Blog</a></li>
					<li<cfif findNoCase('about', CGI.SCRIPT_NAME)> class="active"</cfif>><a href="about.cfm">About</a></li>
					<li<cfif findNoCase('contact', CGI.SCRIPT_NAME)> class="active"</cfif>><a href="contact.cfm">Contact</a></li>
				</ul>
			</div>
		</div>
		
		<div class="content paddLeft">

</cfcache>
<cfflush>