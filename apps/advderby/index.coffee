derby = require 'derby'

app = module.exports = derby.createApp 'advderby', __filename

app.use require 'derby-login/components'
app.use require 'derby-debug'
app.serverUse module, 'derby-stylus'


app.loadViews __dirname + '/views'
app.loadStyles __dirname + '/styles'

app.component require '../../components/d-trib'
app.component require '../../components/d-scope'
app.component require '../../components/d-render'


app.get '/', (page, model) ->

  model.set "_page.code", {
    js: "var x = 5;"
    html: "<div></div>"
    css: ".foo { color: orange; }"
  }
  model.set "_page.data.y", 2

  page.render 'home'

app.get '/login', (page) ->
  page.render 'login'

app.get '/register', (page) ->
  page.render 'register'

