json.array!(@dogs) do |dog|
  json.extract! dog, :id
  json.url dog_url(dog, format: :json)
end
