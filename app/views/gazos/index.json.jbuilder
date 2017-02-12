json.array!(@gazos) do |gazo|
  json.extract! gazo, :id, :file, :comment, :ctype, :image
  json.url gazo_url(gazo, format: :json)
end
