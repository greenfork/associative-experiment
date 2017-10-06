require 'features_helper.rb'

describe 'login screen' do
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

  it 'accepts right login and password' do
    visit '/research/authentication'

    fill_in('user[login]', with: login)
    fill_in('user[password]', with: password)
    find('#submit').click

    page.assert_current_path(Research.routes.root_path)
  end

  it 'rejects wrong login' do
    visit '/research/authentication'

    fill_in('user[login]', with: wrong_login)
    fill_in('user[password]', with: password)
    find_button('submit').click

    page.assert_current_path(Research.routes.auth_path)
    find('.alert').text.must_equal 'Вы ввели неправильный логин или пароль'
  end

  it 'rejects wrong password' do
    visit '/research/authentication'

    fill_in('user[login]', with: login)
    fill_in('user[password]', with: wrong_password)
    find_button('submit').click

    page.assert_current_path(Research.routes.auth_path)
    find('.alert').text.must_equal 'Вы ввели неправильный логин или пароль'
  end
end
