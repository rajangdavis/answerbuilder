var app = angular.module('manual',[])
.controller('manual',function($http){
	var self = this;
	self.manual = undefined;
	$http({
	  method: 'GET',
	  url: '//qseecode.herokuapp.com/qtpojo.json'
	}).then(function successCallback(response) {
	    self.manual = response.data;
	    console.log(self.manual)
	  }, function errorCallback(response) {
	    console.log(response);
	  });
})