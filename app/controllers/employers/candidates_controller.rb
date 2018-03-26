class Employers::CandidatesController < Employers::EmployersController
  before_action :load_applies, :load_jobs, only: :show

  def index
    @q = @company.candidates.search params[:q]
    @candidates = @q.result.get_newest.page(params[:page]).per Settings.applies_max
  end

  def show; end

  private

  def load_applies
    @applies = @candidate.applies
  end

  def load_jobs
    job_ids = Apply.get_by_email(@candidate.email).pluck :job_id
    @q = @company.jobs.get_by_not_id(job_ids).search params[:q]
    @jobs = @q.result
  end
end
