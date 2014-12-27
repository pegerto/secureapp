# -*- coding: utf-8 -*- 
<%inherit file="layout.mako"/>


<article class="module width_full">
	<header>
		<h3 class="tabs_involved">Groups Configured</h3>
	</header>

	<div class="tab_container">
		<div id="tab1" class="tab_content" style="display: block;">
			<table class="tablesorter" cellspacing="0">
				<thead>
					<tr>
						<th class="header"></th>
						<th class="header">Group Name</th>
						<th class="header">Applications</th>
						<th class="header">Actions</th>
					</tr>
				</thead>
				<tbody id="grouplist">
					<template id="grouprow">
					<tr id="{{groupid}}">
						<td></td>
						<td>{{groupname}}</td>
						<td>{{appscount}}</td>
						<td>
							<input type="image" id="edit" src="/static/images/icn_edit.png" title="Edit">
							<input type="image" id="del" src="/static/images/icn_trash.png" title="Trash">
						</td>
					</tr>
					</template>
				</tbody>
			</table>
		</div>
	</div>
	<!-- end of .tab_container -->
	<footer>
		<div class="submit_link">
			<input id="newgroupbutton" type="submit" value="New" class="alt_btn">

		</div>
	</footer>
</article>

<article class="module width_full" id="newgroup">
	<header>
		<h3>New Group</h3>
	</header>
	<div class="module_content">
		<fieldset>
			<label>Group Name</label> <input type="text" id="groupname">
		</fieldset>
		</fieldset>
		<div class="clear"></div>
	</div>
	<footer>
		<div class="submit_link">
			<input type="submit" value="Add" class="alt_btn" id="sendgroup">
			<input type="submit" value="Reset">
		</div>
	</footer>
</article>

<div id="dialog-confirm" title="Delete this item?" style="display:none;">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">
  	</span>These items will be permanently deleted and cannot be recovered. Are you sure?
  </p>
</div>


<script type="text/javascript">
	$(function(){
		
			// Cached dom values
			var grouplisttemplate = $('#grouprow').html()
			var grouplist = $('#grouplist')
			
			var addGroup = function(){
				var group = {
					groupname: $('#groupname').val(),
				};
				
				$.ajax({
					 url: "/group/new/",
					 dataType: "json",
					 type: "POST",
					 contentType: 'application/json; charset=utf-8',
					 data: JSON.stringify(group),
					 success: function(result, status){
						 if (result.error) {
							alert (result.errordes)
						 } else {
							 group.groupid = result.groupkey
							 grouplist.append(Mustache.to_html(grouplisttemplate, group));
						 }
					 }
					});
				
			};
		
		
			// Hide and show new group
			$('#newgroup').hide();
			$('#newgroupbutton').on('click', function(){
				$('#newgroup').fadeToggle();
			});
			
			// Configure default behaivour to add an application
			$('#sendgroup').on('click', addGroup);
			

	grouplist.on('click', 'input', function() {
			if ($(this).attr('id') === "del") {
				console.log("delete");
				$("#dialog-confirm").dialog({
					resizable : false,
					height : 180,
					modal : true,
					buttons : {
						"Delete this group" : function() {
							$(this).dialog("close");
						},
						Cancel : function() {
							$(this).dialog("close");
						}
					}
				});
			} else {
				console.log("edit");
			}
		});

		// Load groups
		$.ajax({
			url : "/group/list/",
			dataType : "json",
			success : function(result, status) {
				$.each(result.list,
						function() {
							var group = {
								groupname : this.name,
								groupid : this.id
							};
							grouplist.append(Mustache.to_html(
									grouplisttemplate, group));
						});
			}
		});
	});
</script>
