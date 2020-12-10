class Meeting < ApplicationRecord
  belongs_to :meeting_room

  def self.select_meetings(params_id, params_participants, params_sort)
    if params_id
      where(meeting_room_id: params_id)
      .where('number_of_participants > ?', params_participants.to_i)
      .order(params_sort, created_at: :desc)
    else
      where('number_of_participants > ?', params_participants.to_i)
      .order(params_sort, created_at: :desc)
    end
  end 
end
