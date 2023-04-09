require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(email: 'test@xyz.com', password: 'password') }

  it 'Validate content presence' do
    comment = Comment.create(content: '', user_id: user.id)
    expect(comment).to_not be_valid
  end

  it 'Validate user id presence' do
    comment = Comment.create(content: 'Test Comment')
    expect(comment).to_not be_valid
  end

  it 'Validate Comment' do
    comment = Comment.create(content: 'Test Comment', user_id: user.id)
    expect(comment).to be_valid
  end
end
