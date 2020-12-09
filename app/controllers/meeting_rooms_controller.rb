class MeetingRoomsController < ApplicationController

  def index
    if params[:sort]
      @meeting_rooms = MeetingRoom.select("meeting_rooms.*, COUNT(*) AS count")
                                  .left_outer_joins(:meetings)
                                  .group(:id)
                                  .where('capacity > ?', params[:capacity]|| 0)
                                  .order(count: :desc, has_projector: :desc, created_at: :desc)
    else
      @meeting_rooms = MeetingRoom.where('capacity > ?', params[:capacity]|| 0).order(has_projector: :desc, created_at: :desc)
    end
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
     redirect_to params[:previous_request]
   end

   def destroy
     MeetingRoom.destroy(params[:id])
     redirect_to '/meeting_rooms'
   end
 end
