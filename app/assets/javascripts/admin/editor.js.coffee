setCkeditor = (textarea) ->
  CKEDITOR.replace(textarea[0], {
    lang: 'fr',
    toolbar:
          [
              ['Bold', 'Italic', 'Underline', '-', 'Link','Unlink']
          ]
      })


$(document).ready ->
  if $('.editor').length > 0
    setCkeditor($('.editor'));
