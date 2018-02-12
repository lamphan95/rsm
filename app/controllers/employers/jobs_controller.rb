class Employers::JobsController < Employers::EmployersController
  before_action :create_job, only: %i(index new)
  before_action :load_jobs, only: :index
  before_action :load_branches_for_select_box, only: :index
  before_action :load_category_for_select_box, only: :index
  before_action :build_questions, only: :new
  before_action :check_params, only: :create

  def show
    @appointment = @company.appointments.build
    applies = @job.applies
    @apply_statuses = ApplyStatus.includes(:status_step).current
      .get_by(applies.pluck(:id)).page(params[:page]).per Settings.apply.page
  end

  def create
    @job = current_user.jobs.build job_params
    respond_to do |format|
      if @job.save
        @status_step = @company.company_steps.priority_lowest
          .last.step.status_steps
        @job.questions.build
        format.js{ @message = t ".sussess"}
      else
        @job.questions.build unless params[:onoffswitch]
        format.js
      end
    end
    load_jobs
  end

  def index
    @status_step = @company.company_steps.priority_lowest.last.step.status_steps
    @search = @company.jobs.includes(:applies).search params[:q]
    @jobs = @search.result(distinct: true).sort_lastest
      .page(params[:page]).per Settings.job.page
    @page = params[:page]
  end

  def destroy
    respond_to do |format|
      if @job.destroy
        format.js{@message = t ".sussess"}
      else
        format.js
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @job.update_attributes job_params
        format.js{@message = t ".sussess"}
      else
        format.js
      end
    end
    load_jobs
  end

  private

  def create_job
    @job = @company.jobs.new user_id: current_user.id
  end

  def job_params
    params[:job][:survey] = params[:job][:survey].to_i if params[:job]
    params.require(:job).permit(:content, :name, :level, :language, :target,
      :skill, :position, :company_id, :description, :min_salary, :max_salary,
      :branch_id, :category_id, :survey, reward_benefits_attributes: %i(id content job_id _destroy),
      questions_attributes: %i(id name _destroy))
  end

  def load_jobs
    @jobs = @company.jobs.includes(:applies).sort_lastest.page(params[:page]).per Settings.job.page
  end

  def load_applies_joined_by_jobs
    @applies_by_jobs = @company.applies.joined.group_by &:job_id
  end

  def load_branches_for_select_box
    @provinces ||= @company.branches.by_status(Branch.statuses[:active]).order_is_head_office_and_province_desc.pluck :province, :id
  end

  def load_category_for_select_box
    @categories ||= @company.categories.by_status(Category.statuses[:active]).order_name_desc.pluck :name, :id
  end

  def build_questions
    @job.questions.build
  end

  def check_params
    if params[:job] && !params[:onoffswitch]
      params[:job][:survey] = Settings.default_value
      params[:job][:questions_attributes] = nil
    end
  end
end
