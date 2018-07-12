class Api::V1::RatingsController < ApplicationController

  respond_to :json

  def create
    respond_result RatingService.new(rating_params).call, PostAvgRatingSerializer
  end

  private

  def rating_params
    params.require(:rating).permit(:value, :post_id)
  end
end
