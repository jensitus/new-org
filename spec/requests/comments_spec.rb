require 'rails_helper'

RSpec.describe 'Comments API' do
  # Initialize the test data
  let!(:posting) { create(:posting) }
  let!(:comments) { create_list(:comment, 20, posting_id: posting.id) }
  let(:posting_id) { posting.id }
  let(:id) { comments.first.id }
  #
  # let(:headers) { valid_headers }

  # Test suite for GET /posts/:post_id/comments
  describe 'GET /postings/:posting_id/comments' do
    before { get "/postings/#{posting_id}/comments" }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all post comments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when post does not exist' do
      let(:posting_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  # Test suite for GET /posts/:post_id/comments/:id
  describe 'GET /postings/:posting_id/comments/:id' do
    before { get "/postings/#{posting_id}/comments/#{id}" }

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
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for PUT /posts/:post_id/comments
  describe 'POST /postings/:posting_id/comments' do
    let(:valid_attributes) { { body: 'Donner Wetter' } }
    # let!(:comment) { create(:comment) }

    context 'when request attributes are valid' do
      before do
        post "/postings/#{posting_id}/comments", params: valid_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/postings/#{posting_id}/comments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Body can't be blank/)
      end
    end
  end

  # Test suite for PUT /posts/:post_id/comments/:id
  describe 'PUT /postings/:posting_id/comments/:id' do
    let(:valid_attributes) { { body: 'Mozart' } }

    before { put "/postings/#{posting_id}/comments/#{id}", params: valid_attributes }

    context 'when comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.body).to match(/Mozart/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for DELETE /posts/:id
  describe 'DELETE /postings/:id' do
    before { delete "/postings/#{posting_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
