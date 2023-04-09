require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #singup' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post :singup,
               params: { user: { email: 'test@gmail.com', password: 'password', password_confirmation: 'password' } }
        end.to change { User.count }.by(1)
      end

      it 'returns a 201 status code' do
        post :singup,
             params: { user: { email: 'test2@gamil.com', password: 'password', password_confirmation: 'password' } }
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'Create a new user without email and password' do
        post :singup, params: { user: { email: '', password: '', password_confirmation: '' } }
        expect(response.status).to eq(422)
      end

      it 'Create a new user with already exisited email and password' do
        post :singup,
             params: { user: { email: 'giritharan1405@gamil.com', password: 'password',
                               password_confirmation: 'password' } }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'login the user' do
        post :login, params: { email: 'giritharan1405@gamil.com', password: 'giritharan' }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to include('Login Successfully..!!')
      end
    end

    context 'with invalid credentials' do
      it 'invalida credentials' do
        post :login, params: { email: '', password: '' }
        expect(response.status).to eq(401)
      end
    end
  end
end
