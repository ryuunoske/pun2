class Shipment < ActiveRecord::Base
	belongs_to :customer
end
