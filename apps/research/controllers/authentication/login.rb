module Research::Controllers::Authentication
  class Login
    include Research::Action

    expose :error

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
          login I18n.t('research.authentication.login.success')
          redirect_to routes.auth_path # TODO: change route
        else
          @error = true
          self.status = 401
        end
      end
    end
  end
end
