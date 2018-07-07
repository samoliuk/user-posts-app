require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :user}
  it { should have_one :rating }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :author_ip }
  it { should validate_presence_of :user_id }
end
