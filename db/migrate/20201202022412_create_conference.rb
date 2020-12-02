class CreateConference < ActiveRecord::Migration[5.2]
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :organization
      t.integer :size
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
