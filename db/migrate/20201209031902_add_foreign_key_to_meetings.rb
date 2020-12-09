class AddForeignKeyToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_reference :meetings, :meeting_room, foreign_key: true
  end
end
