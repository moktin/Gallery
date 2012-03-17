# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#categories_list, .sub_categories").sortable(
    opacity: 0.6,
    cursor: 'move',
    update: ->
      $.put("/admin/categories/update_positions", $(this).sortable("serialize"))
  ).disableSelection();

