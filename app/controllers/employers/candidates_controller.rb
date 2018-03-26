class Employers::CandidatesController < Employers::EmployersController
  def index
    @q = @company.candidates.search params[:q]
    @candidates = @q.result.get_newest.page(params[:page]).per Settings.applies_max
  end
end
