$(document).ready(function() {
    var qry = $('#information').attr('data-query');
    console.log(qry);
    var source = $("#_post").html();
    var sourceTemplate = Handlebars.compile(source);
    var commentNode = $('#node').html();
    var commentTemplate = Handlebars.compile(commentNode);

    var s = new Signalike.Search({
        query: qry,
        success: function (results) {
            var sourcesCompiled = [];
            var commentsCompiled = [];
            var s, c;
            var sourcesData = [];
            var commentsData = [];
            var sourcesUserIds = [];
            var commentsUserIds = [];

            for(var x = 0; x < results.sources.length; x++) {
                s = results.sources[x];
                sourcesUserIds.push(s.user_id);
                sourcesData.push(s);
            }
            for(var x = 0; x < results.comments.length; x++) {
                c = results.comments[x];
                commentsUserIds.push(c.user.key);
                commentsData.push(c);
            }

            if (sourcesData.length > 0) {
                Users.getLabels(sourcesUserIds, function (userData) {
                    $.each(sourcesData, function (idx, i) {
                        i.nickname = userData[i["user_id"]]["nickname"];
                        i.picture_small = userData[i["user_id"]]["picture_small"];
                        sourcesCompiled.push(sourceTemplate(i));
                    });
                    $('#posts').html(sourcesCompiled.join(''));
                });
            }
            else {
                $('#posts').html("No results");
            }

            if (commentsData.length > 0) {
                Users.getLabels(commentsUserIds, function (userData) {
                    $.each(commentsData, function (idx, i) {
                        i.nickname = userData[commentsData[idx]["user"]["key"]]["nickname"];
                        i.picture_small = userData[commentsData[idx]["user"]["key"]]["picture_small"];
                        i.dimension_key = commentsData[idx]["dimensions"][0]["key"];
                        commentsCompiled.push(commentTemplate(i));
                    });
                    $('#comments').html(commentsCompiled.join(''));
                });
            }
            else {
                $('#comments').html("No results");
            }

        }
    });

});