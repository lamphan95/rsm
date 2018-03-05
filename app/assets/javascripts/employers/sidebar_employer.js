$(document).ready(function(){
  $(document).on('click', '.connect-google', function(event){
  event.preventDefault();
  var data = {
    apply_id: $('#apply_id').val(),
    job_id: $('#job_id').val()
  };
  swal({
    title: I18n.t('jobs.apply.confirm_change_status'),
    text: I18n.t('oauth.google.connect'),
    icon: 'warning',
    buttons: true,
    primaryMode: true,
  })
  .then(function(isConfirm){
    if (isConfirm) {
      $('.loading').fadeIn('slow');
      window.location.href = '/devises/auth/google_oauth2?apply_id=' + data.apply_id + '&job_id=' + data.job_id;
    }
    });
  });
});
