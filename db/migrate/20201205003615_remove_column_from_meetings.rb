class RemoveColumnFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :schedule, :datetime
  end
end
