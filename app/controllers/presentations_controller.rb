class PresentationsController < ApplicationController
  def index
    if params["sort"] && params[:id]
      @presentations = Presentation.where(conference_id: params[:id]).order(:name, projector_needed: :desc, created_at: :desc)
    elsif params[:id]
      @presentations = Presentation.where(conference_id: params[:id]).order(projector_needed: :desc, created_at: :desc)
    elsif params["sort"]
      @presentations = Presentation.order(:name, created_at: :desc)
    else
      @presentations = Presentation.order(created_at: :desc)
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
      name: params[:presentation][:name].titleize,
      presenter: params[:presentation][:presenter].titleize,
      category: params[:presentation][:category],
      projector_needed: params[:presentation][:projector_needed],
      })
    redirect_to "/conferences/#{params[:conference_id]}/presentations"
  end

  def edit
    @presentation = Presentation.find(params[:id])
  end

  def update
    presentation = Presentation.find(params[:id])
    presentation.update({
      name: params[:presentation][:name],
      presenter: params[:presentation][:presenter],
      category: params[:presentation][:category],
      projector_needed: params[:presentation][:projector_needed],
      })
    redirect_to "/presentations/#{params[:id]}"
  end

  def destroy
    Presentation.destroy(params[:id])
    redirect_to '/presentations'
  end
end
