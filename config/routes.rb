require 'sidekiq/web'


Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
    mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  end


  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
 
  # post "/blogs", to:"blogs#create"
  # get "/blogs/new", to:"blogs#new"
  # get "/blogs/:id", to:"blogs#show", as: :show
  # delete "/blogs/:id", to: "blogs#destroy"
  # get "/blogs/:id/edit", to: "blogs#edit", as: :blog
  # patch "/blogs/:id/edit", to: "blogs#update"
  get "/blogs/:id/shared", to: "blogs#share_blog", as: :share
  get "/blogs/scheduled", to: "blogs#scheduled", as: :scheduled
  get "/blogs/draft", to: "blogs#draft", as: :draft
  get "/blogs/archived", to: "blogs#archived", as: :archived
  patch "/blogs/:id/archive", to: "blogs#archive", as: :archive_blog
  # get "/blogs/search", to: "blogs#search", as: :search
  

  resources :blogs do
    collection do
      get :search
      patch :bulk_archive_blogs 
      
    end
    resources :comments, only: [:create, :update]
    
  end
  root "blogs#index"

  
  
  #This will match any GET request with an unmatched path
  # get "*path", to: "blogs#index"

  get '*path' => redirect('/')
  
end
