Rails.application.routes.draw do

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

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
