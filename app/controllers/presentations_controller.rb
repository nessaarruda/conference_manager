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
    presentation = Presentation.find(params[:id])
    presentation.update({
      name: params[:presentation][:name],
      presenter: params[:presentation][:presenter],
      category: params[:presentation][:category],
      projector_needed: params[:presentation][:projector_needed],
      })
    if params[:src] == "index"
      redirect_to "/presentations"
    elsif params[:src] != ""
      redirect_to "/conferences/#{params[:src]}/presentations"
    else
      redirect_to "/presentations/#{params[:id]}"
    end
  end

  def destroy
    Presentation.destroy(params[:id])
    if params[:src].to_i > 0
      redirect_to "/conferences/#{params[:src]}/presentations"
    else
      redirect_to '/presentations'
    end
  end

  private
  def presentation_params
    params[:presentation].permit!
  end
end
