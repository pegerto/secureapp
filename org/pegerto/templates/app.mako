# -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>

<article class="module width_full">
	<header>
		<h3 class="tabs_involved">Applications Configured</h3>
	</header>

	<div class="tab_container">
		<div id="tab1" class="tab_content" style="display: block;">
			<table class="tablesorter" cellspacing="0">
				<thead>
					<tr>
						<th class="header"></th>
						<th class="header">Application Name</th>
						<th class="header">Group</th>
						<th class="header">Filters</th>
						<th class="header">Actions</th>
					</tr>
				</thead>
				<tbody id="applist">
					<template id="approw">
					<tr id="{{appid}}">
						<td></td>
						<td>{{appname}}</td>
						<td>{{group}}</td>
						<td></td>
						<td><input type="image" src="/static/images/icn_edit.png"
							title="Edit"><input type="image"
							src="/static/images/icn_trash.png" title="Trash"></td>
					</tr>
					</template>
				</tbody>
			</table>
		</div>
	</div>
	<!-- end of .tab_container -->
	<footer>
		<div class="submit_link">
			<input id="newappbutton" type="submit" value="New" class="alt_btn">

		</div>
	</footer>
</article>

<article class="module width_full" id="newapp">
	<header>
		<h3>New Application</h3>
	</header>
	<div class="module_content">
		<fieldset>
			<label>Application Name</label> <input type="text" id="appname">
		</fieldset>
		<fieldset style="width: 48%; float: left; margin-right: 3%;">
			<label>APP-ID</label> <input type="text" id="appid"
				style="width: 93%;"></input>
		</fieldset>
		<fieldset style="width: 48%; float: right;">
			<label>Token</label>
			<div class="clear"></div>
			<input type="text" id="token"
				style="width: 60%; float: left margin-right: 3%;"></input> <input
				type="submit" value="Generate" class="alt_btn" id="generate"
				style="float: right; margin-right: 3%;">
			<div class="clear"></div>
		</fieldset>
		<fieldset style="width: 48%; float: left; margin-right: 3%;">
			<!-- to make two field float next to one another, adjust values accordingly -->
			<label>Group</label> <select style="width: 92%;">
				<option>Extranet</option>
				<option>Finatial</option>
				<option>Pricing</option>
			</select>
		</fieldset>
		</fieldset>
		<div class="clear"></div>
	</div>
	<footer>
		<div class="submit_link">
			<input type="submit" value="Add" class="alt_btn" id="sendapp">
			<input type="submit" value="Reset">
		</div>
	</footer>
</article>


<script type="text/javascript">
	$(function(){
		
			// Cached dom values
			var applisttemplate = $('#approw').html()
			var applist = $('#applist')
			
			var addApplication = function(){
				console.log("adding application")
				var app = {
					appname: $('#appname').val(),
  					appid: $('#appid').val(),
    				token: $('#token').val(),
    				group: "nogroup"
				};
				
				$.ajax({
					 url: "/app/new/",
					 dataType: "json",
					 type: "POST",
					 contentType: 'application/json; charset=utf-8',
					 data: JSON.stringify(app),
					 success: function(data, status){
						 applist.append(Mustache.to_html(applisttemplate, app));
					 }
					});
				
			};
		
		
			// Hide and show new application
			$('#newapp').hide();
			$('#newappbutton').on('click', function(){
				$('#newapp').fadeToggle();
			});
			
			// Configure default behaivour to add an application
			$('#sendapp').on('click', addApplication);
			
			// Load application list
			$.ajax({
				url : "/app/list/",
				dataType : "json",
				success : function(result, status) {
					$.each(result.list,
							function() {
								var app = {
									appname: this.appname,
					  				appid: this.appid,
					    			token: this.token,
					    			group: "nogroup"
								};
								applist.append(Mustache.to_html(
										applisttemplate, app));
							});
				}
			});
			
	}); 
</script>
