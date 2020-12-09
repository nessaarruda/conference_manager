class CreateMeetingRoom < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_rooms do |t|
      t.string :name
      t.boolean :has_projector
      t.integer :capacity

      t.timestamps
    end
  end
end
