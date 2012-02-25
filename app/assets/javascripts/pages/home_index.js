$(document).ready(function() {
	Signalike.Source.top({
		start: 0,
		count: 10,
		success: function (sources) {
			//get the handlebar template
			var source   = $("#_post").html();
			var template = Handlebars.compile(source);
			//sources.items is the list of sources
			//sources.total is the number of sources in the list
			var compiled = [];
			
			Users.getLabels($.map(sources.items, function (i, idx) {
				return i.user_id;
			}), function (user_data) {
				$.each(sources.items, function (idx, i) {
					i.nickname = user_data[i["user_id"]]["nickname"];
          			i.picture_small = user_data[i["user_id"]]["picture_small"];
					compiled.push(template(i))
				});
				$('#latest_sources_list').html(compiled.join(''));
			});
			
			
		}
	});
	
});