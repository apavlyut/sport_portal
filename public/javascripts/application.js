// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function show_login_form() {
	$("#login_link").addClass("current");
	$("#login_form").fadeIn("fast");
//	$("#login_form").slideDown();
}

function hide_login_form() {
	$("#login_link").removeClass("current");	
	$("#login_form").fadeOut("fast");
//	$("#login_form").slideUp();
}

function change_elements(from, to) {
	$(from).hide();
	$(to).fadeIn('slow');
}