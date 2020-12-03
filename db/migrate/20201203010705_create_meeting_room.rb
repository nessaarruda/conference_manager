class CreateMeetingRoom < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_rooms do |t|
      t.string :name
      t.boolean :has_project
      t.integer :capacity
    end
  end
end
