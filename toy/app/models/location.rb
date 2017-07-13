class Location < ApplicationRecord
has_one :gym,
:class_name => 'Gym'

#attr_accessor :address, :latitude, :longitude

geocoded_by :address
after_validation :geocode, :if => :address_changed?
end
