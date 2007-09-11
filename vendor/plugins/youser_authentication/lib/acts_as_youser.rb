module ActiveRecord
  module Acts #:nodoc:
    module Youser
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def acts_as_youser(options = {})
            #write_inheritable_attribute(:acts_as_taggable_options, {
            #:taggable_type => ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s,
            #:from => options[:from]
          #})
          
          #class_inheritable_reader :acts_as_taggable_options
          
          attr_accessor :create_auth_token
          attr_accessor :create_authenticator
          has_many :authenticators, :as => :youser 
          after_create :make_user_authenticator
  
        def find_by_auth_token(token, auth_type)
          user_authenticated = auth_type.constantize.find_by_auth_token(token, :include => :class_name_of_active_record_descendant)
          user_authenticated.nil? ? nil : user_authenticated.send(:class_name_of_active_record_descendant)
        end
    
          include ActiveRecord::Acts::Youser::InstanceMethods
          #extend ActiveRecord::Acts::Youser::SingletonMethods          
        end
      end
      
      module InstanceMethods
        def make_user_authenticator
          create_authenticator.constantize.create(:auth_token => create_auth_token, :youser => self) unless create_authenticator.blank?
        end
      end
    end
  end
end