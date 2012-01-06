Signalike.Source = function (id) {
	var self = this;
	if (!id) {
		throw(new Error("id for Signalike.Source is required"));
	}
	this.fetch = function (conf) {
		conf = conf || {};
		var config = {
			success : conf.success || (function(){}),
			failure : conf.failure || (function(){}),
			context: conf.context || self
		};

		$.ajax(Signalike.urlFor('sources', id), {
			dataType: 'JSONP',
			context: config.context,
			type: "GET",
			success: function (data) {
				//console.log(data);
				if (data.success) {
					config.success.apply(config.context, [data]);
				}
				else {
					config.failure.apply(config.context, [data]);
				}

			}
		});
	};

};
//static functions
Signalike.Source.top = function (conf) {
	conf = conf || {};
	var config = {
		success : conf.success || (function(){}),
		failure : conf.failure || (function(){}),
		context: conf.context || this
	};


	$.ajax(Signalike.urlFor('sources'), {
		dataType: 'JSONP',
		context: config.context,
		type: "GET",
		success: function (data) {
			//console.log(data);
			if (data.success) {
				config.success.apply(config.context, [data]);
			}
			else {
				config.failure.apply(config.context, [data]);
			}

		}
	});
};

Signalike.Source.latest = function (conf) {
	conf = conf || {};
	var config = {
		success : conf.success || (function(){}),
		failure : conf.failure || (function(){}),
		context: conf.context || this
	};

	$.ajax(Signalike.urlFor('sources','latest'), {
		dataType: 'JSONP',
		context: config.context,
		type: "GET",
		success: function (data) {
			//console.log(data);
			if (data.success) {
				config.success.apply(config.context, [data]);
			}
			else {
				config.failure.apply(config.context, [data]);
			}

		}
	});
};