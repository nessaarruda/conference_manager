class AddTimestampsToPresentation < ActiveRecord::Migration[5.2]
  def change
    add_column :presentations, :created_at, :timestamp
    add_column :presentations, :updated_at, :timestamp
  end
end
