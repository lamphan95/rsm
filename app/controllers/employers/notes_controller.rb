class Employers::NotesController < Employers::EmployersController
  before_action :load_apply, only: :new

  def new
    @note = current_user.notes.build apply_id: @apply.id
  end

  def create
    if @note.save
      load_apply
      load_notes
      @success = t ".success"
    end
  end

  private

  def note_params
    params.require(:note).permit :content, :user_id, :apply_id
  end

  def load_apply
    @apply = Apply.find_by id: params[:apply_id]
    return if @apply
    @error = t ".not_found_apply"
  end
end
