class Logo < ActiveRecord::Base
  belongs_to :sponor
  belongs_to :organization
  acts_as_attachment :storage => :file_system, :thumbnails => { :normal => '300>', :thumb => '75' }
  validates_as_attachment
end
