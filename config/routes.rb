Rails.application.routes.draw do
  get 'sessions/new'
  root  'poeets#index'
  # get "*path" => 'application#render_404'
  resources :poeets,only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
    member do
      patch :confirm
    end
  end
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [:new, :create, :show, :edit ,:update]
end
