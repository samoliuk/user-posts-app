require 'rails_helper'

RSpec.describe 'Post API' do
  describe 'POST /create' do

    let(:api_path) { '/api/v1/posts' }
    before { |t| @user = create(:user) unless t.metadata[:skip_before_block] }

    context 'valid post' do
      it 'creates a new post for the existing author' do
        expect { post api_path, params: { format: :json, user: @user.login, post: attributes_for(:post) } }.to change(Post, :count).by(1).and not_change(User, :count)
      end

      it 'creates a new post for a new author', :skip_before_block do
        expect { post api_path, params: { format: :json, user: 'new_user', post: attributes_for(:post) } }.to change(Post, :count).by(1).and change(User, :count).by(1)
      end

      it 'returns status 200' do
        post api_path, params: { format: :json, user: @user.login, post: attributes_for(:post) }
        expect(response.status).to eq 200
      end
    end

    context 'invalid post' do
      it 'returns unprocessable entity for an invalid post' do
        post api_path, params: { format: :json, user: @user.login, post: attributes_for(:invalid_post) }
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET /rated_posts' do
    it 'should return an array of N posts with the desired rate' do

    end
  end

  describe 'PATCH /update' do

    let(:rating) { create(:rating) }
    let(:mypost) { create(:post) }

    it 'sets the rating of a non-rated post' do
      post "/api/v1/posts/#{mypost.id}/update_rating", params: { format: :json, rating: 5 }
      puts "response is #{response.body}"
      mypost.reload
      expect(mypost.rating.value).to eq 5
    end

    it 'updates the rating of a post' do
      post "/api/v1/posts/#{rating.post.id}/update_rating", params: { format: :json, rating: 2 }
      rating.reload
      # rating factory has value 1, adding 2 in the above request
      # so the average becomes 1.5
      expect(rating.value).to eq 1.5
    end
  end
end
