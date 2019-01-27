// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require vue
//= require common
//= require_tree .

function to_sum(d){ 
  if (isNaN(d)) return 0;
  s = d.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1 ");
  return s;
}

$(function() {
  // $(document).on('focus', '.datepicker', function () {$(".datepicker").inputmask('99.99.9999'); });
$('.datepicker').datepicker({
         format: 'dd.mm.yyyy'
     });
});