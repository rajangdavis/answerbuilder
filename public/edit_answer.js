$(document).ready(function () {
    $("p.lead,span.lead").each(function () {
        // Create code to do key value pair swaps for the different colors and typography
        var content = $(this).text().replace(/\[red\]/g,'<span class="red">').replace(/\[\/red\]/g,'</span>').replace(/\[blue\]/g,'<span class="blue">').replace(/\[\/blue\]/g,'</span>').replace(/\[green\]/g,'<span class="green">').replace(/\[\/green\]/g,'</span>').replace(/\[yellow\]/g,'<span class="yellow">').replace(/\[\/yellow\]/g,'</span>').replace(/\[orange\]/g,'<span class="orange">').replace(/\[\/orange\]/g,'</span>').replace(/\[lgreen\]/g,'<span class="lgreen">').replace(/\[\/lgreen\]/g,'</span>').replace(/\[bold\]/g,'<strong>').replace(/\[\/bold\]/g,'</strong>').replace(/\[i\]/g,'<em>').replace(/\[\/i\]/g,'</em>').replace(/\[u\]/g,'<u>').replace(/\[\/u\]/g,'</u>').replace(/\[br\]/g,'<br>').replace(/\[note\]/g,'<div class="col-md-5 col-sm-5 col-xs-5 information"><div class="col-md-4 col-sm-5 col-xs-6"><img class="note img-responsive" src="//i.imgur.com/4SIfsGE.png"></div><h2 class="answer"><strong>NOTE: </strong><span class="lead">').replace(/\[\/note\]/g,'</span></h2></div>');    
        //console.log(content1);
        $(this).html(content);
    });
    $("em.red").each(function () {
        var pLead = $(this).prev();
        $(this).appendTo(pLead);
    });


$("div.edit_form,div.add_steps_form").hide();

$("a.edit_this").click(function () {
    $("div.edit_form").toggle(1000);
});

$("a.add_steps").click(function () {
    $("div.add_steps_form").toggle(1000);
});

//script for uploading images and converting them into dataURI
var canvas = new fabric.Canvas('imageCanvas', {
    backgroundColor: 'rgb(240,240,240)'
});

var imageLoader = document.getElementById('imageLoader');
imageLoader.addEventListener('change', handleImage, false);

function handleImage(e) {
    var reader = new FileReader();
    reader.onload = function (event) {
        var img = new Image();
        img.onload = function () {
            var imgInstance = new fabric.Image(img, {
                scaleX: 1,
                scaleY: 1
            });
            canvas.add(imgInstance);
        };
        img.src = event.target.result;

        finalURI = img.src.replace('', '');

        console.log(finalURI);
$.ajax({
            url: 'https://api.imgur.com/3/image',
            type: 'post',
            headers: {
                Authorization: "Client-ID <%= ENV['IMGUR_KEY'] %>"

            },
            data: {
                image: finalURI,
                type: 'base64'
            },
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                   
                    console.log(response.data.link);
                    
                }
            }
        });
        
    };
    reader.readAsDataURL(e.target.files[0]);
};


});