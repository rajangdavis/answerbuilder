var app = angular.module('manual',[])
.controller('manual',function($http){
	var self = this;
	this.manual = [];
	$http({
	  method: 'GET',
	  url: '//qseecode.herokuapp.com/qtpojo.json'
	}).then(function successCallback(response) {
	    console.log(response);
	  }, function errorCallback(response) {
	    console.log(response);
	  });
})