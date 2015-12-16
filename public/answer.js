var app = angular.module('answer',[])
.controller('answer', function($timeout,$scope){
	var self = this;
	this.fadeImage = function(src){
		self.picture = undefined;
		$timeout(function(){
			self.picture = src;			
			var img = document.querySelectorAll('[img-height]')[0];
			var gutter = (400 - img.height)/8;
			img.style.margin = gutter+'px auto';
		},200)
	}
	this.changeStep = function(inst){
		
	}
})
.directive('scrollToMe', function(){
	return {
		link: function($scope, element, iAttrs, controller) {
			element[0].addEventListener('click',function(){
				// element[0].scrollIntoView()
			});
		}
	};
})
.directive('imgHeight', function($timeout){
	return {
		link: function($scope, element, iAttrs) {
			element[0].style.maxHeight = '400px';
			element[0].style.display = 'block';
			$timeout(function(){
				var gutter = (500 - element[0].height)/8;
				element[0].style.margin = gutter+'px auto';
			},100);
		}
	};
})
.directive('stepsList', function(){
	return {
		link: function($scope, element, iAttrs, controller) {
			element[0].style.minHeight = '500px';
		}
	};
});