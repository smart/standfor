class Requirement < ActiveRecord::Base
  attr_accessor :req_type
  belongs_to :badge

end
