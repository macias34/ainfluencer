class AddCompletedToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :generate_image, :boolean
  end
end
