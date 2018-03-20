class Employers::AppliesController < Employers::EmployersController
  before_action :load_notify, :readed_notification, :load_templates, only: :show
  before_action :load_notifications, only: %i(show index)
  before_action :load_current_step, :load_offer_status_step_pending,
    :load_apply_statuses, only: %i(show update)
  before_action :get_step_by_company, :load_next_step, :load_prev_step,
    :build_apply_statuses, :load_status_step_scheduled, :load_statuses_by_current_step,
    :build_next_and_prev_apply_statuses, :load_history_apply_status,
    only: %i(show update), unless: -> {@apply.job.exception?}
  before_action :load_steps, only: :index
  before_action :load_statuses, :load_applies, :select_size_steps, only: :index
  before_action :load_jobs_applied, only: :show
  before_action :load_answers_for_survey, only: :show
  before_action :load_apply, only: :create_from_apply_none_job
  before_action :before_hanlding_apply_undefined_job, only: %i(show updacreate_from_apply_none_jobte)

  def index; end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    if params[:role] == Settings.role.undefined_job
      load_apply
      before_hanlding_apply_undefined_job
    else
      @q = @company.jobs.get_not_exception.search params[:q]
      @jobs = @q.result
    end
  end

  def create
    information = params[:apply][:information].permit!.to_h
    job_ids = params[:job_ids]

    if job_ids[1].blank?
      save_apply information
    else
      import_applies job_ids, information
    end
    load_applies
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

  def create_from_apply_none_job
    job_ids = params[:job_ids]
    import_applies job_ids, @apply.information
    if @success
      before_hanlding_apply_undefined_job
      load_jobs_applied
    end
  rescue ActiveRecord::RecordInvalid
    @error = t ".failure"
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
    @apply = @company.jobs.exception.first.applies.build apply_params
    @apply.information = information
    if @apply.save
      @success = t ".success"
    else
      @error = t ".failure"
    end
  end

  def import_applies job_ids, information
    Apply.transaction requires_new: true do
      job_ids.each do |id|
        next if id.blank?
        params[:apply] = {} unless params[:apply]
        params[:apply][:job_id] = id
        apply = Apply.new apply_params
        apply.cv = @apply.cv if @apply.job && @apply.job.exception?
        apply.information = information
        apply.save!
      end
      @success = t ".success"
    end
  end

  def load_jobs_applied
    @applies = Apply.includes(:job).get_by_email @apply.information[:email]
  end

  def before_hanlding_apply_undefined_job
    return unless @apply.job.exception?
    job_ids = Apply.get_by_email(@apply.information[:email]).pluck :job_id
    @q = @company.jobs.get_not_exception.get_by_not_id(job_ids).search params[:q]
    @jobs = @q.result
  end

  def load_apply
    @apply = Apply.find_by(id: params[:id]) || Apply.find_by(id: params[:apply_id])
    return if @apply
    @error = t ".not_found_apply"
  end

  def load_applies
    applies_status = @company.apply_statuses.current
    @applies_total = applies_status.size
    @q = applies_status.search params[:q]
    @applies_status = @q.result.lastest_apply_status.includes(:apply, :job, :status_step)
      .page(params[:page]).per Settings.applies_max
  end

  def select_size_steps
    @size_steps = SelectApply.caclulate_applies_step @company
  end

  def load_answers_for_survey
    @answers = @apply.answers.name_not_blank
      .page(params[:page]).per Settings.survey.max_record
  end
end
