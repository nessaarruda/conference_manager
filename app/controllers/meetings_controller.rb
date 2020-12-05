class MeetingsController < ApplicationController

  def index
    @meetings = Meeting.all
  end

  def show
    # @meeting = Meeting.find(params[:id])
  end

  def new

  end

  def create
    meeting_room = MeetingRoom.find(params[:meeting_room_id])
    meeting_room.meetings.create({
      name: params[:meeting][:name],
      number_of_participants: params[:meeting][:number_of_participants],
      start_time: params[:meeting][:start_time],
      end_time: params[:meeting][:end_time],

      })
    redirect_to "/meeting_rooms/#{params[:meeting_room_id]}/meetings"
  end
end
