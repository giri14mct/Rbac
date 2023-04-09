require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :request do
  let(:user) do
    User.create(email: 'test@gmail.com', password: 'password', role: :user, session_token: SecureRandom.hex(20))
  end
  let(:admin) do
    User.create(email: 'test1@gmail.com', password: 'password', role: :admin, session_token: SecureRandom.hex(20))
  end
  let(:super_admin) do
    User.create(email: 'test2@gmail.com', password: 'password', role: :super_admin, session_token: SecureRandom.hex(20))
  end

  let(:drafted_comment) { Comment.create(content: 'Hello World...!!!', user_id: user.id) }
  let(:published_comment) { Comment.create(content: 'Hello World...!!!', user_id: user.id, status: :published) }

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

  describe 'POST /create' do
    context 'When create the comment with content' do
      it 'returns creted successfully' do
        params = { comment: { content: 'Hello World', user_id: user.id } }

        headers = {
          'Authorization' => user.session_token
        }
        post '/api/v1/comments', headers: headers, params: params
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)['message']).to eq('Created Successfully..!!')
      end
    end
  end

  describe 'PUT /api/v1/comments/{comment.id}' do
    context 'When super admin publish the comment' do
      it 'change from drafted to published' do
        headers = {
          'Authorization' => super_admin.session_token
        }

        params = { status: :published }
        put "/api/v1/comments/#{drafted_comment.id}", headers: headers, params: params
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Saved Successfully..!!')
      end
    end

    context 'When super admin Draft the comment' do
      it 'change from published to drafted' do
        headers = {
          'Authorization' => super_admin.session_token
        }

        params = { status: :drafted }
        put "/api/v1/comments/#{published_comment.id}", headers: headers, params: params
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Saved Successfully..!!')
      end
    end

    context 'When admin publish the comment' do
      it 'change from drafted to published' do
        headers = {
          'Authorization' => admin.session_token
        }

        params = { status: :published }
        put "/api/v1/comments/#{drafted_comment.id}", headers: headers, params: params
        expect(response.status).to eq(422)
      end
    end

    context 'When admin approve the comment' do
      it 'change from drafted to approved' do
        headers = {
          'Authorization' => admin.session_token
        }

        params = { status: :approved }
        put "/api/v1/comments/#{drafted_comment.id}", headers: headers, params: params
        expect(response.status).to eq(200)
      end
    end

    context 'When admin draft the comment' do
      it 'change from to drafted' do
        headers = {
          'Authorization' => admin.session_token
        }

        params = { status: :drafted }
        put "/api/v1/comments/#{published_comment.id}", headers: headers, params: params
        expect(response.status).to eq(200)
      end
    end

    context 'When user publish the comment' do
      it 'change from drafted to published' do
        headers = {
          'Authorization' => user.session_token
        }

        params = { status: :published }
        put "/api/v1/comments/#{drafted_comment.id}", headers: headers, params: params
        expect(response.status).to eq(422)
      end
    end

    context 'When user approve the comment' do
      it 'change from drafted to approved' do
        headers = {
          'Authorization' => user.session_token
        }

        params = { status: :approved }
        put "/api/v1/comments/#{drafted_comment.id}", headers: headers, params: params
        expect(response.status).to eq(422)
      end
    end
  end
end
