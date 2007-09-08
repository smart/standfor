class BadgeAccessCode < ActiveRecord::Base
  belongs_to :badge
  has_many :account_badge_authorizations
end
