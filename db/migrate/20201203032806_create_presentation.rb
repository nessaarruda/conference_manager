class CreatePresentation < ActiveRecord::Migration[5.2]
  def change
    create_table :presentations do |t|
      t.string :name
      t.string :presenter
      t.integer :conference_id
      t.string :category
      t.boolean :projector_needed
    end
  end
end
