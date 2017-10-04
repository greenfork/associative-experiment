module Research::Controllers::Authorization
  class Login
    include Research::Action

    params do
      required(:user).schema do
        required(:login).filled(:str?)
        required(:password).filled(:str?)
      end
    end

    def call(params)
      if request.post?
        @user = UserRepository.new.find_by_login(params[:user][:login])
        if authenticated? params[:user][:password]
          login 'Вы успешно вошли в систему'
          redirect_to '/' # TODO: change route
        else
          self.status = 401
        end
      end
    end
  end
end
