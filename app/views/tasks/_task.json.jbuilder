json.extract! task, :id, :name, :image_src, :description, :character_id, :created_at, :updated_at
json.url task_url(task, format: :json)
