class Api::NotesController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @note = current_user.notes.new(resource_params)
  end

  def resource
    @note ||= Note.find(params[:id])
  end

  def collection
    @notes = Note.all
  end

  def resource_params
    params.require(:note).permit(:title, :body)
  end
end
