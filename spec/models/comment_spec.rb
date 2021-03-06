require 'rails_helper'

RSpec.describe CommentModule, type: :model do
  it { should belong_to(:micropost) }
  it { should validate_presence_of(:body) }
end
