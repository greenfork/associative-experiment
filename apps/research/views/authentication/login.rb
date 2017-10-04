module Research::Views::Authentication
  class Login
    include Research::View

    def form
      form_for :user, routes.auth_path, class: 'form-horizontal' do
        div(class: 'form-group') do
          label t('.login_label'), for: 'user-login'
          text_field :login, class: 'form-control'
        end
        div(class: 'form-group') do
          label t('.password_label'), for: 'user-password'
          password_field :password, class: 'form-control'
        end
        submit t('.send_button'), class: 'btn btn-primary', id: 'submit'
      end
    end

    def show_errors
      if error
        html.div(class: 'alert alert-danger') do
          t '.error'
        end
      end
    end
  end
end
