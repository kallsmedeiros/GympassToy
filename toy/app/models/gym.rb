class Gym < ApplicationRecord

  belongs_to :location,
  :class_name => 'Location',
  :foreign_key => 'location_id'

  belongs_to :manager,
  :class_name => 'User',
  :foreign_key => 'manager_id'

  validates_presence_of :name, :manager_id
end
