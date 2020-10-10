Rails.application.routes.draw do
  resources :playlists, only: [:create] do
    member do
      get 'next_track/:current_track_id', to: 'playlists#next_track'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
