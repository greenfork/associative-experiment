module Admin
  module Views
    module Forms
      class Upload
        include Admin::View

        def form
          form_for :form, routes.upload_path, class: 'form-horizontal',
                   enctype: 'multipart/form-data' do
            div class: 'form-group' do
              label t('.quiz'), for: 'form-quiz-id',
                    class: 'col-sm-2 control-label'
              div class: 'col-sm-10' do
                select :quiz_id, { 'Тыва 03.2019, тувинский' => 1 },
                       class: 'form-control'
              end
            end

            div class: 'form-group' do
              label t('.respondents'), for: 'form-respondents',
                    class: 'col-sm-2 control-label'
              div class: 'col-sm-10' do
                file_field :respondents
              end
            end

            div class: 'form-group' do
              label t('.forms'), for: 'form-respondents',
                    class: 'col-sm-2 control-label'
              div class: 'col-sm-10' do
                file_field :forms
              end
            end

            div class: 'form-group' do
              div(class: 'col-sm-offset-2 col-sm-10') do
                submit t('.check'), id: 'submit', class: 'btn btn-default'
              end
            end
          end
        end
      end
    end
  end
end
