Rails.application.routes.draw do
  get 'swagger_ui/index'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'users/Authentication'
  get '/swagger-ui', to: 'swagger_ui#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index create destroy]
      resources :cars, only: %i[index create show update destroy]
      resources :reservations 
      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'
      post '/authentication', to: 'authentication#create'

    end
  end
end
