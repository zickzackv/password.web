# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
  $('input[data-encrypt=true]').each((index)->
    elem = $(this)
    type = elem.data('type')
    if type==undefined
      type = elem.attr('type')
    elem.hide()
    newElem = $('<input>').attr('type', type).change(->
      value = $(this).val()
      secret = self.getUserSecret()
      $(this).data('encryptedField').val(CryptoJS.AES.encrypt(value, secret), format: JsonFormatter)
    ).data('encryptedField', elem).insertAfter(elem)
  )

  $('[data-encrypted]').click(->
    encrypted_data = $(this).data('encrypted')
    decrypted_data = CryptoJS.AES.decrypt(encrypted_data, self.getUserSecret()).toString(CryptoJS.enc.Utf8)
    alert(decrypted_data)
  )
)

self.getUserSecret = ->
  # get encrypted secret from the page
  encrypted_secret = $.trim($('meta[name=user-secret]').attr('content'))
  user_password = $.trim($('meta[name=user-secret]').data('user-password'))

  # if the user has not entered the password for this request, ask
  if user_password == ''
    user_password = $.trim(prompt('Please enter your password', ''))
    $('meta[name=user-secret]').data('user-password', user_password)

  # decrypt the secret using the users password
  decrypted_secret = CryptoJS.AES.decrypt(encrypted_secret, user_password).toString(CryptoJS.enc.Utf8)

  if decrypted_secret == ''
    $('meta[name=user-secret]').removeAttr('user-password')
    alert('Wrong password')
    throw "Wrong Password"

  # return the secret
  $.trim(decrypted_secret)

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
