class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.string :name
      t.string :schedule
      t.integer :number_of_participants
      t.time :duration

      t.timestamps
    end
  end
end
