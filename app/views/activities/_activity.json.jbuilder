json.extract! activity, :id, :name, :activity_type, :progress, :activity_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
