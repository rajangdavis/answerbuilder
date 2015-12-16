var app = angular.module('answer',[])
.controller('answer', function($timeout,$scope){
	var self = this;
	self.instruction = undefined;
	self.picture = undefined;
	self.currentIndex = 0;

	// self.fadeImage = function(src,step){
	// 	self.picture = undefined;
	// 	$timeout(function(){
	// 		self.inst = step;
	// 		self.picture = src;			
	// 		var img = document.querySelectorAll('[img-height]')[0];
	// 		var gutter = (400 - img.height)/8;
	// 		img.style.margin = gutter+'px auto';
	// 	},200)
	// 	// $scope.$apply();
	// }
	self.setCurrentStepIndex = function (index) {
        self.currentIndex = index;
    };

    self.isCurrentStepIndex = function (index) {
        return self.currentIndex === index;
    };
    self.prevStep = function (scope) {
        self.currentIndex = (self.currentIndex < scope.length - 1) ? ++self.currentIndex : 0;
    };

    self.nextStep = function (scope) {
        self.currentIndex = (self.currentIndex > 0) ? --self.currentIndex : scope.length - 1;
    };
})
.directive('imgHeight', function($timeout){
	return {
		link: function($scope, elem, attrs){
			
			$timeout(function(){
				console.log(elem[0].height)
			},200)
		}
	}
})
