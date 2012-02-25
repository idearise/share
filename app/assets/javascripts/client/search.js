//static functions
Signalike.Search = function(conf) {
	conf = conf || {};
	var config = {
		success : conf.success || (function(){}),
		failure : conf.failure || (function(){}),
		context: conf.context || this
	};
	config.data = config.data || {};
	if (conf.query) {
		config.data.query = conf.query;
	}

	$.ajax(Signalike.urlFor('search'), {
		dataType: 'JSONP',
		data: config.data,
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