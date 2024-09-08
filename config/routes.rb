Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }
  get "/manifest.json", to: "pwa#manifest", defaults: { format: :json }
  # /, /home, /tweets は全てtweets#indexにルーティーングされる
  resources :tweets do
    resource :like, only: %i[ create destroy ]
    member do
      get :new_reply, to: "tweets#new_reply", as: "new_reply"
    end
  end
  root "tweets#index"
  get "/home", to: "tweets#index"

  resources :users, only: %i[ index show edit update ]

  resources :follows, only: %i[ create destroy ]
  get "/followings/:id", to: "follows#followings", as: "followings"
  get "/followers/:id", to: "follows#followers", as: "followers"
end
