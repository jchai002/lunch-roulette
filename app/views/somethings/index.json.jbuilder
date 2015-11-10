json.array!(@somethings) do |something|
  json.extract! something, :id, :lat, :long, :radius, :rating
  json.url something_url(something, format: :json)
end
