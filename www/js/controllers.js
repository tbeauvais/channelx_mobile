angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope) {})

.controller('MessagesCtrl', function($scope, Messages) {
  console.log("MessagesCtrl hit!!!!!!!!! ");
  $scope.messages = Messages.all();
  $scope.remove = function(message) {
    Messages.remove(message);
  }
})

.controller('MessageDetailCtrl', function($scope, $sce, $stateParams, Messages) {
  console.log("MessageDetailCtrl hit!!!!!!!!! " + $stateParams.messageId);
  $scope.message = Messages.get($stateParams.messageId);

  $scope.messageLink = $sce.trustAsResourceUrl($scope.message.link);

  console.log("MessageDetailCtrl link " +  $scope.messageLink);


})

.controller('AccountCtrl', function($scope, $cordovaPush, $cordovaDialogs, $cordovaToast, $http) {
  $scope.settings = {
    enableNotifications: true,
    enableDeals: false
  };

})


.controller('AppCtrl', function($scope, $cordovaPush, $cordovaDialogs, $cordovaToast, $http) {
  $scope.notifications = [];


  ionic.Platform.ready(function(){
    console.log("AppCtrl ready!!!!!!!!! ");
    $scope.register();
  });

  // Register
  $scope.register = function () {
    var config = {};

    if (ionic.Platform.isIOS()) {
      config = {
        badge: "true",
        sound: "true",
        alert: "true"
      }
    }

    $cordovaPush.register(config).then(function (result) {

      console.log("Register device for push notifications " + result);

      $cordovaToast.showShortCenter('Device registered for push notifications: ' + result);
      $scope.registerDisabled=true;
      if (ionic.Platform.isIOS()) {
        $scope.regId = result;
        saveDeviceToken("ios");
      }
    }, function (err) {
      console.log("Register device for push notifications " + err)
    });
  };


  $scope.$on('$cordovaPush:notificationReceived', function (event, notification) {
    console.log(JSON.stringify([notification]));
    if (ionic.Platform.isIOS()) {
      handleIosNotification(notification);
      $scope.$apply(function () {
        $scope.notifications.push(JSON.stringify(notification.alert));
      })
    }
  });

  // IOS Notification Received Handler
  function handleIosNotification(notification) {
    if (notification.foreground == "1") {

      if (notification.body && notification.messageFrom) {
        $cordovaDialogs.alert(notification.body, notification.messageFrom);
      } else {
        $cordovaDialogs.alert(notification.alert, "Push Notification Received");
      }

      if (notification.badge) {
        $cordovaPush.setBadgeNumber(notification.badge).then(function (result) {
          console.log("setBadgeNumber success " + result)
        }, function (err) {
          console.log("setBadgeNumber error " + err)
        });
      }
    }
    // background
    else {
      if (notification.body && notification.messageFrom) {
        $cordovaDialogs.alert(notification.body, "Received background notification " + notification.messageFrom);
      } else {
        $cordovaDialogs.alert(notification.alert, "Received background notification without message");
      }
    }
  }

  function saveDeviceToken(type) {
    console.log("Post token for registered device with data " + $scope.regId);
    // call server to save device token
  }

  function deleteDeviceToken() {
    console.log("Deleting device token: " + $scope.regId);
    // call server to delete device token
  }

  $scope.unregister = function () {
    console.log("Unregister device called");
    deleteDeviceToken();
    $scope.registerDisabled=false;
  }

});
