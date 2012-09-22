setCkeditor = (textarea) ->
  CKEDITOR.replace(textarea[0], {
    lang: 'fr',
    toolbar:
          [
              ['Bold', 'Italic', 'Underline', '-', 'Link','Unlink']
          ]
      })


$(document).ready ->
  $('.editor').each ->
    setCkeditor($(this))
