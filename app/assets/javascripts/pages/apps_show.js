$(document).ready(function() {
	var app_id = $('#information').attr('data-app-id');
	Signalike.Source.top({
		dimension: app_id,
		success: function (sources) {
			var source   = $("#_post").html();
			var template = Handlebars.compile(source);
			//sources.items is the list of sources
			//sources.total is the number of sources in the list
			var compiled = [];
			var limit = 20;
			var i;
			var data = [];
			var user_ids = [];
			limit = Math.min(limit,sources.items.length);
			for(var x = 0; x < limit; x++) {
				i = sources.items[x];
				user_ids.push(i.user_id);
				data.push(i);
			}
			if (data.length > 0) {
				Users.getLabels(user_ids, function (user_data) {
					$.each(data, function (idx, i) {
						i.username = user_data[i["user_id"]]["username"];
            i.picture_small = user_data[i["user_id"]]["picture_small"];
						compiled.push(template(i))
					});
					$('#sources').html(compiled.join(''));

					//console.log(sources);
					//console.log($("#pagination"))
					$("#pagination").html('<ul><li class="prev disabled"><a href="#">&larr; Previous</a></li><li class="active"><a href="#">1</a></li><li><a href="#">2</a></li><li><a href="#">3</a></li><li class="next"><a href="#">Next &rarr;</a></li></ul>');
				});
			}
			else {
				$('#sources').html("No posts yet!");
			}
			
			//get the handlebar template
			//source   = $("#_post").html();
			//template = Handlebars.compile(source);
			////sources.items is the list of sources
			////sources.total is the number of sources in the list
			//compiled = [];
			//$.each(sources.items, function (idx, i) {
			//	compiled.push(template(i));
			//});
			  
			//$('#latest_sources_list').html(compiled.join(''));
		}
	});
	
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