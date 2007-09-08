class MyBadge < ActiveRecord::Base
  belongs_to :account
  belongs_to :badge
end
