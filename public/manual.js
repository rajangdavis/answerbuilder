var app = angular.module('manual',['ui.router','ngSanitize'])
.controller('manual',function($http,$scope,$timeout,$rootScope,$sce){
	$scope.manual;
  $scope.answer;
	$scope.initialize = function(){
		$http({
		  method: 'GET',
		  url: '/qtpojo.json'
		}).then(function successCallback(response) {
		    $scope.manual = response.data;
        
      }, function errorCallback(response) {
		    
		  });
	}
    
   
  $rootScope.previousState;
	$rootScope.currentState;
	$rootScope.$on('$stateChangeSuccess', function(ev, to, toParams, from, fromParams) {
	    $rootScope.previousState = from.name;
	    $rootScope.currentState = to.name;
	});
})
.config(function($stateProvider, $urlRouterProvider) {

  $urlRouterProvider.otherwise("/devices/0");

  $stateProvider
    .state('start', {
      url: "/",
      template:"<div ng-repeat='(dev_id,method) in manual'>"+ 
              "<a ui-sref='devices({dev_id: dev_id})'>{{method.device}}</a>"+
            "</div>"
    })
    .state('devices', {
      url: "/devices/:dev_id",
      template: "<a ui-sref='start'>Device Selection >  </a>"+
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
      template:"<a ui-sref='start'>Device Selection >  </a>"+
             "<a ui-sref='devices({dev_id: dev_id})'>{{manual[dev_id].device}}</a>  >  "+
             "<a ui-sref='categories({dev_id: dev_id,cat_id: cat_id})'>{{manual[dev_id].categories[cat_id].category}}</a>"+
             "<br><br>"+
            "<div ng-repeat='answer in manual[dev_id].categories[cat_id].answers'>"+ 
              "<a ui-sref='answer({dev_id: dev_id, cat_id: cat_id, ans_id: $index})'"+
              ">{{answer.title}}</a>"+
            "</div>",
      controller:function($scope,$stateParams,$timeout,$state,$rootScope){
        $scope.dev_id = $stateParams.dev_id;
        $scope.cat_id = $stateParams.cat_id;
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
      url: "/devices/:dev_id/categories/:cat_id/answer/:ans_id",
      templateUrl:'answer.html',
      controller:function($scope,$stateParams,$timeout){
        $scope.dev_id = $stateParams.dev_id;
        $scope.cat_id = $stateParams.cat_id;
        $scope.ans_id = $stateParams.ans_id;

        $scope.currentIndex = 0;
        $scope.absIndex = 1;
        $scope.stepLength = 0;
        $scope.language;
        $timeout(function(){
          $scope.answer = $scope.manual[$scope.dev_id].categories[$scope.cat_id].answers[$scope.ans_id];
          $scope.steps = $scope.answer.steps
        },100)
         $scope.rotateArr = function(i,tn){
          if(i!=0 && tn <= $scope.stepLength){
            if (tn == 0){
                  $scope.absIndex = $scope.stepLength;
              }
              else{
                  $scope.absIndex = tn;
              }
              $scope.steps = $scope.steps.slice(i).concat($scope.steps.slice(0, i));
          }else if(tn > $scope.stepLength){
              $scope.absIndex = 1;
              $scope.steps = $scope.steps.slice(i).concat($scope.steps.slice(0, i));
          }
          document.querySelectorAll('.steps.container')[0].scrollTop = 0;
      }  
          

      $scope.isLast = function(arr,i){
          $scope.stepLength = arr.length;
          var index = i;
          return $scope.stepLength == index ? true : false
      }

      $scope.isCurrentStepIndex = function (index) {
          return $scope.currentIndex === index;
      };
      }
    })
})
.directive('imgHeight', function($timeout,$rootScope) {
    return {
        restrict: 'A',
        link: function(scope, element) {
          $timeout(function(){
              setInterval(function(){
                if($rootScope.currentState=='answer'){
                  var imageHeight = element[0].clientHeight;
                  var winWidth = window.innerWidth;
                  var titleBarHeight = document.querySelectorAll('.title-bar')[0].offsetHeight;
                  if (winWidth > 768){
                      var marginOpt1 = (titleBarHeight - imageHeight)/2;
                          if(imageHeight<titleBarHeight && imageHeight>0){
                            element[0].style.margin = marginOpt1+"px auto";
                            element[0].style.display = 'block';
                          }else if(imageHeight==titleBarHeight){
                            element[0].style.height = (imageHeight*.97)+"px"; 
                          }
                  }
                  else if (winWidth > 0 && winWidth < 768){
                      var marginOpt1 = (220 - imageHeight)/2;
                          if(imageHeight<220 && imageHeight>0){
                            element[0].style.margin = marginOpt1+"px auto";
                            element[0].style.display = 'block';
                          }else if(imageHeight==220){
                            element[0].style.height = (imageHeight*.97)+"px"; 
                          }
                  }
                }
              },100)
          },550); 
        }
    };
})
.directive('stepHeight', function($timeout,$rootScope){
    return {
        
        restrict: 'A',
        link: function(scope, elem, attrs){
            $timeout(function(){
              if($rootScope.state=='answer'){
                var how_many_steps= scope.steps.length;
                var ideal_height = 700/how_many_steps;
                if(how_many_steps < 7){
                    elem[0].style.minHeight = ideal_height + 'px';
                }
              }
            },500)
        }
    }
})
.directive('removeUpperElems', function($timeout,$rootScope){
    return {
        
        restrict: 'A',
        link: function(scope, elem, attrs){
            $timeout(function(){
              if($rootScope.currentState=='answer'){
                var pad30 = document.querySelectorAll('.pad30');
                var title = document.getElementById('rn_PageTitle');
                if(pad30.length){
                    pad30[0].classList.remove('pad30');
                }
                if(title){
                    title.style.display = 'none';
                }
                if(document.getElementById('rn_MainColumn')){
                    document.getElementById('rn_MainColumn').className = 'container-fluid';
                }
              }
            },500)
        }
    }
})
.directive('titleHolderRight', function($timeout,$rootScope){
    return{
        restrict: 'A',
        link: function(scope,elem, attrs){
            $timeout(function(){
              if($rootScope.currentState=='answer'){
                setInterval(function(){
                    var titleRight = document.querySelectorAll('.title-right')[0];
                    var title = document.querySelectorAll('.title-right h1 span:not(.ng-hide)')[0];
                    if(document.querySelectorAll('.left-series').length){
                        var seriesHeight = document.querySelectorAll('.left-series')[0].clientHeight;
                        titleRight.style.height = seriesHeight + 'px';
                    }else{
                      if(titleRight){
                        titleRight.style.height = (title.offsetHeight+15) + 'px';
                      }
                    }
                },100)
              }
            })
        }
    }
})
.directive('titleRight',function($timeout,$rootScope){
    return{
        
        restrict: 'A',
        link:function(scope,elem,attrs){
            $timeout(function(){
              if($rootScope.currentState=='answer'){
                setInterval(function(){
                    var titleHeight = elem[0].offsetHeight;
                    if(document.querySelectorAll('.title-right').length){
                      var titleRightHolder = document.querySelectorAll('.title-right')[0].clientHeight;
                    }
                    var leftSeries = document.querySelectorAll('.left-series')[0]
                    var style = window.getComputedStyle(elem[0], null).getPropertyValue('font-size');
                    var fontSize = parseFloat(style);
                    var winWidth = window.innerWidth;
                    
                    if( titleHeight < titleRightHolder){
                        elem[0].style.marginTop = ((titleRightHolder-titleHeight)/3)+'px';
                        if(winWidth > 999){
                            elem[0].style.fontSize = '37px';
                        }
                    }
                    else if(titleHeight > titleRightHolder){
                        elem[0].style.fontSize = (.70*fontSize)+'px';
                        elem[0].style.paddingLeft = '20px';
                        leftSeries.style.paddingLeft = 0;
                    }
                },100)
              }
            })
        }
    }
});