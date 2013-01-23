# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery(->
  oldFocus = jQuery().modal.Constructor.prototype.enforceFocus
  jQuery().modal.Constructor.prototype.enforceFocus = ->
  
  $('input[data-encrypt=true]').each((index)->
    # hide encrypted labled field and replace it
    # with a new input field which encrypts
    # its data immediately. In the end the encrypted
    # data is written into the hidden input field.
    elem = $(this)
    type = elem.data('type')
    if type == undefined
      type = elem.attr('type')
    elem.hide()
    
    newElem = $('<input />').attr('value', '').attr('type', type).change(->
      self.userSecret($(this), (field, secret)->
        value = field.val()
        field.data('encryptedField').val(CryptoJS.AES.encrypt(value, secret), format: JsonFormatter)
      )
    ).data('encryptedField', elem).insertAfter(elem)
  )

  $('[data-encrypted]').click(->
    self.userSecret($(this), (field, secret) ->
      value = field.data('encrypted')
      decrypted_data = CryptoJS.AES.decrypt(value, secret).toString(CryptoJS.enc.Utf8)
      alert(decrypted_data)
    )
  )

  $('[data-decrypt-on-show]').each( (index) ->
    $(this).parents('.modal').on('show', ->
      self.userSecret($(this), (dialog, secret) ->
        $(dialog).find('[data-decrypt-on-show]').text( ->
          value = $(this).data('decrypt-on-show')
          CryptoJS.AES.decrypt(value, secret).toString(CryptoJS.enc.Utf8)
        )
      )
    )
  )
)

self.userSecret = (value, func) ->
  # get encrypted secret from the page
  encrypted_secret = $.trim($('meta[name=x-user-secret]').attr('content'))

  self.promptUserPassword((password) ->
    decrypted_secret = $.trim(CryptoJS.AES.decrypt(encrypted_secret, password).toString(CryptoJS.enc.Utf8))
    if decrypted_secret == ''
      alert('Wrong password')
      throw "Wrong Password"
    else
      func(value, decrypted_secret)
  )

self.promptUserPassword = (func)->
  $('#user-password-dialog').one('show', ->
    setTimeout( ->
      $('#user-password-dialog-password').focus()
    , 300)
  ).modal().one('hidden', ->
    if $(this).data('result') == 'ok'
      func($('#user-password-dialog-password').val())
  )

JsonFormatter =
  stringify: (cipherParams)->
    # create json object with ciphertext
    jsonObj =
      ct: cipherParams.ciphertext.toString(CryptoJS.enc.Base64)

    # optionally add iv and salt
    if cipherParams.iv
      jsonObj.iv = cipherParams.iv.toString()
    if cipherParams.salt
      jsonObj.s = cipherParams.salt.toString()

    # stringify json object
    JSON.stringify(jsonObj)

  parse: (jsonStr)->
    # parse json string
    jsonObj = JSON.parse(jsonStr)

    # extract ciphertext from json object, and create cipher params object
    cipherParams = CryptoJS.lib.CipherParams.create(
      ciphertext: CryptoJS.enc.Base64.parse(jsonObj.ct)
    )

    # optionally extract iv and salt
    if jsonObj.iv
      cipherParams.iv = CryptoJS.enc.Hex.parse(jsonObj.iv)
    if jsonObj.s
      cipherParams.salt = CryptoJS.enc.Hex.parse(jsonObj.s)

    cipherParams
