class Account < ActiveRecord::Base
   has_many :organizations
   has_many :my_badges

   validates_presence_of :first_name,:last_name,:phone,:email,:city,:state,:zip, :country 
   validates_length_of :email, :within => 3..100
   validates_uniqueness_of  :email, :case_sensitive => false 
   validates_format_of :email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i

end
