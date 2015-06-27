angular.module("starter.controllers", []).controller("DashCtrl", ($scope) ->
).controller("MessagesCtrl", ($scope, Messages) ->
  console.log "MessagesCtrl hit!!!!!!!!! "
  $scope.messages = Messages.all()
  $scope.remove = (message) ->
    Messages.remove message
).controller("MessageDetailCtrl", ($scope, $sce, $stateParams, Messages) ->
  console.log "MessageDetailCtrl hit!!!!!!!!! " + $stateParams.messageId
  $scope.message = Messages.get($stateParams.messageId)
  $scope.messageLink = $sce.trustAsResourceUrl($scope.message.link)
  console.log "MessageDetailCtrl link " + $scope.messageLink
).controller("AccountCtrl", ($scope, $cordovaPush, $cordovaDialogs, $cordovaToast, $http) ->
  $scope.settings =
    enableNotifications: true
    enableDeals: false
).controller "AppCtrl", ($scope, $cordovaPush, $cordovaDialogs, $cordovaToast, $http) ->

# Register

# IOS Notification Received Handler
  handleIosNotification = (notification) ->
    if notification.foreground is "1"
      if notification.body and notification.messageFrom
        $cordovaDialogs.alert notification.body, notification.messageFrom
      else
        $cordovaDialogs.alert notification.alert, "Push Notification Received"
      if notification.badge
        $cordovaPush.setBadgeNumber(notification.badge).then ((result) ->
          console.log "setBadgeNumber success " + result
        ), (err) ->
          console.log "setBadgeNumber error " + err

# background
    else
      if notification.body and notification.messageFrom
        $cordovaDialogs.alert notification.body, "Received background notification " + notification.messageFrom
      else
        $cordovaDialogs.alert notification.alert, "Received background notification without message"
  saveDeviceToken = (type) ->
    console.log "Post token for registered device with data " + $scope.regId

  # call server to save device token
  deleteDeviceToken = ->
    console.log "Deleting device token: " + $scope.regId
  $scope.notifications = []
  ionic.Platform.ready ->
    console.log "AppCtrl ready!!!!!!!!! "
    $scope.register()

  $scope.register = ->
    config = {}
    if ionic.Platform.isIOS()
      config =
        badge: "true"
        sound: "true"
        alert: "true"
    $cordovaPush.register(config).then ((result) ->
      console.log "Register device for push notifications " + result
      $cordovaToast.showShortCenter "Device registered for push notifications: " + result
      $scope.registerDisabled = true
      if ionic.Platform.isIOS()
        $scope.regId = result
        saveDeviceToken "ios"
    ), (err) ->
      console.log "Register device for push notifications " + err


  $scope.$on "$cordovaPush:notificationReceived", (event, notification) ->
    console.log JSON.stringify([ notification ])
    if ionic.Platform.isIOS()
      handleIosNotification notification
      $scope.$apply ->
        $scope.notifications.push JSON.stringify(notification.alert)

  # call server to delete device token
  $scope.unregister = ->
    console.log "Unregister device called"
    deleteDeviceToken()
    $scope.registerDisabled = false