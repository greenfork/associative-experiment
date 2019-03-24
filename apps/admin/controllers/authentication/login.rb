module Admin
  module Controllers
    module Authentication
      class Login
        include Admin::Action

        params do
          required(:user).schema do
            required(:login).filled(:str?)
            required(:password).filled(:str?)
          end
        end

        expose :error

        def call(params)
          if request.post?
            @user = UserRepository.new.find_by_login(params[:user][:login])
            if authenticated? params[:user][:password]
              login I18n.t('admin.authentication.login.success')
              redirect_to routes.root_path
            else
              @error = true
              self.status = 401
            end
          end
        end

        private

        def authenticate!; end
      end
    end
  end
end
