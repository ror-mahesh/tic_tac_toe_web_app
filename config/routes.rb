Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'games/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'games#index'
  resources :games
  # post 'games', to: 'game#create'
  # put 'game/:id', to: 'game#update'
  post 'end_turn', to: 'games#end_turn'
  get 'reset', to: 'games#reset'
  # Defines the root path route ("/")
  # root "posts#index"
end
