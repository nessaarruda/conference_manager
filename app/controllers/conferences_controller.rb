class ConferencesController < ApplicationController
  def index
    if params["sort"]
      @conferences = Conference.select("conferences.*, count(*) AS count").joins(:presentations).group(:id).order(count: :desc)
       # "SELECT conferences.*, count(*) AS count FROM conferences INNER JOIN presentations ON conferences.id=presentations.conference_id GROUP BY conferences.id ORDER BY count DESC;"
    else
      @conferences = Conference.where('size >= ?', (params[:attendees] || 0)).order(created_at: :desc)
    end
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
