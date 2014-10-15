

function get_input_width() {
  return ((this.value.length + 1) * 9) + 'px'
}

$(function(){
 	$(".grade-table-input.auto-width").width(get_input_width);
	  $(".grade-table-input.auto-width").keypress(function(){
	    $(this).width(get_input_width);
	  });
	  tabby.init();

	$(".rotate").each(function(index, value) {
		var anchor = $(this);
		var title = $(anchor.find("span.title")[0])
		$(anchor).height(title.width());
	});
})