require 'rails_helper'

RSpec.describe "ResetPasswords", type: :request do

  let(:token)

  describe "GET /create" do
    context 'when password is forgotten'
    before { post "/api/reset_password/create" }
    it "returns http success" do
      post "/api/reset_password/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /check_token" do
    it "returns http success" do
      get "/reset_password/check_token"
      expect(response).to have_http_status(:success)
    end
  end

end
