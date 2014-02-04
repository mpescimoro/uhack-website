Uhack::Application.routes.draw do


  # Posts
  get '/posts/tagged/:tag', to: 'posts#index', as: 'posts_with_tag'
  get '/posts/search', to: 'posts#search', as: 'search_posts'
  get '/posts/:id/publish', to: 'posts#publish', as: 'publish_post'
  get '/posts/:id/unpublish', to: 'posts#unpublish', as: 'unpublish_post'
  resources :posts

  resources :tags

  # Static pages
  get "pages/index"
  get "pages/chi_siamo", as: 'chi_siamo'
  get "pages/partecipa", as: 'partecipa'

  # Users
  devise_for :super_users
  devise_for :admins
  as :admin do
    get "/admin" => "devise/sessions#new"
  end
  as :super_user do
    get "/user" => "devise/sessions#new"
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
