class Employers::AppliesController < Employers::EmployersController
  before_action :load_notify, :readed_notification, :load_templates, only: :show
  before_action :load_notifications, only: %i(show index)
  before_action :get_step_by_company, :load_current_step, :load_next_step,
    :load_prev_step, :build_apply_statuses, :load_status_step_scheduled,
    :load_statuses_by_current_step, :build_next_and_prev_apply_statuses,
    :load_apply_statuses, :load_history_apply_status, only: :show
  before_action :permission_employer_company, only: :create
  before_action :load_steps, only: :index
  before_action :load_statuses, only: :index

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
    company_manager = Member.search_relation(Member.roles[:employer], current_user.id)
      .pluck :company_id
    @q = Job.job_company(company_manager).search params[:q]
    @jobs = @q.result
  end

  def create
    respond_to do |format|
      unless @error
        @apply.information = params[:apply][:information].permit!.to_h
        if @apply.save
          @message = t ".success"
        else
          @error = t ".failure"
        end
      end
      format.js
    end
  end

  private

  def apply_params
    status_id = StatusStep.status_step_priority_company @company.id
    params.require(:apply).permit(:cv, :job_id)
      .merge! broker: current_user.id, apply_statuses_attributes: [status_step_id: status_id, is_current: :current]
  end

  def permission_employer_company
    company_manager = Member.search_relation(Member.roles[:employer], current_user.id)
      .pluck :company_id
    @apply = Apply.new apply_params
    if @apply.job_id
      return if !@apply.user_id && company_manager.include?(@apply.job.company_id)
      @error = t "company_mailer.fail"
    else
      @error = t ".job_nil"
    end
  end
end
