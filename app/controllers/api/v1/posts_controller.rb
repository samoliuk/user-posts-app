class Api::V1::PostsController < ApplicationController

  respond_to :json

  def create
    post_owner = User.where(login: params[:user]).first_or_create
    # really status ok?
    respond_with post_owner.posts.create(post_params), status: :ok, location: nil
  end

  def update_rating
    @post = Post.find(params[:post_id])
    if @post.rating
      @post.rating.update_attribute(:value, average_rating(rating_values: [@post.rating.value, params[:rating].to_i]))
    else
      Rating.create(value: params[:rating], post: @post)
    end

    respond_with @post.rating, location: nil
  end

  def shared_ips
    respond_with Post.select("author_ip, array_agg(distinct login order by login) as user_list").joins(:user).group("author_ip").having("count(author_ip) > 1"), each_serializer: IPSerializer
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :author_ip)
  end

  def average_rating(rating_values:)
    rating_values.inject(:+).to_f / rating_values.size
  end
end
