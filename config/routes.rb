Rails.application.routes.draw do
  resources :categories
  resources :items
  
  #去找welcome類別的index方法
  # get "/", to: "welcome#index"
  # get("/", {to: "welcome#index"})
  
  get "/login", to: "users#login"
  post "/login", to: "users#sign_in"
  delete "/logout", to: "users#logout"
  get "/sign_up", to: "users#sign_up"
  post "/sign_up", to: "users#registration"
  
  root "welcome#index"
end
