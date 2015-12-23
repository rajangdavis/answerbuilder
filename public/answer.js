var app = angular.module('answer',['ngSanitize'])
.controller('answer', function($timeout,$scope){
	var self = this;
	self.currentIndex = 0;

	self.setCurrentStepIndex = function (index) {
        self.currentIndex = index;
    };

    self.isCurrentStepIndex = function (index) {
        return self.currentIndex === index;
    };
    self.prevStep = function (scope) {
        self.currentIndex = (self.currentIndex < scope.length - 1) ? ++self.currentIndex : 0;
    };

    self.nextStep = function (scope,element) {
        self.currentIndex = (self.currentIndex > 0) ? --self.currentIndex : scope.length - 1;
    };
})
.directive('imgHeight', function($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element) {
          $timeout(function(){
          var imageHeight = element[0].clientHeight;
          var marginOpt1 = (496 - imageHeight)/2;
            if(imageHeight<496 && imageHeight>0){
              element[0].style.margin = marginOpt1+"px auto";
              element[0].style.display = 'block';
            }else if(imageHeight==496){
              element[0].style.height = (imageHeight*.97)+"px"; 
            }
          },500); 
        }
    };
})
.directive('stepHeight', function($timeout){
    return {
        controller: 'answer',
        link: function(scope, elem, attrs){
            var self = this;
            $timeout(function(){
                var how_many_steps= scope.answer_scope.answer.steps.length;
                var ideal_height = 600/how_many_steps;
                if(how_many_steps < 7){
                    elem[0].style.minHeight = ideal_height + 'px';
                }
            },500)
        }
    }
});