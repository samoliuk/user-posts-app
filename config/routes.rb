Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :ratings, only: :create
      resource :posts, only: [:create, :shared_ips, :top_rated_posts] do
        get '/shared_ips' => 'posts#shared_ips'
        get '/top_rated_posts' => 'posts#top_rated_posts'
      end
    end
  end
end
