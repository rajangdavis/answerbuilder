var app = angular.module('answer',['ngSanitize'])
.controller('answer', function($timeout){
	var self = this;
	self.currentIndex = 0;
    self.absIndex = 1;
    self.stepLength = 0;
    self.language = 'en';

    self.rotateArr = function(i,tn){
        self.absIndex = tn;
        if(i!=0){
            self.answer.steps = self.answer.steps.slice(i).concat(self.answer.steps.slice(0, i));
        }
        document.querySelectorAll('.steps.container')[0].scrollTop = 0;
    }

    self.isLast = function(arr,i){
        self.stepLength = arr.length;
        var index = i;
        return self.stepLength == index ? true : false
    }

    self.isCurrentStepIndex = function (index) {
        return self.currentIndex === index;
    };

    self.changeLanguage = function(){
        self.language = self.language == 'en'? 'jp' : 'en';
    }
})
.directive('imgHeight', function($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element) {
          $timeout(function(){
          var imageHeight = element[0].clientHeight;
          var marginOpt1 = (600 - imageHeight)/2;
            if(imageHeight<600 && imageHeight>0){
              element[0].style.margin = marginOpt1+"px auto";
              element[0].style.display = 'block';
            }else if(imageHeight==600){
              element[0].style.height = (imageHeight*.97)+"px"; 
            }
          },550); 
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
                var ideal_height = 700/how_many_steps;
                if(how_many_steps < 7){
                    elem[0].style.minHeight = ideal_height + 'px';
                }
            },500)
        }
    }
});