require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should belong_to :post }
  
  it { should validate_presence_of :value }
end
