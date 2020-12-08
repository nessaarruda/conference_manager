class MeetingRoomsController < ApplicationController

  def index
    @meeting_rooms = MeetingRoom.where('capacity > ?', params[:capacity]|| 0).order(has_projector: :desc, created_at: :desc)
  end

  def show
    @meeting_room = MeetingRoom.find(params[:id])
  end

  def new
  end

  def create
    meeting_room = MeetingRoom.create({
                                    name: params[:meeting_room][:name],
                                    has_projector: params[:meeting_room][:has_projector],
                                    capacity: params[:meeting_room][:capacity]
                                    })

    redirect_to '/meeting_rooms'
  end

  def edit
     @meeting_room = MeetingRoom.find(params[:id])
  end

   def update
     meeting_room = MeetingRoom.find(params[:id])
     meeting_room.update({
       name: params[:meeting_room][:name],
       has_projector: params[:meeting_room][:has_projector],
       capacity: params[:meeting_room][:capacity]
       })
     redirect_to "/meeting_rooms/#{meeting_room.id}"
   end

   def destroy
     MeetingRoom.destroy(params[:id])
     redirect_to '/meeting_rooms'
   end
 end
