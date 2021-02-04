require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) {create(:user)}
  # let!(:users) {create_list(:user, 9)}
  let(:headers) { valid_headers }
  let(:user_id) { user.id }
  let(:valid_attributes) do
    {
        name: 'Jens',
        email: 'jens@ist-ur.org',
        password: 'Beispiel',
        password_confirmation: 'Beispiel'
    }
  end

  # describe "GET /index" do
  #   context 'when valid request' do
  #     before { get '/users/index', params: {}, headers: headers }
  #     it 'returns list of users' do
  #       expect(json).not_to be_empty
  #       expect(json.size).to eq(10)
  #     end
  #   end
  # end

  describe "GET /show" do
    context 'when valid request' do
      before { get "/users/#{user_id}", params: {}, headers: headers }
      it 'returns single user' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /create" do
    context "create the fucking user" do
      before {post "/users/create", params: valid_attributes}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/users/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/users/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
