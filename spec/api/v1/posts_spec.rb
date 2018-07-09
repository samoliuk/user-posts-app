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

  # Get top N posts by the average rating
  # Not sure what that exactly means
  describe 'GET /rated_posts' do
    it 'returns an array of N posts with the desired rate' do

    end
  end

  describe 'GET /shared_ips' do
    it 'gets an array with IPs that were used by multiple authors' do
      l1 = create_list(:post, 3, author_ip: '10.1.1.100')
      l2 = create_list(:post, 2, author_ip: '10.2.2.200')
      l3 = create_list(:post, 5)
      get '/api/v1/posts/shared_ips', params: { format: :json }
      expect(response.body).to be_json_eql([
        { 'author_ip' => l1.first.author_ip, 'user_list' => Array.new(l1.length) { |i| l1[i].user.login }.uniq },
        { 'author_ip' => l2.first.author_ip, 'user_list' => Array.new(l2.length) { |i| l2[i].user.login }.uniq }
      ].to_json)
    end
  end

  describe 'POST /update_rating' do

    let(:rating) { create(:rating) }
    let(:mypost) { create(:post) }

    it 'sets the rating of a non-rated post' do
      post "/api/v1/posts/#{mypost.id}/update_rating", params: { format: :json, rating: 5 }
      expect(response.body).to be_json_eql(mypost.rating.value.to_json).at_path('value')
    end

    it 'updates the rating of a post' do
      post "/api/v1/posts/#{rating.post.id}/update_rating", params: { format: :json, rating: 2 }
      rating.reload
      expect(response.body).to be_json_eql(rating.value.to_json).at_path('value')
    end
  end
end
