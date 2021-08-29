Rails.application.routes.draw do
  require 'sidekiq/web'

  root 'shorteners#new'
  
  resources :shorteners, only: [:index, :new, :create]

  mount Sidekiq::Web, at: "/sidekiq"

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end

  get '/:short_url', to: 'shorteners#show'
end
