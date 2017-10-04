require 'spec_helper'

describe UserRepository do
  let(:user_repository) { UserRepository.new }
  let(:login) { 'user' }
  let(:password) { '123' }
  let(:hashed_password) { BCrypt::Password.create(password) }

  before do
    user_repository.clear
    user_repository.create(
      login: login,
      hashed_pass: hashed_password
    )
  end

  it 'finds user by login' do
    user_repository.find_by_login(login).wont_be_nil
  end
end
