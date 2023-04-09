require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) do
    User.create(email: 'user@gmail.com', password: 'password', session_token: SecureRandom.hex(20))
  end
  let(:admin) do
    User.create(email: 'user1@gmail.com', password: 'password', role: :admin, session_token: SecureRandom.hex(20))
  end
  let(:super_admin) do
    User.create(email: 'user2@gmail.com', password: 'password', role: :super_admin, session_token: SecureRandom.hex(20))
  end

  before do
    @user_header = { 'Authorization' => user.session_token }
    @admin_header = { 'Authorization' => admin.session_token }
    @super_admin_header = { 'Authorization' => super_admin.session_token }
  end

  describe 'PUT /api/v1/users/{user.id}' do
    context 'When Super Admin Updates the role' do
      it "updates the user's role to admin" do
        params = {
          role: :admin
        }

        put "/api/v1/users/#{user.id}",
            params: params,
            headers: @super_admin_header

        user.reload
        expect(user.role).to eq('admin')
        expect(response.status).to eq(200)
      end

      it "updates the user's role to super_admin" do
        params = {
          role: :super_admin
        }

        put "/api/v1/users/#{user.id}",
            params: params,
            headers: @super_admin_header

        user.reload
        expect(user.role).to eq('super_admin')
        expect(response.status).to eq(200)
      end
    end

    context 'When Admin updates the role' do
      it "updates the user's role to admin" do
        params = {
          role: :admin
        }

        put "/api/v1/users/#{user.id}",
            params: params,
            headers: @admin_header

        user.reload
        expect(user.role).to eq('admin')
        expect(response.status).to eq(200)
      end

      it "updates the user's role to super_admin" do
        params = {
          role: :super_admin
        }

        put "/api/v1/users/#{user.id}",
            params: params,
            headers: @admin_header

        user.reload
        expect(user.role).to_not eq('super_admin')
        expect(response.status).to eq(422)
      end
    end

    context 'When User updates the role' do
      it "updates the user's role to admin" do
        params = {
          role: :admin
        }

        put "/api/v1/users/#{user.id}",
            params: params,
            headers: @user_header

        user.reload
        expect(user.role).to_not eq('admin')
        expect(response.status).to eq(422)
      end

      it "updates the user's role to super_admin" do
        params = {
          role: :super_admin
        }

        put "/api/v1/users/#{user.id}",
            params: params,
            headers: @user_header

        user.reload
        expect(user.role).to_not eq('super_admin')
        expect(response.status).to eq(422)
      end
    end
  end
end
