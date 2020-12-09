class AddConferencestoPresentations < ActiveRecord::Migration[5.2]
  def change
    add_reference :presentations, :conference, foreign_key: true
  end
end
