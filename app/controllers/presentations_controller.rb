class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.select_presentations(params[:id], params[:sort])
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
  end

  def create
    Presentation.create(presentation_params)
    redirect_to "/conferences/#{params[:presentation][:conference_id]}/presentations"
  end

  def edit
    @presentation = Presentation.find(params[:id])
  end

  def update
    Presentation.find(params[:id]).update(presentation_params)
    redirect_to params[:previous_request]
  end

  def destroy
    Presentation.destroy(params[:id])
    redirect_to params[:previous_request]
  end

  private
  def presentation_params
    params[:presentation].permit!
  end
end
