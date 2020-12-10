class MeetingRoomsController < ApplicationController

  def index
    @meeting_rooms = MeetingRoom.select_rooms(params[:capacity], params[:sort])
  end

  def show
    @meeting_room = MeetingRoom.find(params[:id])
  end

  def new
  end

  def create
    MeetingRoom.create(meeting_room_params)

    redirect_to '/meeting_rooms'
  end

  def edit
     @meeting_room = MeetingRoom.find(params[:id])
  end

   def update
     MeetingRoom.find(params[:id]).update(meeting_room_params)

     redirect_to params[:previous_request]
   end

   def destroy
     MeetingRoom.destroy(params[:id])
     redirect_to '/meeting_rooms'
   end

   private

   def meeting_room_params
     params.permit(:name, :has_projector, :capacity)
   end
 end
