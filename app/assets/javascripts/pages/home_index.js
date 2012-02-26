$(document).ready(function() {
	// Get the app ids that need number of posts
	var dimensionTypeKey = $('#information').attr('data-dimension-type-key');
	var dimensionScores = $('div[data-placeholder="dimension-score"]');
	var dimensionKeys = []
	$.each(dimensionScores, function(idx, d) {
		dimensionKeys.push($(d).data("dimension-key"));
	});

	// Show the number of posts per app displayed on the page
  var d = new Signalike.Dimension({
	  	dimension_type_key: dimensionTypeKey,
      dimension_keys: dimensionKeys.join(","),
      success: function(scores) {
				$.each(scores.items, function (idx, i) {
					$("#dimension-"+i["dimension_key"]).html(i["score"]+" Posts");
				});
      }
  });


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
				return i.user_key;
			}), function (user_data) {
				
				$.each(sources.items, function (idx, i) {
					//console.log(i)
					i.username = user_data[i["user_key"]]["username"];
          			i.picture_small = user_data[i["user_key"]]["picture_small"];
					compiled.push(template(i));
				});
				$('#latest_sources_list').html(compiled.join(''));
			});
			
			
		}
	});
	
});