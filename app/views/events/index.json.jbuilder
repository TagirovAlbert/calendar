json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :date_rem
  json.url event_url(event, format: :json)
end
