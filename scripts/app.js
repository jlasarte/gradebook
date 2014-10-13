

function get_input_width() {
  return ((this.value.length + 1) * 9) + 'px'
}

$(function(){
 	$(".grade-table-input.auto-width").width(get_input_width);
	  $(".grade-table-input.auto-width").keypress(function(){
	    $(this).width(get_input_width);
	  });
	  tabby.init();
})