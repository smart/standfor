class Order < ActiveRecord::Base
  belongs_to :account
  has_many :donations
end
