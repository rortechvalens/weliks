LikeWelikes::Application.routes.draw do

# for user_entities
post "user_entities/suggested_entity" => "user_entities#suggested_entity"
post "user_entities/save_media" => "user_entities#save_media"
post "user_entities/get_entity_by_user_id_cat_id" => "user_entities#get_entity_by_user_id_cat_id"
post "user_entities/entity_info" => "user_entities#entity_info"

# For groups

 post "group/group_create" => "group#group_create"
 post "group/get_group_by_owner_id" => "group#get_group_by_owner_id"
 post "group/edit_group" => "group#edit_group"
 post "group/group_details" => "group#group_details"


  get "post_entity/new"
  post "post_entity/entity_search" => "post_entity#entity_search"
  post "post_entity/post_create" => "post_entity#post_create"
  get "master_entity/new" => "master_entity#new"
  post "master_entity/create" => "master_entity#create", :as => :entity_create
  get "master_entity/entity" => "master_entity#entity" , :as => :entity_list
  post "master_entity/master_entity_list" => "master_entity#master_entity_list"
  post "master_entity/create_other_entity" => "master_entity#create_other_entity"

  ## For feedback User
  get "feedback/new"
  post "feedback/feedback_user" => "feedback#feedback_user" , :as => :feedback_user
  get "show" => "feedback#show"

# for Facebook user creation
  get "twitter/new"
  post "twitter/create" => "twitter#create"

# for twitter user Creation
  get "facebook/new" => "facebook#new"
  post "facebook/create" => "facebook#create"
  post "facebook/facebook_friend_counts" => "facebook#facebook_friend_counts"

# user created by email
  post "user/create" => "user#create", :as => :user_create
  post "user/update" => "user#update", :as => :update_user
  post "user/change_password" => "user#change_password"
  post "user/update_notifications" => "user#update_notifications"

   
# user Login via username and password
  get "login/new" => "login#new"
  post "login/create" => "login#create" , :as => :login_create

# for facebook Friends

  get "friends/new" => "friends#new"
  post "friends/create" => "friends#create", :as => :friends_create
  post "friends/email_friends" => "friends#email_friends"
  post "friends/category_friends" => "friends#category_friends"
  post "friends/all_friends" => "friends#all_friends"
  post "friends/following" => "friends#following"
  post "friends/followers" => "friends#followers"
  post "friends/following_data" => "friends#following_data"
  post "friends/followers_data" => "friends#followers_data"
  post "friends/friend_clouds" => "friends#friend_clouds"
  post "friends/traids" => "friends#traids"
  post "friends/all_friend_for_welike" => "friends#all_friend_for_welike"
  post "friends/suggested_friends" => "friends#suggested_friends"
  post "friends/group_friend" => "friends#group_friend"


  post "comment/comment_text" => "comment#comment_text"



  # for User Category
  get "user_category/new" => "user_category#new"
  post "user_category/create" => "user_category#create", :as => :user_category_create
  post "user_category/get_friend" => "user_category#get_friend"
  post "user_category/aggrigrator" => "user_category#aggrigrator"
  post "user_category/add_friend_by_category_id" => "user_category#add_friend_by_category_id"
  post "user_category/all_category" => "user_category#all_category"

  


  #for user entity
  post "user_entity/create" => "user_entity#create"
    get "user_entity/entity_list" =>  "user_entity#entity_list"
     get "user_entity/media" =>  "user_entity#media"
    post "user_entity/save_media" => "user_entity#save_media", :as => :save_media
    get "show/:id" => "user_entity#show"
    post "user_entity/get_entity_by_user_id_cat_id" => "user_entity#get_entity_by_user_id_cat_id"
    post "user_entity/entity_info" => "user_entity#entity_info"
    post "user_entity/welike" => "user_entity#welike"
    post "user_entity/check_entity" => "user_entity#check_entity"
    post "user_entity/get_entity_by_category_id" => "user_entity#get_entity_by_category_id"

  # for comment
  post "comment/post_comment" => "comment#post_comment"
  post "comment/entity_comment" => "comment#entity_comment"


  # for tagging
  post "tag/post_tag" => "tag#post_tag"
 
 # get "user/facebook" => "user#facebook"
  #get "user/twitter" => "user#twitter"
 #get "profile/:id" => "user#profile"
#
# get "login/welcome" => "login#welcome"
  get "category/new" => "category#new"
  post "category/create" => "category#create", :as => :create_category
  get "category/category_list" => "category#category_list", :as => :category_list

  ## group
#    get "user/friend" => "user#friend"
 # get "user/friends_data" => "user#friends_data", :as => :friends_data
  #get "user/friend_list" => "user#friend_list", :as => :friends_create

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
   root :to => 'category#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
