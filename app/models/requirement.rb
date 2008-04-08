class Requirement < ActiveRecord::Base
  attr_accessor :req_type
  belongs_to :badge

  validates_presence_of :name, :description, :value, :badge_id

end
