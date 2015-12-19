var app = angular.module('manual',['ui.router','ngSanitize'])
.controller('manual',function($http,$scope,$timeout,$rootScope,$sce){
	$scope.manual;
	$scope.currentIndex = {'index':0};
	$scope.initialize = function(){
		$http({
		  method: 'GET',
		  url: '/qtpojo.json'
		}).then(function successCallback(response) {
		    $scope.manual = response.data;
		  }, function errorCallback(response) {
		    console.log(response);
		  });
	}

  function ObjectLength( object ) {
      var length = 0;
      for( var key in object ) {
          if( object.hasOwnProperty(key) ) {
              ++length;
          }
      }
      return length;
  };

  $scope.shouldBeHidden = false;

	$scope.setCurrentStepIndex = function (index) {
        $scope.currentIndex.index = index;
    };

  $scope.answer_length = 0;

    $scope.isCurrentStepIndex = function (index) {
        $scope.answer_length = ObjectLength($scope.currentIndex) - 1;
        return $scope.currentIndex.index === index;
    };
    $scope.prevStep = function (scope) {
        $scope.currentIndex.index = ($scope.currentIndex.index < scope.length - 1) ? ++$scope.currentIndex.index : 0;       
    };

    $scope.nextStep = function (scope) {
        $scope.currentIndex.index = ($scope.currentIndex.index > 0) ? --$scope.currentIndex.index : scope.length - 1;
    };

    $scope.htmlSafe = function(string){
    	return $sce.trustAsHtml(string)
    }


    $rootScope.previousState;
	$rootScope.currentState;
	$rootScope.$on('$stateChangeSuccess', function(ev, to, toParams, from, fromParams) {
	    $rootScope.previousState = from.name;
	    $rootScope.currentState = to.name;
	});
})
.config(function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/");

  $stateProvider
    .state('start', {
      url: "/",
      template:"<div ng-repeat='(dev_id,method) in manual'>"+ 
      				"<a ui-sref='devices({dev_id: dev_id})'>{{method.device}}</a>"+
      			"</div>"
    })
    .state('devices', {
      url: "/devices/:dev_id",
      template: "<a ui-sref='start'>Start   >  </a>"+
      			"<a ui-sref='devices({dev_id: dev_id})'>{{manual[dev_id].device}}</a>"+
      			"<br><br>"+
      			"<div ng-repeat='(cat_id,category) in manual[dev_id].categories'>"+ 
      				"<a ui-sref='categories({dev_id: dev_id,cat_id: cat_id})'>{{category.category}}</a>"+
      			"</div>",	
      controller:function($scope,$stateParams){
      	$scope.dev_id = $stateParams.dev_id;
      }
    })
    .state('categories', {
      url: "/devices/:dev_id/categories/:cat_id",
      template:"<a ui-sref='start'>Start   >  </a>"+
      		   "<a ui-sref='devices({dev_id: dev_id})'>{{manual[dev_id].device}}</a>  >  "+
      		   "<a ui-sref='categories({dev_id: dev_id,cat_id: cat_id})'>{{manual[dev_id].categories[cat_id].category}}</a>"+
      		   "<br><br>"+
      			"<div ng-repeat='answers in manual[dev_id].categories[cat_id].answers'>"+ 
      				"<a ui-sref='answer({dev_id: dev_id, cat_id: cat_id, ans_id: ans_id})'"+
      				"ng-repeat='(ans_id,answer) in answers'>{{answer.title}}</a>"+
      			"</div>",
      controller:function($scope,$stateParams,$timeout,$state,$rootScope){
      	$scope.dev_id = $stateParams.dev_id;
      	$scope.cat_id = $stateParams.cat_id;
      	var answer_length;
      	$timeout(function(){
      		answer_length = $scope.manual[$scope.dev_id].categories[$scope.cat_id ].answers.length;
      		if(answer_length==1){
      			if($rootScope.previousState!='answer'){
      				$state.go('answer',{'dev_id': $scope.dev_id, 'cat_id': $scope.cat_id, 'ans_id': 0});
      			}else{
      				$state.go('devices',{'dev_id': $scope.dev_id});
      			}
      		}
      	})
      }
    })
    .state('answer', {
      url: "/devices/:cat_id/categories/:dev_id/answer/:ans_id",
      templateUrl:'answer.html',
      controller:function($scope,$stateParams){
      	$scope.dev_id = $stateParams.dev_id;
      	$scope.cat_id = $stateParams.cat_id;
      	$scope.ans_id = $stateParams.ans_id;
      }
    })
});