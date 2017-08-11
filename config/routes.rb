Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  scope "(:locale)", locale: /en|ru/ do
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'

    root to: 'users#index', as: 'users'

    resources :users

    resources :images

    scope ':username' do
      root to: 'categories#index', as: 'main_page'

      resources :categories, only: [:edit, :update, :new, :create, :destroy]

      resources :categories, path: '', only: [:index, :show] do
        resources :posts, path: ''
      end


    end
  end

  get '*unmatched_route', to: 'application#not_found'
  # match "/404", :to => "errors#not_found", :via => :all
  # match "/500", :to => "errors#internal_server_error", :via => :all
  # match "/403", :to => "errors#forbidden", :via => :all
  # match "/422", :to => "errors#unprocessable_entity", :via => :all
  # match "/413", :to => "errors#request_entity_too_large", :via => :all
end
