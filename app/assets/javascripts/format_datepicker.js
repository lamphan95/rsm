$(document).ready(function() {
  $('.datepick').datepicker( {
    format: I18n.t('datepicker.long'),
    startView: 'months'
  });

  $('.date_apply').datepicker({
    format: I18n.t('datepicker.format'),
    startView: 'months',
    minDate: 0
  });

  $('.datepick-birthday').datepicker( {
    format: I18n.t('datepicker.long'),
    startView: 'months',
    endDate: '+0d'
  });

  $('.datepicker-v1').datepicker({
    dateFormat: I18n.t('datepicker.format_date_v1'),
    startView: 'months',
    minDate: 0
  });
});
