


$(document).on("turbolinks:load",function(){
	var md = sanitize($('<%= @info.body %>').val());
    var html = marked(md)
    $('#show_marked').html(html);
    $('#show_marked pre code').each(function(i, e) {
        $(e).text(unsanitize($(e).text()));
        hljs.highlightBlock(e, e.className);
    });
});






