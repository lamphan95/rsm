$(document).ready(function(){
  $('#new_apply').validate({
    errorClass: 'help-block animation-slideDown',
    errorElement: 'div',
    errorPlacement: function(error, e) {
      e.parents('.form-group > div').append(error);
    },
    highlight: function(e) {
      $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
      $(e).closest('.help-block').remove();
    },
    success: function(e) {
      e.closest('.form-group').removeClass('has-success has-error');
      e.closest('.help-block').remove();
    },
    rules: {
      'apply[information][name]': {
        required: true,
        minlength: 6
      },
      'apply[information][email]': {
        required: true,
        email: true
      },
      'apply[information][phone]': {
        required: true,
        number: true,
        minlength: 10
      },
      'apply[cv]': {
        required: true
      }
    }
  });

  check_job_choosen_ids();

  $(document).on('click', '.choose-job', function(){
    $('.no-job').remove();
    var id = $(this).attr('data-id');
    if ($.inArray(id, $('#choosen-ids').val().split(',')) === -1) {
      var html_result = '<span class="tag" id="tag-' + id + '" data-id="' + id +
        '"><span>' + get_name_job(id) + '&nbsp;&nbsp;</span><a href="#" title=' +
        I18n.t("employers.jobs.tag_job.remove_tag") +
        ' class= "remove-tag">&#10007;</a></span>';
      $('.tagsinput').append(html_result);
      $('#choosen-ids').val($('#choosen-ids').val() + ',' + id);
    } else {
      $('#tag-' + id).remove();
      $('#choosen-ids').val($('#choosen-ids').val().replace(',' + id, ''));
      check_job_choosen_ids();
    }
  });

  function check_job_choosen_ids() {
    if ($('#choosen-ids').val() === '') {
      no_job = '<span class="text-muted no-job"><small><em>' +
        I18n.t("no_job_choosen") + '</em></small></span>';
      $('.tagsinput').append(no_job);
    };
  };

  function get_name_job(id) {
    var name_job = $('#name-job-' + id).text().slice(0,15);
    if (name_job !== $('#name-job-' + id).text()) {
      name_job = name_job + '...'
    };
    return name_job
  };

  $(document).on('click', '.remove-tag', function(){
    var id = $(this).parent().attr('data-id');
    $('#choosen-ids').val($('#choosen-ids').val().replace(',' + id, ''));
    $(this).parent().remove();
    $('#job_ids_' + id).prop('checked', false);
    check_job_choosen_ids();
  })
});
