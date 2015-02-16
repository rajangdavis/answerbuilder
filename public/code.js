	
	$(document).ready(function() {  
		$("p.lead,span.lead").each(function(){
			
			var content = $(this).text().replace(/\[red\]/g,'<span class="red">').replace(/\[\/red\]/g,'</span>').replace(/\[blue\]/g,'<span class="blue">').replace(/\[\/blue\]/g,'</span>').replace(/\[green\]/g,'<span class="green">').replace(/\[\/green\]/g,'</span>').replace(/\[yellow\]/g,'<span class="yellow">').replace(/\[\/yellow\]/g,'</span>').replace(/\[orange\]/g,'<span class="orange">').replace(/\[\/orange\]/g,'</span>').replace(/\[lgreen\]/g,'<span class="lgreen">').replace(/\[\/lgreen\]/g,'</span>').replace(/\[bold\]/g,'<strong>').replace(/\[\/bold\]/g,'</strong>').replace(/\[i\]/g,'<em>').replace(/\[\/i\]/g,'</em>').replace(/\[u\]/g,'<u>').replace(/\[\/u\]/g,'</u>').replace(/\[br\]/g,'<br>').replace(/\[note\]/g,'<div class="inst col-md-10 col-sm-10 col-xs-10 information"><div class="col-md-12 col-sm-12 col-xs-12"><h2 class="answer"><span class="lead">').replace(/\[\/note\]/g,'</span></h2></div></div>').replace(/\[cat\]/g,'<div class="inst col-md-10 col-sm-10 col-xs-10 cautiondiv"><div class="col-md-12 col-sm-12 col-xs-12"><h2 class="answer"><span class="lead">').replace(/\[\/cat\]/g,'</span></h2></div></div>').replace(/\[p\]/g,'<p class="clear inst lead">').replace(/\[\/p\]/g,'</p>');
			
			$(this).html(content);	
		});
		$("em.red").each(function(){
			var pLead = $(this).prev('p.lead,span.lead,div.information,div.caution,p.clear');
			$(this).appendTo(pLead);
		});
		$('div.information,div.caution,p.clear').next('em.lead:not(p.clear)').each(function(){
			$(this).attr('class','lead red inst');
		});

	$("div.edit_form,div.add_steps_form").hide();	

	$("a.edit_this").click(function(){
		$("div.edit_form").toggle(1000);
	});

	$("a.add_steps").click(function(){
		$("div.add_steps_form").toggle(1000);
	});


	
	//script to copy code of documents
		var codeHTML = $("code").length;
		if(codeHTML){
			$("textarea.code").html($("code")[0].innerHTML);
			console.log('This exists');
		};
	});
