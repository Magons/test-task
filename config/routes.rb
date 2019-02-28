Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  devise_for :users, controllers: {
    registrations: "user_registrations",
    confirmations: "user_confirmations",
    sessions: "user_sessions",
    passwords: "user_passwords"
  }

  devise_scope :user do
    get "/users/reset_password_link_sent" => "user_passwords#reset_password_link_sent", as: :reset_password_link_sent
  end

  root 'static_pages#home'

  # Static pages
  get 'welcome' => 'static_pages#sign_up_success', as: :sign_up_success
  get 'sign_up_unconfirmed' => 'static_pages#sign_up_unconfirmed', as: :sign_up_unconfirmed
  get 'myprofile' => 'static_pages#my_profile', as: :my_profile
  get 'en/product-overview' => 'static_pages#product_overview', as: :product_overview
  get 'en/privacy-policy' => 'static_pages#privacy_policy', as: :privacy_policy
  get 'en/terms-of-service' => 'static_pages#terms_of_service', as: :terms_of_service

  namespace :api do
    namespace :v1 do
      resources :answers, only: [:create]
    end
  end

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
