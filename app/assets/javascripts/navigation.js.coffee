prepareNav = ->
  $('#main_nav ul').addClass('nav')

$(document).ready ->
  prepareNav()
  $('li.disabled a').live('click', ->
    return false;
  )