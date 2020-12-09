class ConferencesController < ApplicationController
  def index
    @conferences = Conference.select_conferences(params[:attendees], params[:sort])
  end

  def show
    @conference = Conference.find(params[:id])
  end

  def create
    Conference.create(conference_params)
    redirect_to '/conferences'
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    Conference.find(params[:id]).update(conference_params)
    redirect_to params[:previous_request]
  end

  def destroy
    Conference.destroy(params[:id])
    redirect_to '/conferences'
  end

  private
  def conference_params
    params.permit(:name, :organization, :size, :start_date, :end_date)
  end
end
