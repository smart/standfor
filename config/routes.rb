ActionController::Routing::Routes.draw do |map|
 
 #Start Account/Session routes
 map.view_badge "/badges/:id.:ext", :controller => "adis", :action => "index"
 map.login   '/login',  :controller => 'sessions', :action => 'new'
 map.logout  '/logout', :controller => 'sessions', :action => 'destroy'
 map.signup  '/signup', :controller => 'sessions',   :action => 'new'
 map.unfinished_registration '/registration', :controller => 'accounts', :action => 'finish_registration'
 map.finish_registration '/finish_registration', :controller => 'accounts', :action => 'save_registration'
 map.account_signup '/account_signup', :controller => 'accounts', :action => 'new'
 map.forgot_password '/forgot/password', :controller => 'accounts', :action => 'forgot_password'
 map.reset_password '/reset/password/:id', :controller => 'accounts', :action => 'reset_password'
 map.change_password '/change/password', :controller => 'accounts', :action => 'change_password'
 map.resources :sessions, :accounts
 # END Account/Session Routes
 
 #main site nav
 map.home '/', :controller => 'site', :action => 'index'
 map.about_us "/about_us", :controller => "site", :action => "about_us"
 map.leaderboard "/leaderboard", :controller => "site", :action => "leaderboard"

 map.resources :badges do |badges|
   badges.badge_customize "customize", :controller => "customize", :action => "index"
 end

 map.resources :badges, :sponsors
  map.resources :organizations do |organizations|
    organizations.resources :segments
  end
 
 
 map.download_signature '/download/signature/:my_badge_id', :controller => 'share', :action => 'download_signature'    
 #map.presave_customize 'customize', :controller => "customize", :action => 'index'
 map.my_badge_create '/create/my/badge',:controller =>'user/my_badges',:action =>'create',:requirements=>{:method=>:any}
  

  
  #order routes
  map.creditcard_info '/creditcard_info', :controller => 'creditcards', :action => 'new'
  map.save_creditcard '/save/creditcard' , :controller => 'creditcards', :action => 'create'
  map.resources :creditcards
  map.authorize_order '/authorize_donation', :controller => 'orders', :action => 'new'
  map.save_order  '/save/orders' , :controller => 'orders', :action => 'create'
  
  
  
  #landing routes
  map.about_user '/about/:id', :controller => 'users', :action => 'show'
  map.my_badge_landing '/landing/:id', :controller => 'landing', :action => 'index'


  map.email_signature_one   '/email/share/one/:id', :controller => 'user/share', :action => 'signature_one'
  map.email_signature_two   '/email/share/two/:id', :controller => 'user/share', :action => 'signature_two'
  map.email_signature_three '/email/share/three/:id', :controller => 'user/share', :action => 'signature_three'
  map.email_signature_four  '/email/share/four/:id', :controller => 'user/share', :action => 'signature_four'

 
  map.resources :my_badges, :controller => "user/my_badges", :path_prefix => "/user", :name_prefix => "user_" do |my_badge|
    my_badge.customize "customize/:action", :controller => "user/customize", :action => "index"
    my_badge.share "share/:action", :controller => "user/share", :action => "index"
   end 
 
 
 map.namespace(:user) do |user|
    user.resources :orders
    user.resources :avatars
    user.resources :organizations
    user.resource :account
 end

  map.resources :organizations do |organizations|
     organizations.resources :segments do |segments|
      segments.resources :orders, :collection => { :create => :any}
      segments.resources :donations, :collection => { :details=>:any, :confirm => :any, :payment => :any }
      segments.resources :badges
     end
  end

  map.admin_home '/admin', :controller => 'admin/organizations', :action => 'index'

  map.namespace(:admin) do |admin|
    admin.resources :organizations do |organizations|
      organizations.resources :segments, :has_many => :badges
      organizations.resources :badges, :has_many => :requirements
      organizations.resources :organizationslogos
    end
    admin.resources :badges, :has_many => :requirements
    admin.resources :segments, :has_many => :badges
    admin.resources :accounts, :has_many => [:my_badges ,:donations, :orders, :access_codes]
  end
  
=begin

# TODO
# Lets try to roll this feature set into a more robust organization templating system.
# Ideally it would use liquid for custom designs, and be easily extensible by us to
# support custom feature requirements on an individual org basis.

# Start World Reach Routes
  map.namespace(:worldreach) do |worldreach|
    worldreach.resources :orders
    worldreach.resources :sessions
    worldreach.resources :accounts
  end
 
  map.connect '/worldreach' , :controller => '/worldreach/site', :action => 'index'
  map.worldreach_segments '/worldreach/segments' , :controller => '/worldreach/segments', :action => 'index'
  map.worldreach_segment '/worldreach/segments/:id' , :controller => '/worldreach/segments', :action => 'show'
  map.worldreach_privacy_policy  '/worldreach/privacy/policy' , :controller => '/worldreach/site', :action => 'privacy_policy'
  map.worldreach_site_map '/worldreach/site/map' , :controller => '/worldreach/site', :action => 'site_map'
  map.worldreach_home '/worldreach' , :controller => '/worldreach/site', :action => 'index'
  map.worldreach_donation_tracker '/worldreach/donations/tracker' , :controller => '/worldreach/site', :action => 'donation_tracker'
  map.worldreach_about_us '/worldreach/about/us' , :controller => '/worldreach/site', :action => 'about_us'
  map.worldreach_contact_us '/worldreach/contact/us' , :controller => '/worldreach/site', :action => 'contact_us'
  map.worldreach_accountability '/worldreach/accountability' , :controller => '/worldreach/site', :action => 'accountability'
  map.worldreach_faq '/worldreach/frequently/asked/questions' , :controller => '/worldreach/site', :action => 'faq'
  map.new_worldreach_order '/worldreach/donate' , :controller => '/worldreach/orders', :action => 'new'
  map.worldreach_confirm_order '/worldreach/confirm/order' , :controller => '/worldreach/orders', :action => 'confirm'
  map.new_worldreach_creditcard '/worldreach/enter/creditcard' , :controller => '/worldreach/orders', :action => 'new_creditcard'
  map.worldreach_save_creditcard '/worldreach/save/creditcard' , :controller => '/worldreach/orders', :action => 'save_creditcard'
  map.worldreach_receipt '/worldreach/receipt/:id' , :controller => '/worldreach/orders', :action => 'receipt'
  map.worldreach_login '/worldreach/login' , :controller => '/worldreach/sessions', :action => 'new'
  map.worldreach_logout '/worldreach/logout' , :controller => '/worldreach/sessions', :action => 'destroy' 
 
# END World Reach Routes 
=end
 
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

end
