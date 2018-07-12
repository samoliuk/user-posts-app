require 'rails_helper'

RSpec.describe PostService do
  context 'validations fail' do
    it 'validates presence of title' do
      expect(PostService.new(attributes_for(:post, title: '').merge(user_login: 'user1'))).to_not be_valid
    end

    it 'validates presence of body' do
      expect(PostService.new(attributes_for(:post, body: '').merge(user_login: 'user1'))).to_not be_valid
    end

    it 'validates presence of author ip' do
      expect(PostService.new(attributes_for(:post, author_ip: '').merge(user_login: 'user1'))).to_not be_valid
    end

    it 'validates presence of user login' do
      expect(PostService.new(attributes_for(:post).merge(user_login: ''))).to_not be_valid
    end
  end

  context 'validations succeed' do
    it 'validates presence of all params' do
      expect(PostService.new(attributes_for(:post).merge(user_login: '111'))).to be_valid
    end
  end
end
