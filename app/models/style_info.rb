class StyleInfo < ActiveRecord::Base
  belongs_to :scope, :polymorphic => true

  def to_param
   "#{id}"
  end

end
