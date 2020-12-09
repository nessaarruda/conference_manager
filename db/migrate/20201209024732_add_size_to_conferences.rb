class AddSizeToConferences < ActiveRecord::Migration[5.2]
  def change
    add_column :conferences, :size, :integer
  end
end
