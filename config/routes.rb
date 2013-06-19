Weliike::Application.routes.draw do
  
  get "product/new"

match "/auth/:provider/callback" => "session#create"
match "/auth/:provider/callback" => "session#twitter"
	match "/signout" => "session#signout", :as => :signout
  #match "/users/:user/products/send" => "products#send", :via => :post
	get 'user/new' => 'user#new' ,:as => :sign_up
  post 'user/de_activate_user_account' => 'user#de_activate_user_account' ,:as => :deactivate_user

  post 'user/create' => 'user#create' , :as => :sign_up_create
  match 'login/profile/:id' => 'login#profile', :as => :profile
  get 'login/edit_profile/:id' => 'login#edit_profile', :as => :edit_profile
  post '/update_user' => 'login#update_user' , :as => :update_user
  post 'change_password' => 'user#change_password' , :as => :change_password
  post 'deactivate_user' => 'user#deactivate_user' , :as => :deactivate
  get "login/new"
  post 'login/create' => 'login#create', :as => :login_create
  post "product/create" => "product#create"
  get "user_wish/:id" =>  "login#user_wish"
  get "edit/:id" => "product#edit"
  get "destroy/:id" => "product#destroy"
  post "sendlist/:id" => "product#sendlist" , :as => :sendlist
  post "/update" => "product#update"
  get "product_profile/:id" => "product#product_profile"
  get "delete_image/:id" => "product#delete_image"
  get "product_friend_profile/:id" => "product#product_friend_profile"
get '/products/ordering_list/' => 'products#ordering_list'

  get "sign_up/new"
  get "login/terms" => "login#terms", :as => :terms
  post "login/terms_and_condition" => "login#terms_and_condition" ,:as => :tersm_and_conditions

  get "home/index"
  get "user/login" => "user#login" , :as => :login
 # post "login/create" => "login#create" , :as => :login_create
  match "/auth/:provider/callback" => "login#facebook"
  match "/auth/:provider/callback" => "login#twitter"
  get "welcome/:id" => "login#welcome" , :as => :welcome


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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
