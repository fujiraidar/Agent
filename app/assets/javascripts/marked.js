
var highlight = function(code, lang, callback){
  return hljs.highlight(lang,code).value;
}
var renderer = new marked.Renderer;
renderer.code = function(code, fileInfo, escaped) {
  var delimiter = ':';
  var info = fileInfo.split(delimiter);
  var lang = info.shift();
  var fileName = info.join(delimiter); // 2つ目以降のdelimiterはファイル名として扱う
  var fileTag = '';
  if (fileName) {
    fileTag = '<div class="filename">'+fileName+'</div>'
  }

  if (this.options.highlight) {
    var out = this.options.highlight(code, lang);
    if (out != null && out !== code) {
      escaped = true;
      code = out;
    }
  }

  if (!lang) {
    return '<pre>'+fileTag+'<code>'
      + (escaped ? code : escape(code, true))
      + '\n</code></pre>';
  }

  return '<pre>'+fileTag+'<code class="'
    + this.options.langPrefix
    + escape(lang, true)
    + '">'
    + (escaped ? code : escape(code, true))
    + '\n</code></pre>\n';
};

renderer.table = function(header, body) {
    if (body) body = '<tbody>' + body + '</tbody>';

    return '<table class="table table-hover">'
    + '<thead>'
    + header
    + '</thead>'
    + body
    + '</table>';
};


$(document).on("turbolinks:load",function(){
console.log('こんにちは');
	marked.setOptions({
	// Githubっぽいmd形式にするか
	gfm: true,
	// Githubっぽいmdの表にするか
	tables: true,
	// Githubっぽいmdの改行形式にするか
	breaks: true,
	// Markdownのバグを修正するか
	pedantic: false,
	// HTML文字をエスケープするか
	sanitize: true,
	// スマートなリストにするか。
	smartLists: true,
	// クオートやダッシュの使い方。
	smartypants: false,

	baseUrl: 'https://',

	langPrefix: '',

	renderer: renderer,

	highlight: highlight,

	});

	console.log('こんにちは');

    $('#edit').keyup(function() {
    	console.log('こんにちは');
        var md = sanitize($(this).val());
        var html = marked(md)
        $('#preview').html(html);
        $('#preview pre code').each(function(i, e) {
        	console.log('こんにちは');
            $(e).text(unsanitize($(e).text()));
            hljs.highlightBlock(e, e.className);
        });
    });

});

function sanitize(html) {
    return $('<div />').text(html).html().replace(/&gt;/g, ">");
}
function unsanitize(html) {
    return $('<div />').html(html).text();
}




