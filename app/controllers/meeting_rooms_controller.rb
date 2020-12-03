class MeetingRoomsController < ApplicationController

  def index
  end

  def new

  end

  def create
    meeting_room = MeetingRoom.new({
      name: params[:meeting_room][:name],
      has_projector: params[:meeting_room][:has_projector],
      capacity: params[:meeting_room][:capacity]
      })
      redirect_to '/meeting_rooms'
  end
end
