Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'welcome#index', as: :root

  get  'bokete' => 'bokete#index', as: :bokete_root
  get  'bokete/select' => 'bokete#select', as: :bokete_select
  get  'bokete/list' => 'bokete#list', as: :bokete_list
  post 'bokete/show' => 'bokete#show', as: :bokete_show

  get  'question' => 'question#index', as: :question_root
  get  'formation' => 'formation#index', as: :formation_root
  get  'selection' => 'selection#index', as: :selection_root
  post 'selection/show' => 'selection#show', as: :selection_show
  get  'selection/select' => 'selection#select', as: :selection_select

#  get  'selection/text' => 'selection#text', as: :selection_text
#  post 'selection/show_text' => 'selection#show_text', as: :selection_show_text

  post 'image/create' => 'image#create', as: :image_create

  get 'home/index'
  get '/tweet', :to => 'home#tweet', :as => 'tweet'
  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout

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
