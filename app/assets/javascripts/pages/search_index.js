$(document).ready(function() {
    var qry = $('#information').attr('data-query');
    console.log(qry);
    var source = $("#_post").html();
    var template = Handlebars.compile(source);
    var commentNode = $('#node').html();
    var commentTmpl = Handlebars.compile(commentNode);

    var s = new Signalike.Search({
        query: qry,
        success: function (data) {
            console.log(data);
        }
    });

});