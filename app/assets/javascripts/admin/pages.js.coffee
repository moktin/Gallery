# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

fixHelper = (e, ui) ->
  ui.children().each ->
    $(this).width($(this).width());

  return ui;

$(document).ready ->
  $("#pages_list tbody").sortable(
    opacity: 0.6,
    cursor: 'move',
    helper: fixHelper
    update: ->
      $.put("/admin/pages/update_positions", $(this).sortable("serialize"))
  ).disableSelection();

