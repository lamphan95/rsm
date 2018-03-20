class Employers::AppliesController < Employers::EmployersController
  before_action :load_notify, :readed_notification, :load_templates, only: :show
  before_action :load_notifications, only: %i(show index)
  before_action :get_step_by_company, :load_current_step, :load_next_step,
    :load_prev_step, :build_apply_statuses, :load_status_step_scheduled,
    :load_statuses_by_current_step, :build_next_and_prev_apply_statuses,
    :load_apply_statuses, :load_history_apply_status, only: %i(show update)
  before_action :load_steps, only: :index
  before_action :load_statuses, only: :index
  before_action :load_offer_status_step_pending, only: %i(show update)
  before_action :load_jobs_applied, only: :show
  before_action :load_answers_for_survey, only: :show

  def index
    applies_status = @company.apply_statuses.current
    @applies_total = applies_status.size
    @size_steps = SelectApply.caclulate_applies_step @company
    @q = applies_status.search params[:q]
    @applies_status = @q.result.lastest_apply_status.includes(:apply)
      .includes(:job).includes(:status_step)
      .page(params[:page]).per Settings.applies_max
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @q = @company.jobs.search params[:q]
    @jobs = @q.result
  end

  def create
    information = params[:apply][:information].permit!.to_h
    job_ids = params[:job_ids]

    if job_ids[1].blank?
      save_apply information
    else
      import_applies job_ids, information
    end
  rescue ActiveRecord::RecordInvalid
    @error = t ".failure"
  end

  def update
    respond_to do |format|
      if @apply.update_columns status: get_status, updated_at: Time.now.getutc
        html_content = render_to_string(partial: "employers/applies/apply_btn",
          locals: {current_step: @current_step, steps: @steps,
          current_apply_status: @current_apply_status, current_status_steps: @current_status_steps})
        format.json{render json: {message: t("employers.applies.block_apply.success"), html_data: html_content}}
      else
        format.json{render json: {message: t("employers.applies.block_apply.fail")}}
      end
      format.html
    end
  end

  private

  def apply_params
    status_id = StatusStep.status_step_priority_company @company.id
    params.require(:apply).permit(:cv, :job_id)
      .merge! apply_statuses_attributes: [status_step_id: status_id, is_current: :current]
  end

  def get_status
    return Apply.statuses["unlock_apply"] if @apply.lock_apply?
    Apply.statuses["lock_apply"]
  end

  def save_apply information
    @apply = Apply.new apply_params
    @apply.information = information
    if @apply.save
      @success = t ".success"
    else
      @error = t ".failure"
    end
  end

  def import_applies job_ids, information
    Apply.transaction requires_new: true do
      applies = []
      job_ids.each do |id|
        next if id.blank?
        params[:apply][:job_id] = id
        apply = Apply.new apply_params
        apply.information = information
        apply.save!
      end
      @success = t ".success"
    end
  end

  def load_jobs_applied
    @applies = Apply.get_by_user(@apply.user_id).includes :job
  end

  def load_answers_for_survey
    @answers = @apply.answers.name_not_blank
      .page(params[:page]).per Settings.survey.max_record
  end
end
