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
