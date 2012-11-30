// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var selected_id = [];
$(document).ready(function(){
	$(".selectable-image").click(function(){
		var img = $(this);
		if (img.hasClass('selected')){
			img.removeClass('selected');
			selected_id.splice(selected_id.indexOf(this.id), 1);
		}else{
			img.addClass('selected');
			selected_id.push(this.id);
			if (selected_id.length >= 6){
				//bam, go to the backend;
				$('#overlay').css('display', 'visible');
				$.ajax({
				  type: 'POST',
				  url: '/selected',
				  data: {data:selected_id},
				  success: function(data){
				  	if (data.success){
				  		window.location.href = "http://www.google.com";
				  	}
				  },
				});
			}
		}
	})
})