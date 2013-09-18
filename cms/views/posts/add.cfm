<cfset variables.post = this.getBind("post")>
<cfset variables.getPostCats = this.getBind("getPostCats")>

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
				<li><a href="#application.url#/posts/">Search Posts</a></li>
			</ul>
		</div>
	</cfoutput>
</div>

<form class="form-horizontal" method="post" onsubmit="return checkPage();">
	<input type="hidden" name="pageAction" id="pageAction" value="1" />
	<input type="hidden" name="pkId" id="pkId" value="<cfoutput>#variables.post.getPstId()#</cfoutput>">
	<div class="control-group">
		<label class="control-label" for="pstTitle">Title</label>
		<div class="controls">
			<input type="text" class="input-xlarge" name="pstTitle" id="pstTitle" maxlength="100" placeholder="Title" value="<cfoutput>#variables.post.getPstTitle()#</cfoutput>">
			<span id="helpPstTitle" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="pscId">Category</label>
		<div class="controls">
			<select name="pscId" id="pscId" placeholder="Category">
				<cfoutput query="variables.getPostCats">
					<option value="#pscId#"<cfif variables.post.getPscId() eq pscId> selected</cfif>>#pscName#</option>
				</cfoutput>
			</select>
			<span id="helpPscId" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="pstText">Text</label>
		<div class="controls">
			<textarea name="pstText" class="input-block-level" id="pstText" placeholder="Text" class="input" rows="10" cols="10"><cfoutput>#variables.post.getPstText()#</cfoutput></textarea>
			<span id="helpPstText" class="text-error" style="display: none;"></span>
		</div>
	</div>
	<div class="control-group">
		<div class="controls">
			<button type="submit" class="btn btn-success">Save</button>
		</div>
	</div>
</form>

<cfoutput>
    <script type="text/javascript" src="#application.urlPath#helpers/jwysiwyg/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="#application.urlPath#helpers/jwysiwyg/jquery.wysiwyg.js"></script>
    <link rel="stylesheet" href="#application.urlPath#helpers/jwysiwyg/jquery.wysiwyg.css" type="text/css" />
</cfoutput>
<script type="text/javascript">
	function checkPage() {
		$('#helpPstTitle').hide().html('');
		$('#helpPstText').hide().html('');
		
		var pstTitle = $('#pstTitle').val();
		var pstText = $('#pstText').val();
		var error = 0;

		if (!validateText(pstTitle, 1)) {
			$('#helpPstTitle').html('This is mandatory!').show();
			error = error + 1;
		}

		if (!validateText(pstText, 1)) {
			$('#helpPstText').html('This is mandatory!').show();
			error = error + 1;
		}
		
		if (error > 0) {
			return false;	
		}
		
		return true;
	}

	window.onload = function() {
		(function($) {
			$('#pstText').wysiwyg({
				controls: {
					strikeThrough : { visible : true },
					underline     : { visible : true },
					separator00 : { visible : true },
					justifyLeft   : { visible : true },
					justifyCenter : { visible : true },
					justifyRight  : { visible : true },
					justifyFull   : { visible : true },
			  		separator01 : { visible : true },
			  		indent  : { visible : true },
					outdent : { visible : true },
			  		separator02 : { visible : true },
					subscript   : { visible : true },
					superscript : { visible : true },
			  		separator03 : { visible : true },
			  		undo : { visible : true },
					redo : { visible : true },
			  		separator04 : { visible : true },
			  		insertOrderedList    : { visible : true },
					insertUnorderedList  : { visible : true },
					insertHorizontalRule : { visible : true },
			  		h4mozilla : { visible : true && $.browser.mozilla, className : 'h4', command : 'heading', arguments : ['h4'], tags : ['h4'], tooltip : "Header 4" },
					h5mozilla : { visible : true && $.browser.mozilla, className : 'h5', command : 'heading', arguments : ['h5'], tags : ['h5'], tooltip : "Header 5" },
					h6mozilla : { visible : true && $.browser.mozilla, className : 'h6', command : 'heading', arguments : ['h6'], tags : ['h6'], tooltip : "Header 6" },
			  		h4 : { visible : true && !( $.browser.mozilla ), className : 'h4', command : 'formatBlock', arguments : ['<H4>'], tags : ['h4'], tooltip : "Header 4" },
					h5 : { visible : true && !( $.browser.mozilla ), className : 'h5', command : 'formatBlock', arguments : ['<H5>'], tags : ['h5'], tooltip : "Header 5" },
					h6 : { visible : true && !( $.browser.mozilla ), className : 'h6', command : 'formatBlock', arguments : ['<H6>'], tags : ['h6'], tooltip : "Header 6" },
			  		separator07 : { visible : true },
			  		cut   : { visible : true },
					copy  : { visible : true },
					paste : { visible : true }
				}
			});
		})(jQuery);
	}
</script>