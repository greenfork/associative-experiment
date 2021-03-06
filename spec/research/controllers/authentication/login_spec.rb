require 'spec_helper'
require_relative '../../../../apps/research/controllers/authentication/login'

describe Research::Controllers::Authentication::Login do
  let(:action) { Research::Controllers::Authentication::Login.new }
  let(:params) { Hash[user: {}] }
  let(:user_repository) { UserRepository.new }
  let(:login) { 'user' }
  let(:wrong_login) { 'wrong_user' }
  let(:password) { '123' }
  let(:wrong_password) { '456' }
  let(:hashed_password) { BCrypt::Password.create(password) }

  before do
    user_repository.clear
    user_repository.create(
      login: login,
      hashed_pass: hashed_password
    )
    I18n.locale = :ru
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  describe 'with correct login and password [POST]' do
    let(:params) {
      Hash[
        user: {
          login: login,
          password: password
        },
        'REQUEST_METHOD' => 'POST'
      ]
    }

    it 'passes and sets a session for the user' do
      response = action.call(params)
      action.session[:current_user].wont_be_nil
      action.error.must_be_nil
      response[0].must_equal 302
    end
  end

  describe 'with incorrect login or password [POST]' do
    let(:params) { Hash[user: {}, 'REQUEST_METHOD' => 'POST'] }

    it 'fails with incorrect login' do
      params[:user][:login] = wrong_login
      params[:user][:login] = password

      response = action.call(params)
      action.error.must_equal true
      response[0].must_equal 401
    end

    it 'fails with incorrect password' do
      params[:user][:login] = login
      params[:user][:login] = wrong_password

      response = action.call(params)
      action.error.must_equal true
      response[0].must_equal 401
    end
  end
end
