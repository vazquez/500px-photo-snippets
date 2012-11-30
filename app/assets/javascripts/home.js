// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var selected_id = [];
$(document).ready(function(){

    $(".selectable-image").click(function(){
        var photo_id = $(this).children('img').attr('id')
	var img = $(this);
	if (img.hasClass('selected')){
	    img.removeClass('selected');
	    selected_id.splice(selected_id.indexOf(photo_id), 1);
	}else{
	    img.addClass('selected');
	    selected_id.push(photo_id);
	    if (selected_id.length >= 6){
		//bam, go to the backend;
		$(".selectable-image:not(.selected)").fadeOut(function(){
		    $(this).remove();
		});
		$(".selected").removeClass('selected');
		$(".selectable-image").removeClass("selectable-image");
		$('#overlay').css('display', 'visible');
		$( "#sortable" ).sortable();
  		$( "#sortable" ).disableSelection();
  		$("#sortable").addClass("show-order");
		$.ajax({
		    type: 'POST',
		    url: '/selected',
		    data: {data:selected_id},
		    success: function(data){
		        if (data.success){
		            window.location.href = data.url;
		        }
		    },
		});
	    }
	}
    })

})
