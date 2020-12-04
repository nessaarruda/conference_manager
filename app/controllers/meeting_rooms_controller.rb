class MeetingRoomsController < ApplicationController

  def index
    @meeting_rooms = MeetingRoom.all
  end

  def show
    @meeting = MeetingRoom.find(params[:id])
  end

  def new
  end
end
