json.extract! user, :id, :name, :kind, :email, :password, :work_location_id, :home_location_id, :created_at, :updated_at
json.url user_url(user, format: :json)
