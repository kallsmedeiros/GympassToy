class User < ApplicationRecord
  has_many :gyms,
  :class_name => 'Gym'

  belongs_to :work_location,
  :class_name => 'Location',
  :foreign_key => 'work_location_id'

  belongs_to :home_location,
  :class_name => 'Location',
  :foreign_key => 'home_location_id'

  validates_uniqueness_of :email#, :work_location

end
