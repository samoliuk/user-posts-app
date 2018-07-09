Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create, :update_rating] do
        #get '/rated_posts' => 'posts#rated_posts'
        post '/update_rating/' => 'posts#update_rating'

        resources :ratings, shallow: true
      end
      resource :posts, only: :shared_ips do
        get '/shared_ips' => 'posts#shared_ips'
      end
    end
  end
end
