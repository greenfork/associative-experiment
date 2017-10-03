require 'features_helper.rb'

describe 'login screen' do
  let(:user_repository) { UserRepository.new }
  let(:login) { 'user' }
  let(:wrong_login) { 'wrong_user' }
  let(:password) { '123' }
  let(:wrong_password) { '345' }

  before do
    user_repository.clear
    user_repository.create(
      login: login,
      password: password
    )
  end

  it 'accepts right login and password' do
    visit '/authorization'

    fill_in('user[login]', with: login)
    fill_in('user[password]', with: password)
    find_button('submit').click

    page.assert_current_path(Web.routes.word_analysis_path)
  end
end
