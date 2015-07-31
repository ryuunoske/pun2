json.array!(@shipments) do |shipment|
  json.extract! shipment, :id, :title, :length, :float, :breadth, :height, :description, :customer_id
  json.url shipment_url(shipment, format: :json)
end
