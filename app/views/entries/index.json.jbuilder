json.array!(@entries) do |entry|
  json.extract! entry, :id, :title, :body, :created_at
  json.url entry_url(entry, format: :json)
end
