Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }
  root "static_pages#home"
  get "/home", to: "static_pages#home"
end
