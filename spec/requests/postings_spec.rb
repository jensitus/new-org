# spec/requests/posts_spec.rb
require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:postings) { create_list(:posting, 10, user_id: user.id) }
  let(:posting_id) { postings.first.id }
  let(:headers) {valid_headers}


  # Test suite for GET /posts
  describe 'GET /posts' do
    # make HTTP get request before each example
    before { get '/postings', headers: headers }

    it 'returns posts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /posts/:id
  describe 'GET /postings/:id' do
    before { get "/postings/#{posting_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the posting' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(posting_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:posting_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for POST /posts
  describe 'POST /posts' do
    # valid payload
    let(:valid_attributes) do
      { title: 'Learn Elm',
        content: 'Jesus Christ',
        user_id: user.id }.to_json
    end

    context 'when the request is valid' do
      before { post '/postings', params: valid_attributes, headers: headers }

      it 'creates a post' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/postings', params: { title: 'Foobar' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  # Test suite for PUT /posts/:id
  describe 'PUT /postings/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/postings/#{posting_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /postings/:id' do
    before { delete "/postings/#{posting_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end