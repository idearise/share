//static functions
Signalike.Dimension = function(conf) {
	conf = conf || {};
	var config = {
		success : conf.success || (function(){}),
		failure : conf.failure || (function(){}),
		context: conf.context || this
	};
	config.data = config.data || {};
	if (conf.dimension_type_key) {
		config.data.dimension_type_key = conf.dimension_type_key;
	}
	if (conf.dimension_keys) {
		config.data.dimension_keys = conf.dimension_keys;
	}

	$.ajax(Signalike.urlFor('dimensions','scores'), {
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