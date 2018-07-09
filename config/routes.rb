Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts do
        #get '/rated_posts' => 'posts#rated_posts'
        post '/update_rating/' => 'posts#update_rating'
        resources :ratings, shallow: true
      end
    end
  end
end
