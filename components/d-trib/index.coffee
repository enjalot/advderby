class Trib

  view:  __dirname
  style: __dirname
  name: 'd-trib'

  init: ->
    code = @model.at "code"
    console.log "code", code.get()

  create: ->

  destroy: ->

module.exports = Trib