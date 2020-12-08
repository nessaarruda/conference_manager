class MeetingRoomsController < ApplicationController

  def index
    @meeting_rooms = MeetingRoom.all.order(created_at: :desc)
    #receive error about create_at column not existing or not working when trying to sort by created_at
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
