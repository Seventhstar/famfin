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

function toInt(d){
  if (isNaN(d)) return 0;
  if (v_nil(d)) return 0;
  return parseInt(d);
}

function to_sum(d){ 
  if (isNaN(d)) return 0;
  s = d.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1 ");
  return s;
}

var v_nil = function(v){ 
  // console.log(typeof(v), v)
  if (typeof(v) == "object") 
    return v === null || v === undefined || v.value === undefined || v.value === 0 || v.value === '0';
  else
    return v === null || v === undefined || v === '' || v === 0 || v === '0';
}

var e_nil = function(id){
  return e_val(id) === "";
}



var message_template = function(msg, type) {
  return '<div class="alert flash_'+type+'">'+msg+'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>';
};


var show_ajax_message = function(msg, type) {
  if (!type) {type = "success"};
  $(".js-notes").html( message_template(msg,type));    
  showNotifications();
};

function showNotifications(){ 
  $nt = $(".alert"); 
  setTimeout("$nt.addClass('in')", 800);
  setTimeout("$nt.removeClass('in').addClass('out')", 7000);
}



$(function() {
  // $(document).on('focus', '.datepicker', function () {$(".datepicker").inputmask('99.99.9999'); });
  $('.datepicker').datepicker({
    format: 'dd.mm.yyyy'
  });
  apply_mask();

  $('.begin_of_month .datepicker').change(function(){
      //console.log('datepicker change');
    let date = $(this).val()

    $(this).val('01' + date.slice(2));
  });


  // $('.items_box_param').on('')
  $('#start_date').change(function(){
    // console.log($(this).val())
    window.location.href = '/statistics?period="'+$(this).val()+'"'
    // $.get() 
  });

});