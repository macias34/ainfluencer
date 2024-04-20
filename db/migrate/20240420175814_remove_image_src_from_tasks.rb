class RemoveImageSrcFromTasks < ActiveRecord::Migration[7.1]
  def change
    remove_column :tasks, :image_src, :string
  end
end
