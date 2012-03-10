$(document).ready(function() {
	// Get the app ids that need number of posts
	var categoryTypeKey = $('#information').attr('data-category-type-key');
	var categoryScores = $('div[data-placeholder="category-score"]');
	var categoryKeys = []
	$.each(categoryScores, function(idx, d) {
		categoryKeys.push($(d).data("category-key"));
	});

	// Show the number of posts per app displayed on the page
  var d = new Signalike.Category({
	  	category_type_key: categoryTypeKey,
      category_keys: categoryKeys.join(","),
      success: function(scores) {
				$.each(scores.items, function (idx, i) {
					$("#category-"+i["category_key"]).html(i["score"]+" Posts");
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
					i.nickname = user_data[i["user_key"]]["nickname"];
          			i.picture_small = user_data[i["user_key"]]["picture_small"];
					compiled.push(template(i));
				});
				$('#latest_sources_list').html(compiled.join(''));
			});
			
			
		}
	});
	
});