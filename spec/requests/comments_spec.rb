require 'rails_helper'

RSpec.describe 'Comments API' do
  # Initialize the test data
  let(:user) {create(:user)}
  let!(:micropost) { create(:micropost, user_id: user.id) }
  let!(:comments) { create_list(:comment, 20, micropost_id: micropost.id) }
  let(:micropost_id) { micropost.id }
  let(:id) { comments.first.id }
  let(:headers) {valid_headers}

  # Test suite for GET /posts/:post_id/comments
  describe 'GET /microposts/:posting_id/comments' do
    before { get "/microposts/#{posting_id}/comments", headers: headers }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all post comments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when post does not exist' do
      let(:micropost_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for GET /posts/:post_id/comments/:id
  describe 'GET /microposts/:posting_id/comments/:id' do
    before { get "/microposts/#{posting_id}/comments/#{id}", headers: headers }

    context 'when post comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when post comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find CommentModule/)
      end
    end
  end

  # Test suite for PUT /posts/:post_id/comments
  describe 'POST /microposts/:posting_id/comments' do
    let(:valid_attributes) { { body: 'Donner Wetter' }.to_json }
    # let!(:comment) { create(:comment) }

    context 'when request attributes are valid' do
      before { post "/microposts/#{posting_id}/comments", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/microposts/#{posting_id}/comments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Body can't be blank/)
      end
    end
  end

  # Test suite for PUT /posts/:post_id/comments/:id
  describe 'PUT /microposts/:posting_id/comments/:id' do
    let(:valid_attributes) { { body: 'Mozart' }.to_json }

    before { put "/microposts/#{posting_id}/comments/#{id}", params: valid_attributes, headers: headers }

    context 'when comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = CommentModule.find(id)
        expect(updated_comment.body).to match(/Mozart/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find CommentModule/)
      end
    end
  end

  # Test suite for DELETE /posts/:id
  describe 'DELETE /microposts/:id' do
    before { delete "/microposts/#{posting_id}/comments/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
