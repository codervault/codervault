//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//
//= require bootstrap-sprockets
//
//= require highlight/highlight
//= require highlight/highlight.pack
//

$(document).ready(function() {
  $('.snippet-code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
});
