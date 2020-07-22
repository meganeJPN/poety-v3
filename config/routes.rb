Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'sessions/new'
  root  'poeets#index'
  # get "*path" => 'application#render_404'
  resources :poeets,only: [:index, :new, :create, :edit, :update,:show, :destroy] do
    collection do
      post :confirm
    end
    member do
      patch :confirm
    end
  end
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [:new, :create, :show, :edit ,:update]
  resources :favorites,only: [:index,:create, :destroy]
end
