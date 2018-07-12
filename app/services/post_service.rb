class PostService
  include ActiveModel::Validations

  validates :title, :body, :author_ip, :user_login, presence: true

  def initialize(params)
    @title = params[:title]
    @body = params[:body]
    @author_ip = params[:author_ip]
    @user_login = params[:user_login]
  end

  attr_reader :title, :body, :author_ip, :user_login

  def call
    return { error: true } unless valid?
    post_owner = User.where(login: @user_login).first_or_create
    post_owner.posts.create(
      title: @title,
      body: @body,
      author_ip: @author_ip
    )
  end
end
