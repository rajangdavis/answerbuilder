var app = angular.module('answer',[])
.controller('answer', function($timeout){
	this.fadeImage = function(src){
		var temp_src = src;
		this.picture = undefined;
		var self = this;
		$timeout(function(){
			self.picture = temp_src;
			var img = document.querySelectorAll('[img-height]')[0];
			var gutter = (400 - img.height)/8;
			img.style.margin = gutter+'px auto';
		},100)
	}
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
			element[0].style.height = '500px';
		}
	};
});