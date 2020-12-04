class PresentationsController < ApplicationController
  def index
    if params[:id]
      @presentations = get_conference.presentations
    else
      @presentations = Presentation.all
    end
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  private
  def get_conference
    Conference.find(params[:id])
  end
end
