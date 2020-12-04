class RemoveConferenceIdFromPresentations < ActiveRecord::Migration[5.2]
  def change
    remove_column :presentations, :conference_id, :integer
  end
end
