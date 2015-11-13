# Ionic Starter App

# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.services' is found in services.js
# 'starter.controllers' is found in controllers.js

# Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
# for form inputs)

# org.apache.cordova.statusbar required
angular.module("starter", [ "ionic", "starter.controllers", "starter.services", "ngCordova", "ngResource", "ngRoute" ]).run(($ionicPlatform) ->
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins and window.cordova.plugins.Keyboard
    StatusBar.styleLightContent()  if window.StatusBar

).config ($stateProvider, $urlRouterProvider, $compileProvider) ->
  $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension|map|geo|skype):/)


# Ionic uses AngularUI Router which uses the concept of states
# Learn more here: https://github.com/angular-ui/ui-router
# Set up the various states which the app can be in.
# Each state's controller can be found in controllers.js

# setup an abstract state for the tabs directive

# Each tab has its own nav history stack:
  $stateProvider.state("tab",
    url: "/tab"
    abstract: true
    templateUrl: "templates/tabs.html"
  ).state("tab.search",
    url: "/search"
    views:
      "tab-search":
        templateUrl: "templates/tab-search.html"
        controller: "SearchCtrl"
  ).state("tab.messages",
    url: "/messages"
    views:
      "tab-messages":
        templateUrl: "templates/tab-messages.html"
        controller: "MessagesCtrl"
  ).state("tab.message-detail",
    url: "/messages/:messageId"
    views:
      "tab-messages":
        templateUrl: "templates/message-detail.html"
        controller: "MessageDetailCtrl"
  ).state("tab.subscriptions",
    url: "/subscriptions"
    views:
      "tab-subscriptions":
        templateUrl: "templates/tab-subscriptions.html"
        controller: "SubscriptionsCtrl"
  ).state "tab.account",
    url: "/account"
    views:
      "tab-account":
        templateUrl: "templates/tab-account.html"
        controller: "AccountCtrl"


  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/tab/messages"
