angular.module('robonotes.controllers', [])
.controller('NotificationListCtrl',
            function($scope, notificationService, $ionicEventEmitter, DOMAIN) {
  $scope.DOMAIN = DOMAIN;

  notificationService.retrieve().then(function(notifications) {
    $scope.items = notifications.data;
  },
  function() {
    alert("Notification retrieval error");
  });

  // NOTE: even though not visibly used, $ionicEventEmitter is a required
  // dependency for this event listener to work. No documentation on this
  // from Ionic :(
  $scope.$on('cloud:push:notification', function(event, data) {
    $scope.items.unshift(data.message.payload);
    // Since event listeners are outside of the scope of Angular's $waatches,
    // we need to call apply to cause the digest cycle to run, so that the views
    // make the appropriate changes.
    $scope.$apply()
  });
})
.controller('NotificationCtrl', function($scope) {
  $scope.item = {
    company: 'Redtail',
  };
})
.controller('LoginCtrl', function($scope, $http, $log, loginService, $location,
                                  $ionicPopup, $ionicLoading, $rootScope) {
  $scope.data = {
    email: window.localStorage['email'],
    password: window.localStorage['password'],
  }

  $scope.login = function() {
    $ionicLoading.show({
      template: 'Loading...'
    })
    var data = $scope.data;

    loginService.getToken(data.email, data.password)
                .then(function(response) {
                  $ionicLoading.hide()
                  console.log("Auth token stored");

                  //Save email, password, and authtoken in storage for later use
                  window.localStorage['authToken'] = response.data.token;
                  window.localStorage['email'] = data.email;
                  window.localStorage['password'] = data.password;

                  $location.path('/notification_list')
                }, function(response) {
                  $ionicLoading.hide()

                  $ionicPopup.alert({
                    title: 'Login',
                    template: 'Wrong username/password combination'
                  });
                });
  };
});

