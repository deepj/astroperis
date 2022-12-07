# frozen_string_literal: true

Rails.application.routes.draw do
  mount Shrine.presign_endpoint(:cache) => "/s3/params"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  devise_scope :user do
    get "/sign_in", to: "users/sessions#new", as: :new_user_session
    delete "/sign_out", to: "users/sessions#destroy", as: :destroy_user_session
  end

  resources :astronauts do
    get :search, on: :collection
  end
  resources :imports, only: %i[index show create]

  root to: "astronauts#index"
end
