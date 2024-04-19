class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :personality
      t.text :image_src

      t.timestamps
    end
  end
end
