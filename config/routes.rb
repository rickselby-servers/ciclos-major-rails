# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { omniauth_callbacks: "omniauth" }
  devise_scope :admin do
    get "sign_in", to: "auth#sign_in", as: :new_admin_session
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_admin_session
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"

  PagesController::PAGES.each do |path|
    get path.dasherize, to: "pages##{path}", as: path.to_sym
  end

  get "admin", to: "admin#index", as: :admin

  resources :bike_rentals, except: :show do
    member { patch :move }
  end
  resources :carousels, only: %i[index show]
  resources :faqs, except: :show do
    member { patch :move }
  end
  resources :galleries
  resources :guides, except: :show do
    member { patch :move }
  end
  resources :page_text, only: :update
  resources :partners do
    member { patch :move }
  end
  resources :photos, except: %i[index show] do
    member { patch :move }
  end
  resources :testimonials, except: :show do
    member { patch :move }
  end

  # redirects
  get "bike-rental", to: redirect("/bike_rentals")
  get "login", to: redirect("/sign_in")
end
