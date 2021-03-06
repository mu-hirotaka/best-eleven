Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'welcome#index', as: :root
  get  'mypage' => 'my_page#index', as: :mypage_root
  get  'maintenance' => 'maintenance#index', as: :maintenance_root

  get  'question' => 'question#index', as: :question_root
  post 'question/send_request' => 'question#send_request', as: :question_send_request
  get  'formation' => 'formation#index', as: :formation_root
  get  'selection' => 'selection#index', as: :selection_root
  get  'selection/show' => 'selection#show', as: :selection_show
  get  'selection/select' => 'selection#select', as: :selection_select

  get  'rankings' => 'rankings#index', as: :rankings_root
  get  'rankings/questions' => 'rankings#questions'
  get  'rankings/question' => 'rankings#question'

  post 'image/create' => 'image#create', as: :image_create
  get  'twitter', :to => 'twitter#index', as: :twitter_root
  post 'twitter/tweet', :to => 'twitter#tweet'

  get  'user_post_images'                => 'user_post_images#index', as: :user_post_image_root
  get  'user_post_images/order_by_point' => 'user_post_images#index_order_by_point'
  get  'user_post_images/order_by_comment' => 'user_post_images#index_order_by_comment'
  get  'user_post_images/rankings' => 'user_post_images#index_ranking'
  get  'user_post_images/ranking'  => 'user_post_images#show_ranking'
  get  'user_post_images/:id'            => 'user_post_images#show'
  post 'user_post_images/good'           => 'user_post_images#good'

  post 'user_comments/create'   => 'user_comments#create'
  get 'user_comments'   => 'user_comments#index'

  get  '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
  get  '/logout' => 'sessions#destroy', :as => :logout

  namespace :admin do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    resources :players, except: [ :new, :create, :destroy ]
    resources :formations, except: [ :new, :create, :destroy ]
    resources :questions, except: [ :new, :create, :destroy ]
    get 'user_question_requests' => 'questions#user_requests'
    delete 'user_question_request/:id' => 'questions#user_request_destroy'
    resources :player_types, except: [ :new, :create, :destroy ]
    resources :user_post_images, only: [ :index, :destroy ]
    resources :user_twitter_post_image, only: [ :index, :destroy ]
    resources :player_counter, only: [ :index, :destroy ]
    resource :maintenances, except: [ :index, :destroy ]
    resources :user_comments, only: [ :index, :destroy ]
  end

  get '*anything' => 'errors#routing_error'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
