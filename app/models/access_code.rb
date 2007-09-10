class AccessCode < ActiveRecord::Base
  belongs_to :scope, :polymorphic  => true
  has_and_belongs_to_many :accounts
end
