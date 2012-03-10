var loadSources = function (app_id, start, count) {
	var pagingHandler = function (start, count) {
		loadSources(app_id, start, count);
	};
	
	Signalike.Source.top({
		category: app_id,
		start: start,
		count: count,
		success: function (sources) {
			var source   = $("#_post").html();
			var pagination_source = $("#_pagination").html();
			var template = Handlebars.compile(source);
			//sources.items is the list of sources
			//sources.total is the number of sources in the list
			var compiled = [];
			var limit = 20;
			var i;
			var data = [];
			var user_ids = [];
			var pageInfo = {
				start: start,
				count: count,
				total: sources.total
			};
			
			//console.log(sources);
			limit = Math.min(limit,sources.items.length);
			for(var x = 0; x < limit; x++) {
				i = sources.items[x];
				user_ids.push(i.user_key);
				data.push(i);
			}
			if (data.length > 0) {
				Users.getLabels(user_ids, function (user_data) {
					$.each(data, function (idx, i) {
						i.nickname = user_data[String(i["user_key"])]["nickname"];
            			i.picture_small = user_data[String(i["user_key"])]["picture_small"];
						i.picture = user_data[String(i["user_key"])]["picture"];
						//console.log(user_data);
						//console.log(i);
						compiled.push(template(i))
					});
					$('#sources').html(compiled.join(''));

					//$("#pagination").html('<ul><li class="prev disabled"><a href="#">&larr; Previous</a></li><li class="active"><a href="#">1</a></li><li><a href="#">2</a></li><li><a href="#">3</a></li><li class="next"><a href="#">Next &rarr;</a></li></ul>');
					Pagination('#_pagination').paginate(pageInfo, {
						target: '#pagination',
						infoTarget: '#pageInfo',
						handler: pagingHandler,
						itemLabel: "posts"
					});
				});
			}
			else {
				$('#sources').html("No posts yet!");
			}
			
		}
	});
}
$(document).ready(function() {
	var app_id = $('#information').attr('data-app-id');
	loadSources(app_id, 0, 10);
	
	var f = $('#newsource');
	
	f.submit(function () {
		var url = f.attr('action');
		var data = f.serialize();
		console.log(url);
		console.log(data);
		$.ajax({
		    type: 'POST',
			url: url,
			data: data,
			success: function (object) {{
				console.log(object)
				if (object.success) {
					window.location.reload();
				}
				else {
					$('#errors').html(object.errors.join("<br />"));
					$('#errors-container').attr("style", "visibility: visible");
				}
			}},
			dataType: 'json'
		})
		return false;
	});
	
	$('#newsource-save').click(function () {
		f.submit();
	});
	
});