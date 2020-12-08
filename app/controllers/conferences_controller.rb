class ConferencesController < ApplicationController
  def index
    @conferences = Conference.select_conferences(params[:attendees], params[:sort])
  end

  def show
    @conference = Conference.find(params[:id])
  end

  def create
    conference = Conference.create(conference_params)
    redirect_to '/conferences'
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    conference = Conference.find(params[:id])
    conference.update(conference_params)
    if params[:src] == 'index'
      redirect_to "/conferences"
    else
      redirect_to "/conferences/#{conference.id}"
    end
  end

  def destroy
    Conference.destroy(params[:id])
    redirect_to '/conferences'
  end

  private
  def conference_params
    params[:conference].permit(:name, :organization, :size, :start_date, :end_date)
  end
end
