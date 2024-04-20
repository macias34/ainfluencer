json.extract! result, :id, :content, :image_src, :task_id, :created_at, :updated_at
json.url result_url(result, format: :json)
