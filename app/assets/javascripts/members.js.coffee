# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(->
  $('input[data-pwencrypt=now]').each((index)->
    elem = $(this)
    self.promptUserPassword((password) ->
      value = elem.val()
      value = $.trim(CryptoJS.AES.decrypt(value, window.location.hash.replace('#', '')).toString(CryptoJS.enc.Utf8))
      elem.val(CryptoJS.AES.encrypt(value, password).toString())
      elem.parents('form').submit()
    )
  )
)
