Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }
  # /, /home, /tweets は全てtweets#indexにルーティーングされる
  root "tweets#index"
  get "/home", to: "tweets#index"
  resources :tweets
end
