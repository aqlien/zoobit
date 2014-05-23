json.array!(@rabbits) do |rabbit|
  json.extract! rabbit, :id
  json.url rabbit_url(rabbit, format: :json)
end
