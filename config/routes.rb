User::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  
  namespace :auth do
    match "authenticate" => "auth#authenticate"
    match "peerAuthenticate" => "auth#peerAuthenticate"
  end
  
  namespace :auth2 do
    match "auth" => "authorize"
  end

  namespace :user do
    match "signin" => "user#signin"
    match "signup" => "user#signup"
    match "create" => "user#create"
    match "authenticate" => "user#authenticate"
    match "authSession" => "user#authSession"
  end

  namespace :admin do
    match "login" => "admin#login"
    match "logout" => "admin#logout"
    match "create" => "admin#create"
    match "client" => "client#index"
    match "client/new" => "client#new"
    match "client/create" => "client#create"
    match "client/edit" => "client#edit"
    match "client/update" => "client#update"
    match "client/destroy" => "client#destroy"
  end
  

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
