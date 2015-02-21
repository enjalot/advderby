class Scope

  view:  __dirname
  style: __dirname
  name: 'd-scope'

  init: ->
    data = @model.at "data"
    console.log "data", data.get()

  create: ->

  destroy: ->

module.exports = Scope