Uhack::Application.routes.draw do


  def taggable(resource, opts={})
    get "#{resource}/tag/:tag_id", to: "#{opts[:controller] || resource}#index", as: "#{resource}_with_tag"
  end


  # Posts
  taggable :posts
  #get '/posts/tag/:tag_id', to: 'posts#index', as: 'posts_with_tag'
  get '/posts/search', to: 'posts#search', as: 'search_posts'
  get '/posts/:id/publish', to: 'posts#publish', as: 'publish_post'
  get '/posts/:id/unpublish', to: 'posts#unpublish', as: 'unpublish_post'
  resources :posts do
    resources :comments
  end

  resources :comments, only: [] do
    resources :comments
  end

  resources :tags

  # Static pages
  get "pages/index"
  get "pages/chi_siamo", as: 'chi_siamo'
  get "pages/partecipa", as: 'partecipa'

  # User roles
  devise_for :admins
  as :admin do
    get "/admin" => "devise/sessions#new"
  end

  devise_for :super_users, controllers: { registrations: 'users/registrations' }
  as :super_user do
    taggable :super_users, controller: 'users/registrations'
    get "super" => "devise/sessions#new"
    get 'super_users/edit' => 'users/registrations#edit', :as => 'edit_super_user_registration'
    get 'super_users/:id' => 'users/registrations#show_super', :as => 'super_user_profile'
    put 'super_users' => 'users/registrations#update', :as => 'super_user_registration'
  end
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  as :user do
    taggable :users, controller: 'users/registrations'
    get 'users/:id' => 'users/registrations#show', :as => 'user_profile'
  end

  root "pages#index"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
