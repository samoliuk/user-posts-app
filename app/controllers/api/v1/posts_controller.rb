class Api::V1::PostsController < ApplicationController

  respond_to :json

  def create
    respond_result PostService.new(post_params).call
  end

  def shared_ips
    respond_with Post.shared_ips, each_serializer: IPSerializer
  end

  def top_rated_posts
    respond_with Post.top_posts(params[:posts_number])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :author_ip, :user_login)
  end
end
