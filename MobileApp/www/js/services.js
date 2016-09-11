angular.module('robonotes.services', [])
.factory('authInterceptor', function($location, $q, $window) {
  return {
    request: function(config) {
      config.headers = config.headers || {};

      config.headers.Authorization = window.localStorage['authToken'];

      return config;
    }
  };
})
.service(
  "notificationService",
  function( $http, $q, DOMAIN ) {
    return {
      // Retrieves all notifications for customer, sorted by date
      retrieve: function() {
        var request = $http({
          url: DOMAIN + '/api/v1/notifications.json',
          method: "get",
          headers : {
            'Content-Type': 'application/json',
          },
        });
        return request;
      }
    }
  }
)
.service(
  "loginService",
  function( $http, $q, DOMAIN) {
    return({
      getToken: getToken,
    });

    function getToken(email, password) {
      var request = $http({
        url: DOMAIN + '/api/v1/authentication',
        method: "post",
        headers : {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
        },
        data: $.param({ email: email, password: password }),
      });
      return request;
    }
  }
)
