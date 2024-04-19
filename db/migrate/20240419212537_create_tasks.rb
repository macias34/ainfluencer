class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :image_src
      t.text :description
      t.integer :character_id

      t.timestamps
    end
  end
end
