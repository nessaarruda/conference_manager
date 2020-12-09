class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def show
    @conference = Conference.find(params[:id])
  end

  def create
    conference = Conference.create({
      name: params[:conference][:name],
      organization: params[:conference][:organization],
      size: params[:conference][:size],
      start_date: params[:conference][:start_date],
      end_date: params[:conference][:end_date]
      })
    redirect_to '/conferences'
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    conference = Conference.find(params[:id])
    conference.update({
      name: params[:conference][:name],
      organization: params[:conference][:organization],
      size: params[:conference][:size],
      start_date: params[:conference][:start_date],
      end_date: params[:conference][:end_date]
      })
    redirect_to "/conferences/#{conference.id}"
  end

  def destroy
    Conference.destroy(params[:id])
    redirect_to '/conferences'
  end
end
