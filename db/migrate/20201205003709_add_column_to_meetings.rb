class AddColumnToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :start_time, :datetime
  end
end
