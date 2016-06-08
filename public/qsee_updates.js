var url = "https://qseeupdates.firebaseio.com/";
var firebase = new Firebase(url);
var posts = new Firebase(url+"posts");

var app = angular.module('qsee_updates',['ui.router','firebase','angularTrix'])
.controller('qsee_updates_ctrl',function($scope,$timeout,$state,$firebaseArray){

	function _init(){
		$scope.authData = firebase.getAuth();
		$scope.posts = $firebaseArray(posts);
	}
	
	_init();

	$scope.error = undefined;

	if($scope.authData){
		$scope.loggedIn = true;
	}else{
		$scope.loggedIn = false;
	}

	$scope.checkIfLoggedIn = function(){
		$timeout(function(){
			if(!$scope.loggedIn){
				$state.go('login');
			}
		});
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

	$scope.createPost = function(title,content){
		var newPost = posts.push();
		newPost.set({
			title: title,
			content: content,
			id:newPost.path.o[1]
		}, function(error) {
			if (error) {
				console.log("Data could not be saved." + error);
			} else {
				$state.go('show',{id:newPost.path.o[1]});
			}
		});
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
    			$state.go('home')
    		}
    	}	
	})
	.state('home', {
    	url: "/home",
    	templateUrl:'partials/list.html',
    	controller: function($scope,$state,$timeout){
    		$scope.checkIfLoggedIn()
    	}
	})
	.state('new', {
    	url: "/new",
    	templateUrl:'partials/create.html',
    	controller: function($scope,$state,$timeout){
    		$scope.checkIfLoggedIn()
    	}
	})
	.state('show', {
    	url: "/show?id",
    	templateUrl:'partials/show.html',
    	controller: function($scope,$state,$timeout,$stateParams,$firebaseObject){
    		$scope.checkIfLoggedIn()
    		if($stateParams.id){
    			var postUrl = $firebaseObject(posts.child($stateParams.id));
    			$scope.post = postUrl.$$conf.binding.rec;
    		}
    	}
	})
})
.directive('dynamic', function ($compile,$timeout) {
  return {
    restrict: 'A',
    replace: true,
    transclude: true,
    link: function (scope, ele, attrs) {
      //this is so we can have content load in and bind to the DOM via AJAX
      scope.$watch(attrs.dynamic, function(html) {
        var answerContainer = document.getElementById('answer-container');
        if(answerContainer){
          answerContainer.parentElement.removeChild(answerContainer);
        }
        $timeout(function(){
          ele.html(html);
          $compile(ele.contents())(scope)
        })  
      });
    }
  };
})