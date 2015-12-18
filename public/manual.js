var app = angular.module('manual',['ui.router'])
.controller('manual',function($http,$scope){
	$scope.manual = undefined;
	$scope.categories = undefined;
	$scope.answersList = undefined;
	$scope.currentCategory = undefined;
	$scope.initialize = function(){
		$http({
		  method: 'GET',
		  url: '//qseecode.herokuapp.com/qtpojo.json'
		}).then(function successCallback(response) {
		    $scope.manual = response.data;
		    for (var i = 0; i < $scope.manual.length; i++) {
		    	for (var k in $scope.manual[i]) {
			        if ($scope.manual[i].hasOwnProperty(k)) {
			           $scope.categories = $scope.manual[i][k];
			           for (var l = 0; l < $scope.categories.length; l++) {
			           		for (var j in $scope.categories[l]) {
						        if ($scope.categories[l].hasOwnProperty(j)) {
						           $scope.answersList = $scope.categories[l][j];
						        }
						    }
			           };
			        }
			    }
		    };
		    
		  }, function errorCallback(response) {
		    console.log(response);
		  });
	}
	$scope.scc = function(value){
		$scope.currentCategory = value;
	}
})
.config(function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('manual', {
      url: "/",
      template:"<div ng-repeat='(values,instructions) in manual '>"+ 
      				"<div ng-repeat='(value,instruction) in instructions '>"+ 
      					"<a ng-click='scc(value)' ui-sref='categories({ id: {{values}}})'>{{value}}</a>"+
      				"</div>"+
      			"</div>"
    })
    .state('categories', {
      url: "/categories/:id",
      template:"<h1>{{currentCategory}}</h2>"+
      "",
      controller:function($scope,$stateParams){
      	$scope.id = $stateParams.id;
      }
    })
    .state('state2', {
      url: "/state2",
      template:""
    })
});