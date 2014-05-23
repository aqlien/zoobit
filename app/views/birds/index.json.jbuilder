json.array!(@birds) do |bird|
  json.extract! bird, :id
  json.url bird_url(bird, format: :json)
end
