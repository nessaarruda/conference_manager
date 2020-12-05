class AddTimeStampToConferences < ActiveRecord::Migration[5.2]
  def change
    add_column :conferences, :created_at, :timestamp
  end
end
