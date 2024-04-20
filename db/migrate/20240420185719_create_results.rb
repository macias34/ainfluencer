class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.text :content
      t.text :image_src
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
