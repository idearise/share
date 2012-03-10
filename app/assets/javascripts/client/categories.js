//static functions
Signalike.Category = function(conf) {
	conf = conf || {};
	var config = {
		success : conf.success || (function(){}),
		failure : conf.failure || (function(){}),
		context: conf.context || this
	};
	config.data = config.data || {};
	if (conf.category_type_key) {
		config.data.category_type_key = conf.category_type_key;
	}
	if (conf.category_keys) {
		config.data.category_keys = conf.category_keys;
	}

	$.ajax(Signalike.urlFor('categories','scores'), {
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