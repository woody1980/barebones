namespace('AppSkeleton')

AppSkeleton.Token = {
  get: ->
    SamaritanJs.OAuth.TokenAccessor.get('SOME_SCOPE')
}
