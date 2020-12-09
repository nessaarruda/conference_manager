class RemoveScheduleFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :schedule, :string
  end
end
