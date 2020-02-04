
marked.setOptions({
// コードのハイライト（今回は割愛）
highlight: function (code, lang, callback) {
require('pygmentize-bundled')({ lang: lang, format: 'html' },
code, function (err, result) {
callback(err, result.toString());
});
},
// Githubっぽいmd形式にするか
gfm: true,
// Githubっぽいmdの表にするか
tables: true,
// Githubっぽいmdの改行形式にするか
breaks: true,
// Markdownのバグを修正する？（よく分からなかったので、とりあえずdefaultのfalseで）
pedantic: false,
// HTML文字をエスケープするか
sanitize: true,
// スマートなリストにするか。pedanticと関わりがあるようなので、こちらもdefaultのtrueで。
smartLists: true,
// クオートやダッシュの使い方。
smartypants: false,

baseUrl: 'https://',

langPrefix: '',

highlight: ''

});