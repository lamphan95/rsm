$(document).ready(function(){
  $('.seach-question').click(function() {
    var dataform = {
      name_question: $('#name_question').val()
    };
    $.ajax('/employers/questions', {
      type: 'GET',
      data: dataform,
      success: function(result) {
        $('#table-question').html(result);
      },
      error: function (result) {
        alertify.error(I18n.t('employers.status_steps.transmission_error'));
      }
    });
  });
});
