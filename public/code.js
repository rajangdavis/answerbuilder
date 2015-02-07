	
	$(document).ready(function() {  
		$("p.lead,span.lead").each(function(){
			
			var content = $(this).text().replace(/\[red\]/g,'<span class="red">').replace(/\[\/red\]/g,'</span>').replace(/\[blue\]/g,'<span class="blue">').replace(/\[\/blue\]/g,'</span>').replace(/\[green\]/g,'<span class="green">').replace(/\[\/green\]/g,'</span>').replace(/\[yellow\]/g,'<span class="yellow">').replace(/\[\/yellow\]/g,'</span>').replace(/\[orange\]/g,'<span class="orange">').replace(/\[\/orange\]/g,'</span>').replace(/\[lgreen\]/g,'<span class="lgreen">').replace(/\[\/lgreen\]/g,'</span>').replace(/\[bold\]/g,'<strong>').replace(/\[\/bold\]/g,'</strong>').replace(/\[i\]/g,'<em>').replace(/\[\/i\]/g,'</em>').replace(/\[u\]/g,'<u>').replace(/\[\/u\]/g,'</u>').replace(/\[br\]/g,'<br>').replace(/\[note\]/g,'<div class="col-md-12 col-sm-12 col-xs-12 information"><div class="col-md-3 col-sm-5 col-xs-7"><img class="note img-responsive" src="//i.imgur.com/4SIfsGE.png"></div><h2 class="inst answer"><strong>NOTE: </strong><span class="inst lead">').replace(/\[\/note\]/g,'</span></h2></div>').replace(/\[cat\]/g,'<div class="col-md-12 col-sm-12 col-xs-12 cautiondiv"><div class="col-md-3 col-sm-5 col-xs-7"><img class="caution img-responsive" src="//i.imgur.com/ejvODER.png"></div><h2><strong>CAUTION: </strong><span class="lead">').replace(/\[\/cat\]/g,'</span></h2></div>');
			
			$(this).html(content);	
		});
		$("em.red").each(function(){
			var pLead = $(this).prev();
			$(this).appendTo(pLead);
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
			$("textarea.code").html(codeHTML);
			console.log('This exists');
		};
	});
