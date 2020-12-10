class MeetingsController < ApplicationController

  def index
    @meetings = Meeting.select_meetings(params[:id], params[:number_of_participants], params[:sort])
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def new

  end

  def create
    Meeting.create(meetings_params)

    redirect_to "/meeting_rooms/#{params[:id]}/meetings"
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    Meeting.find(params[:id]).update(meetings_params)
    redirect_to params[:previous_request]
  end

  def destroy
    Meeting.destroy(params[:id])
    redirect_to params[:previous_request]
  end

  private

  def meetings_params
    params.permit(:meeting_room_id, :name, :number_of_participants).merge(params[:meeting].permit(:start_time, :end_time))
  end
end
