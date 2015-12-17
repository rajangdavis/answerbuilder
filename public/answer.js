var app = angular.module('answer',['swipe'])
.controller('answer', function($timeout,$scope){
	var self = this;
	self.instruction = undefined;
	self.picture = undefined;
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

    self.nextStep = function (scope) {
        self.currentIndex = (self.currentIndex > 0) ? --self.currentIndex : scope.length - 1;
    };
    self.key = function($event){
        console.log($event.keyCode);
        if ($event.keyCode == 38)
            alert("up arrow");
        else if ($event.keyCode == 39)
            alert("right arrow");
        else if ($event.keyCode == 40)
            alert("down arrow");
        else if ($event.keyCode == 37)
            alert("left arrow");
    }
})
.directive('imgHeight', function($timeout){
	return {
		link: function($scope, elem, attrs){
			
			$timeout(function(){
				var trueHeight = elem[0].clientHeight;
				console.log(trueHeight);
			},500)
		}
	}
})
