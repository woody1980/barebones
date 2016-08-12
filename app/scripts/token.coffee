namespace('Barebones')

Barebones.Token = {
  get: ->
    SamaritanJs.OAuth.TokenAccessor.get('SOME_SCOPE')
}
