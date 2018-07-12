require 'rails_helper'

RSpec.describe 'Post API' do
  describe 'POST /create' do

    let(:api_path) { '/api/v1/posts' }
    before { |t| @user = create(:user) unless t.metadata[:skip_before_block] }

    context 'successfully creates post' do
      it 'creates a new post for the existing author' do
        expect {
          post api_path, params: {
            format: :json,
            post: attributes_for(:post).merge(user_login: @user.login)
            }
          }.to change(Post, :count).by(1)
           .and not_change(User, :count)
      end

      it 'creates a new post for a new author', :skip_before_block do
        expect {
          post api_path, params: {
            format: :json,
            post: attributes_for(:post).merge(user_login: 'new_user')
            }
          }.to change(Post, :count).by(1)
           .and change(User, :count).by(1)
      end

      it 'returns status 200' do
        post api_path, params: {
          format: :json,
          post: attributes_for(:post).merge(user_login: @user.login)
        }
        expect(response.status).to eq 200
      end
    end

    context 'unable to create post' do
      it 'can not create user with blank login', :skip_before_block do
        expect {
          post api_path, params: {
            format: :json,
            post: attributes_for(:post).merge(user_login: '')
            }
          }.to not_change(Post, :count).and not_change(User, :count)
      end

      it 'can not create post with missed attributes', :skip_before_block do
        expect {
          post api_path, params: {
            format: :json,
            post: attributes_for(:invalid_post)
          }
        }.to not_change(Post, :count)
      end

      it 'returns unprocessable entity for an invalid post' do
        post api_path, params: {
          format: :json,
          post: attributes_for(:invalid_post).merge(user_login: @user.login)
        }
        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET /top_rated_posts' do
    it 'returns an array of top N posts by average rating' do
      posts = create_list(:rated_post, 20)
      get '/api/v1/posts/top_rated_posts', params: {
        format: :json,
        posts_number: 3
      }
      expect(response.body).to be_json_eql([
        { 'title' => posts[4].title, 'body' => posts[4].body },
        { 'title' => posts[14].title, 'body' => posts[14].body },
        { 'title' => posts[9].title, 'body' => posts[9].body }
      ].to_json)
    end
  end

  describe 'GET /shared_ips' do
    it 'gets an array with IPs that were used by multiple authors' do
      l1 = create_list(:post, 3, author_ip: '10.1.1.100')
      l2 = create_list(:post, 2, author_ip: '10.2.2.200')
      l3 = create_list(:post, 5)
      get '/api/v1/posts/shared_ips', params: { format: :json }
      expect(response.body).to be_json_eql([
        {
          'author_ip' => l1.first.author_ip,
          'user_list' => Array.new(l1.length) { |i| l1[i].user.login }.uniq
        },
        {
          'author_ip' => l2.first.author_ip,
          'user_list' => Array.new(l2.length) { |i| l2[i].user.login }.uniq
        }
      ].to_json)
    end
  end
end
