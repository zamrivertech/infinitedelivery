Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :parcels, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  resources :contacts, only: [:index, :create]
  resources :entities, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  resources :roles, path: 'entities_roles', as: 'entities_roles', only: [:index, :new, :create, :edit, :update, :destroy, :show]

  get "/settings", to: "settings#index"

end
