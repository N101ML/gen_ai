Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "providers#index"

  # Providers
  resources :providers, only: [:index, :show, :new, :create] do
    resources :provider_links, only: [:index, :show]
  end

  # BaseModels
  resources :base_models, only: [:index, :show, :new, :create, :edit] do
    resources :fine_tunes, only: [:index, :show, :new, :create]
    resources :provider_links, only: [:index, :show]
  end

  # FineTunes
  resources :fine_tunes, only: [:index, :show, :edit, :update, :destroy, :new, :create] do
    resources :provider_links, only: [:index, :show]
  end

  # Renders
  resources :renders, only: [:index, :show, :new, :create, :destroy]
end
