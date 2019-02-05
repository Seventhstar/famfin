# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@delete_item = (url) -> 
  $.ajax
    url: url
    data: '_method': 'delete'
    dataType: 'script'
    type: 'POST'
    complete: ->
      # $.get url, null, null, 'script'
      show_ajax_message('Успешно удалено')
      return
  return
