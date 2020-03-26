Rails.application.routes.draw do
  #去找welcome類別的index方法
  # get "/", to: "welcome#index"
  # get("/", {to: "welcome#index"})
  root "welcome#index"
  get "/login", to: "welcome#login"
end
