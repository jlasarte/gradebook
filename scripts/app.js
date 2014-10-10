function get_input_width() {
  return ((this.value.length + 1) * 8) + 'px'
}

$(function(){
  $(".grade-table-input").width(get_input_width);
  $(".grade-table-input").keypress(function(){
    $(this).width(get_input_width);
  });
})