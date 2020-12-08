class RemoveDurationFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :duration, :time
  end
end
