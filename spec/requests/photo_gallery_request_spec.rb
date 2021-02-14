require 'rails_helper'

RSpec.describe "PhotoGalleries", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/photo_gallery/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/photo_gallery/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/photo_gallery/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/photo_gallery/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/photo_gallery/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
