require 'rails_helper'

RSpec.describe 'Rating API' do
  describe 'POST /create' do

    let(:api_path) { "/api/v1/ratings" }
    before { @my_post = create(:post) }

    context 'changes the rating' do

      let(:valid_post_call) {
        post api_path, params: {
          format: :json,
          rating: attributes_for(:best_rating).merge(post_id: @my_post.id)
        }
      }

      it 'adds a new rate to the post' do
        expect { valid_post_call }.to change(@my_post.ratings, :count).by(1)
      end

      it 'updates the rating of the post' do
        valid_post_call
        @my_post.reload
        expect(@my_post.avg_rating).to eq 5
      end

      it 'returns new average rating of the post' do
        valid_post_call
        @my_post.reload
        expect(response.body).to be_json_eql(@my_post.avg_rating.to_json)
        .at_path('avg_rating')
      end
    end

    context 'fails to change rating' do

      let(:invalid_post_value_call) {
        post api_path, params: {
            format: :json,
            rating: { value: 10 }
          }
        }

      let(:invalid_post_id_call) {
        post api_path, params: {
            format: :json,
            rating: { value: 5, post_id: 100 }
          }
        }

      it 'fails to add a new rate out of the allowed range' do
        expect { invalid_post_value_call }.to not_change(@my_post.ratings, :count)
      end

      it 'fails to set rating out of the allowed range' do
        invalid_post_value_call
        @my_post.reload
        expect(@my_post.avg_rating).to eq 0
      end

      it 'fails to set rating if post does not exist' do
        invalid_post_id_call
      end
    end
  end
end
