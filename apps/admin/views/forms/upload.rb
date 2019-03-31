module Admin
  module Views
    module Forms
      class Upload
        include Admin::View

        def login_notice
          return unless successful_login_notice

          html.div class: 'alert alert-success' do
            successful_login_notice
          end
        end

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
              label t('.respondents.label'), for: 'form-respondents',
                    class: 'col-sm-2 control-label'
              div class: 'col-sm-10' do
                file_field :respondents
              end
            end

            div class: 'col-sm-10 col-sm-offset-2' do
              respondents_file_description
            end



            div class: 'form-group' do
              label t('.forms.label'), for: 'form-forms',
                    class: 'col-sm-2 control-label'
              div class: 'col-sm-10' do
                file_field :forms
              end
            end
            div class: 'col-sm-10 col-sm-offset-2' do
              forms_file_description
            end

            div class: 'form-group' do
              div(class: 'col-sm-offset-2 col-sm-10') do
                submit t('.upload'), id: 'submit', class: 'btn btn-primary'
              end
            end
          end
        end

        def general_file_requirements
          html.div do
            p t('.file_requirements.title') << ':'
            ul do
              li t('.file_requirements.point1')
              li t('.file_requirements.point2')
              li t('.file_requirements.point3')
            end
          end
        end

        def respondents_file_description
          html.div do
            p t('.respondents.title') << ':'
            p t('.respondents.description')
            p do
              span link_to(t('.respondents.example1'),
                           '/assets/admin/respondents1.xlsx')
              span ','
              span link_to(t('.respondents.example2'),
                           '/assets/admin/respondents2.xlsx')
            end
            p do
              button t('.respondents.attributes_button'),
                     class: 'btn btn-default',
                     'data-toggle': 'collapse',
                     'data-target': '#respondents-attributes',
                     type: 'button'
            end
            ul id: 'respondents-attributes', class: 'collapse' do
              li t('.respondents.id')
              li t('.respondents.sex')
              li t('.respondents.age')
              li t('.respondents.profession')
              li t('.respondents.region')
              li t('.respondents.residence_place')
              li t('.respondents.birth_place')
              li t('.respondents.nationality1')
              li t('.respondents.nationality2')
              li t('.respondents.spoken_languages')
              li t('.respondents.native_language')
              li t('.respondents.communication_language')
              li t('.respondents.education_language')
            end
          end
        end

        def forms_file_description
          html.div do
            p t('.forms.title') << ':'
            p t('.forms.description')
            p do
              span link_to(t('.forms.example1'),
                           '/assets/admin/forms1.xlsx')
              span ','
              span link_to(t('.forms.example2'),
                           '/assets/admin/forms2.xlsx')
            end
            p do
              button t('.forms.attributes_button'),
                     class: 'btn btn-default',
                     'data-toggle': 'collapse',
                     'data-target': '#forms-attributes',
                     type: 'button'
            end
            ul id: 'forms-attributes', class: 'collapse' do
              li t('.forms.person_id')
              li t('.forms.stimulus')
              li t('.forms.stimulus_translation')
              li t('.forms.reaction')
              li t('.forms.reaction_translation')
              li t('.forms.reaction_translation_comment')
            end
          end
        end
      end
    end
  end
end
