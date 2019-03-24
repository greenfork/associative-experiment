module Admin
  module Authentication
    include Hanami::Tachiban

    def self.included(action)
      action.class_eval do
        before :authenticate!
        expose :successful_login_notice
      end
    end

    private

    def authenticate!
      @redirect_url = routes.auth_path
      check_for_logged_in_user
      @successful_login_notice = flash[:success_notice]
    end
  end
end
