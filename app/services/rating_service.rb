class RatingService
  include ActiveModel::Validations

  validates :value, presence: true, numericality: {
                                                    only_integer: true,
                                                    greater_than_or_equal_to: 1,
                                                    less_than_or_equal_to: 5
                                                  }
  validates :post_id, presence: true

  attr_reader :value, :post_id

  def initialize(params)
    @post_id = params[:post_id]
    @value = params[:value]
  end

  def call
    return { error: true } unless valid?
    post = Post.find_by_id(@post_id)
    return { error: true } unless post
    post.ratings.create(value: @value)
    post.with_lock { post.update_average_rating }
    post
  end
end
