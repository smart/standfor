class <%= class_name %>< ActiveRecord::Base
  attr_accessor :create_auth_token
  attr_accessor :create_authenticator
  has_many :authenticators
  after_create :make_<%= file_name %>_authenticator
  # you can extend this
  REQUIRED_FIELDS = ['nickname', 'fullname', 'primary_email']

  def validate_on_update
    REQUIRED_FIELDS.each do |field|
      errors.add(field, "is required and cannot be blank") if @attributes[field].nil? || @attributes[field].blank?
    end
  end

  def self.find_by_youser(token, auth_type)
    <%= file_name %>_authenticated = Authenticator.find_by_auth_token_and_auth_type(token, auth_type, :include =>:<%= file_name %> )
    <%= file_name %>_authenticated.nil? ? nil : <%= file_name %>_authenticated.<%= file_name %>
  end
  
  #check if the record is complete you will want to extend this to match the requirements for making an account in your system
  def complete?
    REQUIRED_FIELDS.each do |field|
      return false if @attributes[field].nil? || @attributes[field].blank?
    end
    return true
  end

  def make_<%= file_name %>_authenticator
    Authenticator.create(:auth_token => create_auth_token, :auth_type => create_authenticator, :<%= file_name %> => self) unless create_authenticator.blank?
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
end
