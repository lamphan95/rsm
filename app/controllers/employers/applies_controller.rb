class Employers::AppliesController < Employers::EmployersController
  before_action :load_members, :load_templates, only: [:edit, :update]
  before_action :load_template_selected, only: :update

  def edit
    @apply.build_appointment company_id: @company.id
    respond_to do |format|
      format.js
    end
  end

  def show; end

  def update
    respond_to do |format|
      if @apply.update_attributes apply_params
        @apply.save_activity current_user, :update, @apply.status
        Notification.create_notification t("content_notification_update_apply",
          job: @apply.job_name), :user, @apply, current_user.id
        handling_after_update_success
        format.js{@messages = t "employers.applies.update.success"}
      else
        format.js{@errors = t "employers.applies.update.fail"}
      end
    end
  end

  def show
  end

  private

  def handling_after_update_success
    @appointment = @apply.appointment
    case
    when @apply.review_not_selected?
      handling_with_review_not_selected
    when @apply.interview_scheduled?
      handling_with_interview_scheduled
    else
      reset_appointment
    end
  end

  def handling_with_review_not_selected
    return unless @company.company_setting_enable_send_mail[:review_not_selected]
    SendEmailUserJob.perform_later nil, @apply, @template, @company
  end

  def handling_with_interview_scheduled
    if @company.company_setting_enable_send_mail[:interview_scheduled]
      SendEmailUserJob.perform_later @appointment, @apply, @template, @company
    end
    create_inforappointments if params[:states].present?
  end

  def reset_appointment
    Appointment.transaction do
      @appointment.destroy if @appointment.present?
    end
  end

  def apply_params
    params.require(:apply).permit :status,
      appointment_attributes: %i(user_id address company_id start_time end_time)
  end

  def create_inforappointments
    @members = params[:states]
    inforappointments = @members.map do |member_id|
      next if member_id.blank?
      info_appointment = Inforappointment.new(user_id: member_id, appointment_id: @appointment.id)
      info_appointment.create_activation_digest
      info_appointment
    end
    send_mail_interviewer if Inforappointment.import inforappointments
  end

  def send_mail_interviewer
    @appointment.inforappointments.each do |inforappointment|
      SendEmailJob.perform_later inforappointment, @template, @company
    end
  end

  def load_template_selected
    @template = Template.find_by id: params[:template]
    @template_user = Template.find_by id: params[:template_user]
  end
end
