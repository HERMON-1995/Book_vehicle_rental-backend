Rails.application.routes.draw do
  get 'users/Authentication'
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'
    end
  end
end
