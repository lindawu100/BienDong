Rails.application.routes.draw do
  resources :categories
  resources :items do
    resources :comments, only: [:create]
    # /items/:item_id/comments/new 其實頁面本身就是new，也可不用作
    # /items/:item_id/comments/create
  end


  # resources :comments
  # /comments 所有comment
  # /comments/:id 特定comment
  # /comments/:id/edit 編輯特定comment 

  # /comments/new 新增comment
  # /comments/:create 

  #去找welcome類別的index方法
  # get "/", to: "welcome#index"
  # get("/", {to: "welcome#index"})
  
  get "/login", to: "users#login"
  post "/login", to: "users#sign_in"
  delete "/logout", to: "users#logout"
  get "/sign_up", to: "users#sign_up"
  post "/sign_up", to: "users#registration"
  
  root "items#index"
end
