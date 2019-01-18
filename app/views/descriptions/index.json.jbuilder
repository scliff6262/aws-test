json.array!(@descriptions) do |description|
  json.extract! description, :id
  json.url description_url(description, format: :json)
end
