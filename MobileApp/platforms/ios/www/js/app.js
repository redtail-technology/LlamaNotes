angular.module('robonotes', ['ionic', 'ionic.cloud', 'robonotes.controllers', 'robonotes.services'])
// .constant('DOMAIN', 'http://localhost:3004')
.constant('DOMAIN', 'http://www.llamanotes.com')
.run(function($ionicPlatform, $ionicPush, $rootScope, DOMAIN) {
  $ionicPlatform.ready(function() {
    // if(window.cordova && window.cordova.plugins.Keyboard) {
    //   // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    //   // for form inputs)
    //   cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);

    //   // Don't remove this line unless you know what you are doing. It stops the viewport
    //   // from snapping when text inputs are focused. Ionic handles this internally for
    //   // a much nicer keyboard experience.
    //   cordova.plugins.Keyboard.disableScroll(true);
    // }
    // if(window.StatusBar) {
    //   StatusBar.styleDefault();
    // }
    //

    $ionicPush.register().then(function(t) {
      return $ionicPush.saveToken(t);
    }).then(function(t) {
      console.log('Token saved:', t.token);
    });
  });
  $rootScope.DOMAINS = DOMAIN;
})
.config(function($ionicCloudProvider) {
  $ionicCloudProvider.init({
    "core": {
      "app_id": "8401471e"
    },
    "push": {
      "sender_id": "SENDER_ID",
      "pluginConfig": {
        "ios": {
          "badge": true,
          "sound": true
        },
        "android": {
          "iconColor": "#343434"
        }
      }
    }
  });
})
.config(function($stateProvider, $urlRouterProvider, $httpProvider) {
  // Enable cross domain calls
  $httpProvider.defaults.useXDomain = true;

  // Remove the header used to identify ajax call  that would prevent CORS from working
  delete $httpProvider.defaults.headers.common['X-Requested-With'];

  // Add auth header to all requests
  $httpProvider.interceptors.push('authInterceptor');

  // Ionic uses AngularUI Router which uses the concept of states
  // Learn more here: https://github.com/angular-ui/ui-router
  // Set up the various states which the app can be in.
  // Each state's controller can be found in controllers.js
  $stateProvider

  .state('notificationList', {
    url: '/notification_list',
    templateUrl: 'templates/notification_list.html',
    controller: 'NotificationListCtrl',
  })
  .state('notification', {
    url: '/notification',
    templateUrl: 'templates/notification.html',
    controller: 'NotificationCtrl',
  })
  .state('login', {
    url: '/login',
    templateUrl: 'templates/login.html',
    controller: 'LoginCtrl',
  })

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/login');
});
