var app = angular.module('answer',['ngSanitize'])
.controller('answer', function($timeout){
	var self = this;
	self.currentIndex = 0;
    self.absIndex = 1;
    self.stepLength = 0;
    self.language;
    if(document.domain == "qsee-jp.custhelp.com"){
        self.language = 'jp';
    }else{
        self.language = 'en';
    }

    self.rotateArr = function(i,tn){
        
        if(i!=0 && tn <= self.stepLength){
            if (tn == 0){
                self.absIndex = self.stepLength;
            }
            else{
                self.absIndex = tn;
            }
            self.answer.steps = self.answer.steps.slice(i).concat(self.answer.steps.slice(0, i));
        }else if(tn > self.stepLength){
            self.absIndex = 1;
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

    self.changeLanguage = function(lan){
        self.language = lan;
    }
})
.directive('imgHeight', function($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element) {
          $timeout(function(){
              setInterval(function(){
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
              },100)
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
})
.directive('removeUpperElems', function($timeout){
    return {
        controller: 'answer',
        link: function(scope, elem, attrs){
            var self = this;
            $timeout(function(){
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
            },500)
        }
    }
})
.directive('titleHolderRight', function($timeout){
    return{
        controller: 'answer',
        link: function(scope,elem, attrs){
            $timeout(function(){
                setInterval(function(){
                    var titleRight = document.querySelectorAll('.title-right')[0];
                    var title = document.querySelectorAll('.title-right h1 span:not(.ng-hide)')[0];
                    if(document.querySelectorAll('.left-series').length){
                        var seriesHeight = document.querySelectorAll('.left-series')[0].clientHeight;
                        titleRight.style.height = seriesHeight + 'px';
                    }else{
                        titleRight.style.height = (title.offsetHeight+15) + 'px';
                    }                    
                },100)
            })
        }
    }
})
.directive('titleRight',function($timeout){
    return{
        controller:'answer',
        link:function(scope,elem,attrs){
            $timeout(function(){
                setInterval(function(){
                    var titleHeight = elem[0].offsetHeight;
                    var titleRightHolder = document.querySelectorAll('.title-right')[0].clientHeight;
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
            })
        }
    }
});