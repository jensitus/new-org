require 'rails_helper'

RSpec.describe MicropostModule, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
end
