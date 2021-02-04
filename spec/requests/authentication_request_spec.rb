require 'rails_helper'

RSpec.describe "Authentications", type: :request do

  describe "POST /authenticate" do
    let!(:user) { create(:user) }
    let(:headers) do
      {
          'Content-Type' => 'application/json'
      }
    end
    let(:valid_credentials) do
      {
          email: user.email,
          password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
          email: Faker::Internet.email,
          password: Faker::Internet.password
      }.to_json
    end
    context 'Zum Donner Wetter' do

      before { post "/auth/login", params: valid_credentials, headers: headers }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
