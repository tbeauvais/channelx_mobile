angular.module("starter.services", [])

#.factory "Messages", ->
#
## stub data for now
#  messages = [
#    id: 5
#    name: "TJ's"
#    lastText: "Announcing new menu items!"
#    logo: "https://static.ctctcdn.com/galileo/images/templates/Galileo-Template-Images/VerticalLogos/VerticalLogo_Restaurant.png"
#    link: "https://s3.amazonaws.com/channelx/tjs_menu.html"
#  ,
#    id: 1
#    name: "IDEA"
#    lastText: "Come workout with a friend..."
#    logo: "http://www.logotypes101.com/logos/634/088A6A6D443BA23D07A865AD3F7D19E7/Idea_Fitness__Wellness.png"
#    link: "https://s3.amazonaws.com/channelx/fitness.html"
#  ,
#    id: 2
#    name: "Arnie's"
#    lastText: "This week 2 for 1 special"
#    logo: "http://cf.juggle-images.com/matte/white/280x280/arnie-s-restaurants-logo-primary.jpg"
#    link: "http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html"
#  ,
#    id: 6
#    name: "SUNNY'S"
#    lastText: "Thanks For Your Purchase"
#    logo: "https://static.ctctcdn.com/galileo/images/templates/Galileo-Template-Images/FeedbackRequest/FeedbackRequest_VerticalLogo.png"
#    link: "https://s3.amazonaws.com/channelx/florist.html"
#  ,
#    id: 3
#    name: "High School Pizza"
#    lastText: "Pizza by the slice"
#    logo: "http://www.thebusinesslogo.com/logo-design-portfolio/logo-design-pizza.gif"
#    link: "http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html"
#  ,
#    id: 4
#    name: "Seaside Real Estate"
#    lastText: "Units available in your area"
#    logo: "http://freelogo-assets.s3.amazonaws.com/sites/all/themes/freelogoservices/images/seaside1.jpg"
#    link: "http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html"
#  ,
#    id: 0
#    name: "The Olive Tree"
#    lastText: "Checkout our latest menu!"
#    logo: "http://www.morairaonline24.com/images/olive_tree_new_logo.jpg"
#    link: "http://www.ballouswinebar.com/Food_and_Wine/body_food_and_wine.html"
#  ]
#  all: ->
#    messages
#
#  remove: (message) ->
#    messages.splice messages.indexOf(message), 1
#
#  get: (messageId) ->
#    i = 0
#
#    while i < messages.length
#      return messages[i]  if messages[i].id is parseInt(messageId)
#      i++
#    null


angular.module("starter.services").factory "Messages", ($resource, Settings) ->
  host = 'channelx-api.mybluemix.net'
  local = Settings.get()['localServer']
  if local
    host = 'localhost:8080'

  $resource "http://#{host}/api/v1/messages/:id"

angular.module("starter.services").factory "Businesses", ($resource, Settings) ->
  host = 'channelx-api.mybluemix.net'
  local = Settings.get()['localServer']
  if local
    host = 'localhost:8080'

  $resource "http://#{host}/api/v1/businesses", { latitude: '42.418725', longitude: '-71.258752', type: '@type' }


angular.module("starter.services").factory "Settings",  ->

  get:  ->
    if localStorage['app_settings']
      JSON.parse(localStorage['app_settings'])
    else
      {}

  update: (settings) ->
    localStorage['app_settings'] = JSON.stringify(settings)
