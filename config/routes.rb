Rails.application.routes.draw do
  resources :galleries do
    resources :gallery_images, only: :create
  end

  # resources :gallery_images, only: :destroy do
  #   member do
  #     get :lower
  #     get :higher
  #   end
  # end

  get    "gallery_images/:id/left",    to: "gallery_images#left",    as: "gallery_images_left"
  get    "gallery_images/:id/right",   to: "gallery_images#right",   as: "gallery_images_right"
  delete "gallery_images/:id/destroy", to: "gallery_images#destroy", as: "gallery_images_destroy"
  
  get "cart/add/:id", to: "carts#add", as: "cart_add"
  get "cart/destroy", to: "carts#destroy", as: "cart_destroy"

  resources :products
  resources :publications
  get "likes/toggle"
  
  resources :profiles

  devise_for :users#, skip: [:sessions]
  # as :user do
  #   get 'signin', to: 'devise/sessions#new', as: :new_user_session
  #   post 'signin', to: 'devise/sessions#create', as: :user_session
  #   delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end

  namespace :api, format: 'json' do
    namespace :v1 do
      post "galleries/:gallery_id/gallery_images", to: "gallery_images#create", as: "gallery_images_create"

      # resources :galleries do
      #   resources :gallery_images, only: :create
      # end

      # resources :gallery_images, only: :destroy do
      namespace :gallery_images do
        get "gallery_images/:id/lower", to: "gallery_images/lower", as: "lower"
        get "gallery_images/:id/higher", to: "gallery_images/higher", as: "higher"
        delete "gallery_images/:id/destroy", to: "gallery_images/destroy", as: "destroy"
      end
      
      resources :pins, only: [:index, :show, :create]

      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "sign_out", to: "sessions#destroy"
      end
    end
  end

  resources :pins do
    resources :comments

    collection do
      get "by_tag/:tag", to: "pins#by_tag", as: "tagged"
    end
  end

  get "welcome/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "welcome#index"
end
