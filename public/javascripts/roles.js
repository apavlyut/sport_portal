function showActions(what)
{
	if ($("#"+what).css('display') == 'none'){
		$("a."+what+"_link").html(what+" -");
		$("div."+what+"_header").html("выделить все <a href=# onclick='check_all(\""+what+"\"); return false;'>все</a> / <a href=# onclick='uncheck_all(\""+what+"\"); return false;'>ничего</a>");
		$("#"+what).slideDown();
		$("div."+what+"_header").slideDown();
	}else{
		$("a."+what+"_link").html(what+" +");
		$("div."+what+"_header").html('')
		$("#"+what).slideUp();
		$("div."+what+"_header").slideUp();
	}
	
}

function check_all()
{
	// controllers = controllers.split(',');
	for(var i=0; i<arguments.length; i++)
	{
		if ($("#"+arguments[i]).css('display') == 'none'){
			showActions(arguments[i]);
		}
		$("#"+arguments[i]).find("input[@type$='checkbox']").each(function(){
	    	this.checked = true;
	    });
	}
}

function uncheck_all()
{
	// controllers = controllers.split(',');
	for(var i=0; i<arguments.length; i++)
	{
		if ($("#"+arguments[i]).css('display') != 'none'){
			showActions(arguments[i]);
		}
		$("#"+arguments[i]).find("input[@type$='checkbox']").each(function(){
	    	this.checked = false;
	    });
	}
}

function show_all()
{
	for(var i=0; i<arguments.length; i++)
	{
		if ($("#"+arguments[i]).css('display') == 'none'){
			showActions(arguments[i]);
		}
	}
}

function hide_all()
{
	{
		for(var i=0; i<arguments.length; i++)
		{
			if ($("#"+arguments[i]).css('display') != 'none'){
				showActions(arguments[i]);
			}
		}
	}	
}