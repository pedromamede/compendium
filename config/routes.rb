Rails.application.routes.draw do
  root 'shorteners#new'
  
  resources :shorteners, only: [:index, :new, :create]

  get '/:short_url', to: 'shorteners#show'
end
