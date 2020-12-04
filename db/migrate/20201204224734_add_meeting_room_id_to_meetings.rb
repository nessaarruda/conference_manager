class AddMeetingRoomIdToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :meeting_room_id, :integer
  end
end
