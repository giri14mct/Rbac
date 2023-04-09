require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :request do
  let(:user) do
    User.create(email: 'test@gmail.com', password: 'password', role: :user, session_token: SecureRandom.hex(20))
  end
  let(:admin) do
    User.create(email: 'test@gmail.com', password: 'password', role: :admin, session_token: SecureRandom.hex(20))
  end
  let(:super_admin) do
    User.create(email: 'test@gmail.com', password: 'password', role: :super_admin, session_token: SecureRandom.hex(20))
  end

  describe 'GET /index' do
    context 'when it is an unauthenticated user' do
      it 'returns unauthorized' do
        get '/api/v1/comments'
        expect(response.status).to eq(401)
      end
    end

    context 'when it is an authenticated user' do
      it 'returns response' do
        headers = {
          'Authorization' => user.session_token
        }
        get '/api/v1/comments', headers: headers
        expect(response.status).to eq(200)
      end
    end

    context 'when it is an user only show published comments' do
      it 'returns published response only' do
        headers = {
          'Authorization' => user.session_token
        }
        get '/api/v1/comments', headers: headers
        expect(response.parsed_body['data'].map { |x| x['status'] }.uniq[0] == 'published').to eq(true)
      end
    end
  end
end
