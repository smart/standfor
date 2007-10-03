class Configuration < ActiveRecord::Base

  def to_param
    "#{id}"
  end

  def organization
     Organization.find(self.organization_id)
  end

end
