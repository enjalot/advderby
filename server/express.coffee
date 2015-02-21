express = require 'express'

expressSession = require 'express-session'
serveStatic = require 'serve-static'
favicon = require 'serve-favicon'
compression = require 'compression'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
highway = require 'racer-highway'
derbyLogin = require 'derby-login'


module.exports = (store, apps, error, publicDir) ->

  connectStore = require('connect-mongo')(expressSession)
  sessionStore = new connectStore url: process.env.MONGO_URL

  session = expressSession
    secret: process.env.SESSION_SECRET
    store: sessionStore
    cookie: process.env.SESSION_COOKIE
    saveUninitialized: true
    resave: true


  handlers = highway store, session: session

  expressApp = express()
    .use favicon publicDir + '/img/favicon.ico'
    .use compression()
    .use serveStatic publicDir
    .use store.modelMiddleware()
    .use cookieParser()
    .use bodyParser.json()
    .use bodyParser.urlencoded extended: true
    .use session
    .use derbyLogin.middleware store, require '../config/login'
    .use handlers.middleware

  apps.forEach (app) -> expressApp.use app.router()

  expressApp.use require './routes'

  expressApp
    .all '*', (req, res, next) -> next '404: ' + req.url
    .use error

  {expressApp:expressApp, upgrade:handlers.upgrade}

