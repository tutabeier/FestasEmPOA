// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require analytics

$(window).bind('page:change', function() {
  initPage();
});

function initPage() {
  var i = 1;
  $('#addField').click(function(){
    var divBegin = '<div class="formFields">';
    var nomeInput = '<input id="nome['+i+']" class="formFields" type="text" placeholder="nome" name="nome['+i+']"></input>';
    var emailInput = '<input id="email['+i+']" type="text" placeholder="email" name="email['+i+']"></input>';
    var divEnd = '</div>';

    $('div#formFields').append(divBegin+nomeInput+'<br/>'+emailInput+divEnd);
    i++;
    if (i >= 6) {
      $('#addField').attr('disabled','disabled');
    }
  });
}
