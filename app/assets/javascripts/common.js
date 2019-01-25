$(document).ready(function(){
// Datepicker _start
    $.datepicker.regional['ru'] = {
		showOtherMonths: true,
		selectOtherMonths: true,
        monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
        monthNamesShort: ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
        dayNames: ['воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота'],
        dayNamesShort: ['вск', 'пнд', 'втр', 'срд', 'чтв', 'птн', 'сбт'],
        dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
        weekHeader: 'Нед',
        dateFormat: 'dd.mm.yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false
    };
    $.datepicker.setDefaults($.datepicker.regional['ru']);
	

	$(document).on('click', '.datepicker', function (event) {
		var $txt = $(this),
			val = $txt.val(),			
			placeholder = $(this).attr('placeholder'); //if (val!='') 
			
		$(this).datepicker({
			showOn: 'focus',
			dateFormat: 'dd.mm.yy',
			
			onClose: function(sel,ev) {changeDTP(this,sel)},
			beforeShow: function(){
				var offsetTop = $('#ui-datepicker-div').offset().top;
				//if (!val && val!='') {
				//	$txt.val(placeholder);					
				//}
				//alert(offsetTop);
			}
		}).focus();
	});
});
