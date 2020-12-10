class RemoveAttendeesFromConferences < ActiveRecord::Migration[5.2]
  def change
    remove_column :conferences, :attendees, :integer
  end
end
