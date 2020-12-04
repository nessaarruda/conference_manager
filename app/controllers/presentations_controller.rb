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

  def new

  end

  def create
    conference = Conference.find(params[:conference_id])
    conference.presentations.create({
      name: params[:presentation][:name],
      presenter: params[:presentation][:presenter],
      category: params[:presentation][:category],
      projector_needed: params[:presentation][:projector_needed],
      })
    redirect_to "/conferences/#{params[:conference_id]}/presentations"
  end

  private
  def get_conference
    Conference.find(params[:id])
  end
end
