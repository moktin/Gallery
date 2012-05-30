# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('.carousel-control.left').hide();
  $('.carousel-control.right').click ->
    if ($('.item.active').nextAll('.item').length == 1)
      $(this).hide()
    else
      $(this).show();
    $('.carousel-control.left').show()
  $('.carousel-control.left').click ->
    $('.carousel-control.right').show()
    if ($('.item.active').prevAll('.item').length == 1)
      $(this).hide()
    else
      $(this).show();


