# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require_self
#= require_tree .

$(document).ready ->
  $('.datepicker').datepicker({ dateFormat: "dd-mm-yy" });


window._ajax_request = (url, data, callback, type, method) ->
  if (jQuery.isFunction(data))
    callback = data;
    data = {};
  return jQuery.ajax(
    type: method,
    url: url,
    data: data,
    success: callback,
    dataType: type
  );


jQuery.extend(
    put: (url, data, callback, type) ->
        return _ajax_request(url, data, callback, type, 'PUT');
    ,
    delete_: (url, data, callback, type) ->
        return _ajax_request(url, data, callback, type, 'DELETE');

);