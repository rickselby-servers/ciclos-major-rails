# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { omniauth_callbacks: "omniauth" }
  devise_scope :admin do
    get "sign_in", to: "auth#sign_in", as: :new_admin_session
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_admin_session
  end

  resource :home, only: :show, controller: :home
  resources :page_text, only: :update

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#show"
end
