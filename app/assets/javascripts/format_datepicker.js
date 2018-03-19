$(document).ready(function() {
  $('.datepick').datepicker( {
    dateFormat: I18n.t('datepicker.long'),
    startView: 'months'
  });

  $('.date_apply').datepicker({
    dateFormat: I18n.t('datepicker.format'),
    startView: 'months',
    minDate: 0
  });

  $('.datepick-birthday').datepicker( {
    dateFormat: I18n.t('datepicker.long'),
    startView: 'months',
    endDate: '+0d'
  });
});
