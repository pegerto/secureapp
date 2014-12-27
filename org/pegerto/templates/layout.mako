# -*- coding: utf-8 -*- 
<!doctype html>
<html lang="en">

<head>
	<meta charset="utf-8"/>
	<title>SecurityAdmin</title>
	
	<link rel="stylesheet" href="/static/css/layout.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="/static/css/jquery-ui.css" type="text/css" />
	
	<script src="/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="/static/js/mustache.js" type="text/javascript"></script>
	<script src="/static/js/jquery-ui.js" type="text/javascript"></script>
	
	<script src="/static/js/hideshow.js" type="text/javascript"></script>
	<script src="/static/js/jquery.tablesorter.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="/static/js/jquery.equalHeight.js"></script>
	<script type="text/javascript">
	$(document).ready(function() 
    	{ 
      	  $(".tablesorter").tablesorter(); 
   	 } 
	);
	$(document).ready(function() {

	//When page loads...
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

});
    </script>
    <script type="text/javascript">
    $(function(){
        $('.column').equalHeight();
    });
</script>

</head>


<body>

	<header id="header">
		<hgroup>
			<h1 class="site_title"><a href="/">Security Admin</a></h1>
			<h2 class="section_title">Dashboard</h2><div class="btn_view_site"></div>
		</hgroup>
	</header> <!-- end of header bar -->
	
	<section id="secondary_bar">
		<div class="user">
			<p>John Doe (<a href="#">3 Messages</a>)</p>
			<!-- <a class="logout_user" href="#" title="Logout">Logout</a> -->
		</div>
		<div class="breadcrumbs_container">
			<article class="breadcrumbs"><a href="index.html">Website Admin</a> <div class="breadcrumb_divider"></div> <a class="current">Dashboard</a></article>
		</div>
	</section><!-- end of secondary bar -->
	
	<aside id="sidebar" class="column">
		<form class="quick_search">
			<input type="text" value="Quick Search" onfocus="if(!this._haschanged){this.value=''};this._haschanged=true;">
		</form>
		<hr/>
		<h3>Applications</h3>
		<ul class="toggle">
			<li class="icn_photo"><a href="${request.route_url('app')}">Applications</a></li>
			<li class="icn_categories"><a href="${request.route_url('group')}">Groups</a></li>
			<li class="icn_tags"><a href="#">SecurityFilters</a></li>
		</ul>
		<h3>Security</h3>
		<ul class="toggle">
			<li class="icn_settings"><a href="#">Options</a></li>
			<li class="icn_security"><a href="#">Security</a></li>
			<li class="icn_jump_back"><a href="#">Logout</a></li>
		</ul>
		<h3>Users</h3>
		<ul class="toggle">
			<li class="icn_add_user"><a href="#">Add New User</a></li>
			<li class="icn_view_users"><a href="#">View Users</a></li>
			<li class="icn_profile"><a href="#">Your Profile</a></li>
		</ul>
		<h3>Media</h3>
		<ul class="toggle">
			<li class="icn_folder"><a href="#">File Manager</a></li>
			<li class="icn_photo"><a href="#">Gallery</a></li>
			<li class="icn_audio"><a href="#">Audio</a></li>
			<li class="icn_video"><a href="#">Video</a></li>
		</ul>

		
		<footer>
			<hr />
			Pegerto Fernandez
		</footer>
	</aside><!-- end of sidebar -->
	
	<section id="main" class="column">
		 ${next.body()}
	
	
	
	
		<div class="spacer"></div>
	</section>


</body>

</html>