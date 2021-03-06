var Users = {
	getLabels: function (user_ids, callback, scope) {
		var scope = scope || this;
		$.ajax("/users/user_labels.json",{
			data: {
				user_ids: user_ids.join(",")
			},
			context: scope,
			type: "GET",
			success: function (json) {
				if (json.success) {
					//organize the data
					var data = {};
					$.each(json.labels, function (idx, val) {
						data[String(val["id"])] = {
							nickname: val["nickname"],
							picture: val["picture"],
							picture_small: val["picture_small"]
						};
					}); 
					callback.call(scope, data);
				}
				else {
					console.log('Unable to get user labels');
				}
			}
		});
	}
};