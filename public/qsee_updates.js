var url = "https://qseeupdates.firebaseio.com/";
var firebase = new Firebase(url);
var app = angular.module('qsee_updates',['ui.router','firebase'])
.controller('qsee_updates_ctrl',function($scope,$timeout,$state){
	
	function _init(){
		$scope.authData = firebase.getAuth();
	}

	_init();

	$scope.error = undefined;

	if($scope.authData){
		$scope.loggedIn = true;
	}else{
		$scope.loggedIn = false;
	}

	function authDataCallback(authData) {
    	$timeout(function(){
			if (authData) {
				_init();
        		$scope.loggedIn = true;
	        } else {
	          	_init();
	          	$scope.loggedIn = false;
	        }
        });
    }
	
	//Register the callback to be fired every time auth state changes
    firebase.onAuth(authDataCallback);
          
	// logs people in 
    $scope.logIn = function(username,password){
	    firebase.authWithPassword({
	    	email: username,
	    	password: password
	    }, function(error, authData) {
		    if (error) {
				$scope.error = "Login Failed! " + error;
		    } else {
		    	$scope.error = undefined;
				$scope.loggedIn = true;
				$scope.$apply();
				$state.go('home');
		    }
      	}
      	// ,{remember: "sessionOnly"}
    	);
	};
        //logs people out

	$scope.logOut = function(){
		firebase.unauth()
        $scope.loggedIn = false;
        $state.go('login');
	}    
})
.config(function($stateProvider, $urlRouterProvider) {
	$urlRouterProvider.otherwise("/login");
	$stateProvider
    .state('login', {
    	url: "/login",
    	templateUrl:'partials/login.html',
    	controller: function($scope,$state){
    		if($scope.loggedIn){
    			$state.go('home');
    		}
    	}
	})
	.state('home', {
    	url: "/home",
    	templateUrl:'partials/list.html',
    	controller: function($scope,$state,$timeout){
    		$timeout(function(){
    			if(!$scope.loggedIn){
					$state.go('login');
				}
    		})
    	}
	})
})