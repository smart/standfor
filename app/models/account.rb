class Account< ActiveRecord::Base
  has_many :organizations
  has_many :my_badges
  has_many :donations
  has_and_belongs_to_many :access_codes
  has_and_belongs_to_many :roles
  attr_accessor :create_auth_token
  attr_accessor :create_authenticator
  has_many :authenticators
  after_create :make_account_authenticator
 
   #validates_presence_of :first_name,:last_name,:phone,:email,:city,:state,:zip, :country 
   #validates_length_of :email, :within => 3..100
   #validates_uniqueness_of  :email, :case_sensitive => false 
   #validates_format_of :email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i
  # you can extend this
  REQUIRED_FIELDS = ['nickname', 'fullname', 'primary_email']

  def validate_on_update
    REQUIRED_FIELDS.each do |field|
      errors.add(field, "is required and cannot be blank") if @attributes[field].nil? || @attributes[field].blank?
    end
  end

  def self.find_by_youser(token, auth_type)
    account_authenticated = Authenticator.find_by_auth_token_and_auth_type(token, auth_type, :include =>:account )
    account_authenticated.nil? ? nil : account_authenticated.account
  end
  
  #check if the record is complete you will want to extend this to match the requirements for making an account in your system
  def complete?
    REQUIRED_FIELDS.each do |field|
      return false if @attributes[field].nil? || @attributes[field].blank?
    end
    return true
  end

  def make_account_authenticator
    Authenticator.create(:auth_token => create_auth_token, :auth_type => create_authenticator, :account => self) unless create_authenticator.blank?
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

  def total_donations
     Donation.sum(:amount, :conditions =>{ :account_id => self.id } )
  end
end
