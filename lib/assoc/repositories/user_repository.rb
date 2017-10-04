class UserRepository < Hanami::Repository
  def find_by_login(login)
    users.where(login: login).one
  end
end
