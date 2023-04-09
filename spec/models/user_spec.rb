require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: 'test@xyz.com', password: 'password') }

  it 'Validate Correct User data' do
    expect(user).to be_valid
  end

  it 'Validates the presence of email and password' do
    user = User.create(email: '', password: '')
    expect(user).to_not be_valid
  end

  it 'Validate the email format' do
    user = User.create(email: 'test@xyz', password: 'password')
    expect(user).to_not be_valid
  end

  it 'Validate email already taken or not' do
    user = User.create(email: 'giritharan1405@gamil.com', password: 'password')
    expect(user).to_not be_valid
  end
end
