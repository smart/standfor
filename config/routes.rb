ActionController::Routing::Routes.draw do |map|
  map.resources :badge_access_codes

  map.resources :requirements

  # Youser routes
   map.login   '/login',  :controller => 'sessions', :action => 'new'
  map.logout  '/logout', :controller => 'sessions', :action => 'destroy'
  map.signup  '/signup', :controller => 'accounts',   :action => 'new'
  
  map.open_id_complete         'sessions', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_complete_on_accounts 'accounts',    :controller => "accounts",    :action => "create", :requirements => { :method => :get }
  map.unfinished_registration '/registration', :controller => 'accounts', :action => 'finish_registration'
  map.finish_registration '/finish_registration', :controller => 'accounts', :action => 'save_registration'
  map.resources :accounts do |user|
    user.resources :acconts_openids
  end
  map.resource :sessions
  # end youser routes
  # 
  map.resources :my_badges, :badges, :organizations, :accounts, :segments

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
  #
  #
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect '/', :controller => 'site', :action => 'index'
  map.connect '/catalog', :controller => 'badges', :action => 'index'

  #map.connect '/get/badge/:badge_id', :controller => 'my_badges', :action => 'new'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
