Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "blogs#index"
  # post "/blogs", to:"blogs#create"
  # get "/blogs/new", to:"blogs#new"
  # get "/blogs/:id", to:"blogs#show", as: :show
  # delete "/blogs/:id", to: "blogs#destroy"
  # get "/blogs/:id/edit", to: "blogs#edit", as: :blog
  # patch "/blogs/:id/edit", to: "blogs#update"
  get "/blogs/scheduled", to: "blogs#scheduled", as: :scheduled
  get "/blogs/draft", to: "blogs#draft", as: :draft
  get "/blogs/archived", to: "blogs#archived", as: :archived
  patch "/blogs/:id/archive", to: "blogs#archive", as: :archive_blog
  resources :blogs
  

  
  
  #This will match any GET request with an unmatched path
  # get "*path", to: "blogs#index"
  
end
