require 'rails_helper'

RSpec.describe RatingService do
  context 'validations fail' do
    it 'validates presence of value' do
      expect(RatingService.new(attributes_for(:rating, value: nil).merge(post_id: 1))).to_not be_valid
    end

    it 'validates presence of post id' do
      expect(RatingService.new(attributes_for(:rating))).to_not be_valid
    end

    it 'validates value to be not greater than the higher' do
      expect(RatingService.new(attributes_for(:rating, value: 10).merge(post_id: 1))).to_not be_valid
    end

    it 'validates value to be not lower than the lowest' do
      expect(RatingService.new(attributes_for(:rating, value: 0).merge(post_id: 1))).to_not be_valid
    end

    it 'validates value to be integer' do
      expect(RatingService.new(attributes_for(:rating, value: 5.0).merge(post_id: 1))).to_not be_valid
    end
  end

  context 'validations succeed' do
    it 'validates presence of all params' do
      expect(RatingService.new(attributes_for(:rating).merge(post_id: 1))).to be_valid
    end
  end
end
