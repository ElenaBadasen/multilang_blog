Rails.application.routes.draw do

  get 'login', to: 'admin#login', as: 'login'

  root to: 'users#index', as: 'users'

  resources :users

  resources :images

  scope ':username' do
    resources :categories do
      resources :posts, shallow: true
    end

    root to: 'categories#index', as: 'main_page'
  end



end
