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
end
