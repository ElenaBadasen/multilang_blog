Rails.application.routes.draw do

  resources :categories do
    resources :posts, shallow: true
  end
end
