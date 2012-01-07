//this is most likely going to into into
//http://www.signalike.com/embed.js
//Provide a javascript api that consumes the signalike json api

//signalike function library

//namespace
//use handlebars;
var Signalike = {
	endPoint: 'http://192.168.1.9:8081/api/v1', //this should probably be in a yaml configuration file
	urlFor: function () {
		if (arguments.length == 0) {
			throw(new Error("1 or more arguments required"));
		}
		var parts = [this.endPoint];
		for (var x=0; x < arguments.length; x++) {
			parts.push(arguments[x]);
		}
		return parts.join('/') + '.json';
	}
};