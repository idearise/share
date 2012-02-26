$(document).ready(function() {
    var post_id = $('#information').attr('data-post-id');
    var app_id = $('#information').attr('data-app-id');
    var source = $("#_post_header").html();
    var template = Handlebars.compile(source);
    var commentNode = $('#node').html();
    var commentTmpl = Handlebars.compile(commentNode);

    var s = new Signalike.Source(post_id);
    s.fetch({
        success: function(data) {
            //display the comments!
            var user_ids = [data.source.user_key];
            var collectUserIds = function(data, root, level) {

                $.each(data,
                function(i, comment) {
                    //identify how much margin-left we want for this
                    //console.log(comment);
                    user_ids.push(comment.user_key);
                    if (root[String(comment.id)]) {
                        collectUserIds(root[String(comment.id)], root, level + 1);
                    }
                });

            };
            collectUserIds(data.comments['-1'] || [], data.comments, 0);
            Users.getLabels(user_ids,
            function(user_data) {
                var fun = function(data, root, level) {
                    var compiled = [];
                    $.each(data,
                    function(i, comment) {
                        //identify how much margin-left we want for this
                        comment.width = level * 46;
                        comment.username = user_data[String(comment.user_key)]["username"];
                        comment.picture_small = user_data[String(comment.user_key)]["picture_small"];
                        //compile
                        compiled.push(commentTmpl(comment));
                        //console.log(comment);
                        //check if this has children and render its children if it has
                        if (root[String(comment.id)]) {
                            compiled = compiled.concat(fun(root[String(comment.id)], root, level + 1));
                        }
                    });
                    return compiled;
                };
                var all = fun(data.comments['-1'] || [], data.comments, 0);
                data.source.username = user_data[String(data.source.user_key)]["username"];
                data.source.picture = user_data[String(data.source.user_key)]["picture"];

                $('#post-header').html(template(data.source));
                $('#post-text').html(data.source.text);
                $('#post-link').html('<a href="' + data.source.url + '">' + data.source.url + '</url>');

                //the edit form
                $('#xlInput').val(data.source.title);
                $('#prependedInput').val(data.source.url);
                $('#textarea2').val(data.source.text);


                if (all.length > 0) {
                    $('#comments-section').html(all.join());
                }
                else {
                    $('#comments-section').html("No comments yet!");
                }
            });
        }

    });

    //new comment
    var f = $('#newcomment');

    f.submit(function() {
        var url = f.attr('action');
        var data = f.serialize();
        //console.log(url);
        //console.log(data);
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: function(object) {
                {
                    console.log(object)
                    if (object.success) {
                        window.location.reload();
                    }
                    else {
                        $('#errors').html(object.errors.join("<br />"));
                        $('#errors-container').attr("style", "visibility: visible");
                    }
                }
            },
            dataType: 'json'
        });
        return false;
    });

    $('#newcomment-save').click(function() {
        f.submit();
    });


    //vote handler
    var voteComment = function(type) {
        //type can be up or down,
        var id = $(this).attr('data-comment-id');

        $.ajax({
            type: 'POST',
            url: '/apps/' + app_id + '/posts/' + post_id + '/comments/' + id + '/vote' + type,
            data: {
                _method: "put"
            },
            success: function(object) {
                {
                    console.log(object)
                    if (object.success) {
                        window.location.reload();
                    }
                    else {
                        //$('#errors').html(object.errors.join("<br />"));
                        //$('#errors-container').attr("style", "visibility: visible");
                        }
                }
            },
            dataType: 'json'
        });
    };

    $('.voteup').live({
        click: function() {
            voteComment.call(this, 'up');
        }
    });

    $('.votedown').live({
        click: function() {
            voteComment.call(this, 'down');
        }
    });

    //vote source
    var voteSource = function(type) {
        //type can be up or down,
        $.ajax({
            type: 'POST',
            url: '/apps/' + app_id + '/posts/' + post_id + '/vote' + type,
            data: {
                _method: "put"
            },
            success: function(object) {
                {
                    console.log(object)
                    if (object.success) {
                        window.location.reload();
                    }
                    else {
                        //$('#errors').html(object.errors.join("<br />"));
                        //$('#errors-container').attr("style", "visibility: visible");
                        }
                }
            },
            dataType: 'json'
        });
    };
    $('.votesourceup').live({
        click: function() {
            voteSource('up');
        }
    });
    $('.votesourcedown').live({
        click: function() {
            voteSource('down');
        }
    });

    //comment reply handler
    $('.response').live({
        click: function() {
            var commentId = $(this).attr('data-comment-id');
            $('#comment_parent_id').attr('value', commentId);

            $('#comment_text').val('');
            //refresh modal data
            //then show modal
            //var $this = $(this).data('show', true)
            //$('#modal-comment-response').modal($this.data());	
        }
    });

    var editPost = $('#editsource');

    editPost.submit(function() {
        var url = editPost.attr('action');
        var data = editPost.serialize();
        console.log(url);
        console.log(data);
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: function(object) {
                {
                    console.log(object)
                    if (object.success) {
                        window.location.reload();
                    }
                    else {
                        $('#errors').html(object.errors.join("<br />"));
                        $('#errors-container').attr("style", "visibility: visible");
                    }
                }
            },
            dataType: 'json'
        })
        return false;
    });



    $('#editsource-save').click(function() {
        editPost.submit();
    });


    $('.editcomment').live({
        click: function() {
            var commentId = $(this).attr('data-comment-id');
            var parentId = $(this).attr('data-parent-id');
            $('#edit_comment_parent_id').attr('value', parentId);
            //console.log(commentId);
            //console.log(parentId);
            //console.log($(commentId+'_comment_text').text())
            $('#editcomment').attr('action', $('#editcomment').attr('action') + '/comments/' + commentId + '.json');
            $('#edit_comment_text').val($('#' + commentId + '_comment_text').text());
            //refresh modal data
            //then show modal
            //var $this = $(this).data('show', true)
            //$('#modal-comment-response').modal($this.data());	
        }
    });

    var editComment = $('#editcomment');

    editComment.submit(function() {
        var url = editComment.attr('action');
        var data = editComment.serialize();
        console.log(url);
        console.log(data);
        $.ajax({
            type: 'POST',
            url: url,
            data: data,
            success: function(object) {
                {
                    //console.log(object)
                    if (object.success) {
                        window.location.reload();
                    }
                    else {
                        $('#errors').html(object.errors.join("<br />"));
                        $('#errors-container').attr("style", "visibility: visible");
                    }
                }
            },
            dataType: 'json'
        })
        return false;
    });



    $('#editcomment-save').click(function() {
        editComment.submit();
    });

});