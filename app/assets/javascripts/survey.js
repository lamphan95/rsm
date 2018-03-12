$('.next').click(function(){
  $('.error-message').html('').hide();
  var introducing = CKEDITOR.instances['apply_information_introducing'].getData();
  $('#apply_information_introducing').html(introducing);
  var form = document.getElementById('new_apply');
  var form_data = new FormData(form);
  form_data.append('check_info_valid', true);
  $.ajax({
    url: $('#new_apply').attr('action'),
    type: 'POST',
    data: form_data,
    dataType: 'json',
    processData: false,
    contentType: false,
    success: function(response) {
      if (response.valid_information) {
        $('#form-apply').hide(700);
        $('.survey').show(700);
        $('.btn-step-1').attr('disabled', false);
        $('.btn-step-2').attr('disabled', true);
        $('.btn-step-1').removeClass('active');
        $('.btn-step-2').addClass('active');
        $('.next').attr('disabled', true);
        $('.previous').attr('disabled', false);
      } else {
        $.each(response.errors.information, function(i, value) {
          var split_message = value.split(' ');
          $('form .error-' + split_message[0]).html(value);
          $('.error-message').slideDown();
        })
      }
    }
  })
});
$('.previous').click(function(){
  $('.survey').hide(700);
  $('#form-apply').show(700);
  $('.btn-step-2').attr('disabled', false);
  $('.btn-step-1').attr('disabled', true);
  $('.btn-step-2').removeClass('active');
  $('.btn-step-1').addClass('active');
  $('.next').attr('disabled', false);
  $('.previous').attr('disabled', true);
});
$('#survey-checkbox').click(function(){
  if ($('#survey-checkbox:checkbox:checked').length > 0) {
    $('.no-survey').hide(700);
    $('.has-survey').show(700);
  } else {
    $('.has-survey').hide(700);
    $('.no-survey').show(700);
  }
});

$(document).on('change', '#apply_information_name, #apply_information_email, #apply_information_phone, #new_apply #apply_cv', function() {
  check_value();
});

if (CKEDITOR.instances['apply_information_introducing'] !== undefined) {
  CKEDITOR.instances['apply_information_introducing'].on('change', function() {
    check_value();
  });
}

function check_value() {
  var name = $('#apply_information_name').val();
  var email = $('#apply_information_email').val();
  var phone = $('#apply_information_phone').val();
  var cv;
  dom_cv = document.getElementById('apply_cv');
  if (dom_cv != undefined) {
    cv = $('#apply_cv')[0].files[0];
  }
  var introducing = CKEDITOR.instances['apply_information_introducing'].getData();
  if (name == '' || email == '' || phone == '' || (dom_cv != undefined && cv == undefined)) {
    $('.next').attr('disabled', true);
  } else {
    $('.next').attr('disabled', false);
  }
}

$(document).on('click', '.btn-choose-cv', function() {
  $('#apply_cv').click();
});

$(document).on('click', '.btn-change-cv', function() {
  $('#change-cv').click();
});

$(document).ready(function(){
  var name = $('#apply_information_name').val();
  var email = $('#apply_information_email').val();
  var phone = $('#apply_information_phone').val();
  var cv;
  dom_cv = document.getElementById('apply_cv');
  if (dom_cv != undefined) {
    cv = $('#apply_cv')[0].files[0];
  }
  if (name == '' || email == '' || phone == '' || (dom_cv != undefined && cv == undefined)) {
    $('.next').attr('disabled', true);
  }
});
