ActionController::Routing::Routes.draw do |map|
  map.view_badge "/standfor/:id.:ext", :controller => "adis", :action => "index"
  map.login   '/login',  :controller => 'sessions', :action => 'new'
  map.logout  '/logout', :controller => 'sessions', :action => 'destroy'
  map.signup  '/signup', :controller => 'accounts',   :action => 'new'
  map.open_id_complete 'sessions', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_complete_on_accounts 'accounts',    :controller => "accounts",    :action => "create", :requirements => { :method => :get }
  map.unfinished_registration '/registration', :controller => 'accounts', :action => 'finish_registration'
  map.finish_registration '/finish_registration', :controller => 'accounts', :action => 'save_registration'

  map.resources :accounts, :my_badges, :campaigns, :sponsors, :badges, :oranizations, :segments, :requirements, :style_infos
  map.resource :sessions

  map.resources :accounts do |user|
    user.resources :acconts_openids
  end

  map.resources :organizations do |organizations|
     organizations.resources :segments , :name_prefix => 'organization_'  do |segments|
         segments.resources :donations, :collection => { :details=>:any, :confirm => :any, :payment => :any }
         segments.resources :campaigns
         segments.resources :badges
     end
  end

  map.resources :badges do |badges|
     badges.resources :requirements , :name_prefix => 'badge_' 
     badges.resources :my_badges, :name_prefix => 'badge_' 
  end 

 map.namespace(:admin) do |admin|
    admin.resources :organizations do |organizations|
       organizations.resources :segments 
    end
 end

 map.namespace(:orgadmin) do |admin|
    admin.resources :organizations do |organizations|
       organizations.resources :segments 
       organizations.resources :campaigns
       organizations.resources :style_infos
    end
 end

  # end youser routes
=begin
  map.with_options :conditions => {:subdomain => /standfor/ },:embedded => true do |embedded| 
   embedded.connect '/', :controller => 'organizations', :action => 'show'
   embedded.connect '/my/account', :controller => 'my_account', :action => 'index'
   embedded.connect '/:organization/:segment', :controller => 'segments', :action => 'show'
   embedded.connect '/:segment', :controller => 'segments', :action => 'show'
   embedded.connect '/:organization', :controller => 'organizations', :action => 'show'
   embedded.connect "/:segment/:controller/:action"
  end
=end
  #map.connect '/', :controller => 'site' , :action => 'setorg', :conditions => {:host => /standfor.(\w+).org/ } 
  #map.connect '/', :controller => 'site' , :action => 'setorg', :conditions => {:subdomain => /(\w+).standfor.org/ } 
  map.connect "/rcss/:rcss.css", :controller => "rcss", :action => "rcss"
  map.connect "/rcss/:rcss/:style_info.css", :controller => "rcss", :action => "rcss"
  map.connect "/style/:action/:style_info.:ext", :controller => "style"
  map.connect "/text/:action/:text.:ext", :controller => "text"
  map.connect "/text/:text.:ext", :controller => "text", :action => "index"
  #map.connect "/:organization/:segment/:controller/:action"
  #map.connect "/:organization/:segment/donate/:action", :controller => "donations"
  #map.connect "/:organization/:segment/badges/:action", :controller => "badges"
  #map.connect "/:organization/:segment/authorizations/:action",:controller => "authorizations">
  # Youser routes
  # The priority is based upon order of creation: first created -> highest priority.
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect '/', :controller => 'site', :action => 'index'
  map.connect '/catalog', :controller => 'badges', :action => 'index'
  map.connect '/my/account', :controller => 'my_account', :action => 'index'
  map.connect '/:organization', :controller => 'organizations', :action => 'show'
  #map.connect '/get/badge/:badge_id', :controller => 'my_badges', :action => 'new'
  # Install the default route as the lowest priority.
  map.connect '/support/:organization/:segment', :controller => 'segments', :action => 'show'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

end
