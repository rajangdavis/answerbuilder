var app = angular.module('manual',['ui.router'])
.controller('manual',function($http,$scope,$timeout){
	$scope.manual;
	$scope.categories = [];
	$scope.answersList = [];
	$scope.currentCategory;
	$scope.initialize = function(){
		$http({
		  method: 'GET',
		  url: '//qseecode.herokuapp.com/qtpojo.json'
		}).then(function successCallback(response) {
		    $scope.manual = response.data;
		    console.log($scope.manual);
		  }, function errorCallback(response) {
		    console.log(response);
		  });
	}
	$scope.scc = function(value){

	}
})
.config(function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('manual', {
      url: "/",
      template:"<div ng-repeat='(i,method) in manual'>"+ 
      				"<a ui-sref='categories({id: i})'>{{method.device}}</a>"+
      			"</div>"
    })
    .state('categories', {
      url: "/categories/:id",
      template:"<h1>{{manual[id].device}}</h1>"+
      			"<div ng-repeat='(i,category) in manual[id].categories'>"+ 
      				"<a ui-sref='topics({id: i,cat_id: id})'>{{category.category}}</a>"+
      			"</div>",
      controller:function($scope,$stateParams){
      	$scope.id = $stateParams.id;
      }
    })
    .state('topics', {
      url: "/categories/:cat_id/topics/:id",
      template:"<h1>{{manual[id].device}}</h1>"+
      		   "<h2>{{manual[id].categories[cat_id].category}}</h2>"+
      			"<div ng-repeat='answer in manual[id].categories[cat_id].answers[0]'>"+ 
      				"<a ui-sref=''>{{answer.title}}</a>"+
      			"</div>",
      controller:function($scope,$stateParams){
      	$scope.id = $stateParams.id;
      	$scope.cat_id = $stateParams.cat_id;
      }
    })
});