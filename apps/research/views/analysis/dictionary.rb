module Research::Views::Analysis
  class Dictionary
    include Research::View

    def selection_form
      form_for :selection, routes.dict_path, class: 'form-horizontal' do
        # word
        div(class: 'form-group') do
          label 'Word', for: 'selection-word', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            text_field :word, class: 'form-control'
          end
        end

        # type
        div(class: 'form-group') do
          label 'Type', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            div(class: 'radio') do
              label('straight-type', class: 'radio-inline') do
                radio_button :type, 'straight', id: 'selection-straight-type', checked: true
                span('straight')
              end
              label('reversed-type', class: 'radio-inline') do
                radio_button :type, 'reversed', id: 'selection-reversed-type'
                span('reversed')
              end
            end
          end
        end

        # sex
        div(class: 'form-group') do
          label 'Sex', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            div(class: 'radio') do
              label('sex-all', class: 'radio-inline') do
                radio_button :sex, 'all', id: 'selection-sex-all', checked: true
                span('all')
              end
              label('sex-male', class: 'radio-inline') do
                radio_button :sex, 'male', id: 'selection-sex-male'
                span('male')
              end
              label('sex-female', class: 'radio-inline') do
                radio_button :sex, 'female', id: 'selection-sex-female'
                span('female')
              end
            end
          end
        end

        # age
        div(class: 'form-group') do
          label 'Age', for: 'selection-age-from', class: 'col-sm-2 control-label'
          div(class: 'col-sm-2') do
            text_field :age_from, class: 'form-control', placeholder: 'from'
          end
          div(class: 'col-sm-2') do
            text_field :age_to, class: 'form-control', placeholder: 'to'
          end
        end

        # region
        div(class: 'form-group') do
          label 'Region', for: 'selection-region', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = t('regions')
            select :region, options, class: 'form-control'
          end
        end

        # nationality1
        div(class: 'form-group') do
          label 'Nationality', for: 'selection-nationality1', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            text_field :nationality1, class: 'form-control'
          end
        end

        # native_language
        div(class: 'form-group') do
          label 'Native language', for: 'selection-native-language', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = {}
            t('languages').each { |language| options.merge!(Hash[h(language) => h(language)]) }
            select :native_language, options, class: 'form-control'
          end
        end

        # date
        div(class: 'form-group') do
          label 'Date', for: 'selection-date-from', class: 'col-sm-2 control-label'
          div(class: 'col-sm-2') do
            text_field :date_from, class: 'form-control', placeholder: 'from'
          end
          div(class: 'col-sm-2') do
            text_field :date_to, class: 'form-control', placeholder: 'to'
          end
        end

        # submit
        div(class: 'form-group') do
          div(class: 'col-sm-offset-2 col-sm-10') do
            submit 'Submit', id: 'submit', class: 'btn btn-default'
          end
        end
      end
    end

    def brief_table
      html.table(class: 'table table-striped table-hover', id: 'brief') do
        tr do
          td 'Total'
          td brief[:total]
        end
        tr do
          td 'Distinct'
          td brief[:distinct]
        end
        tr do
          td 'Single'
          td brief[:single]
        end
        tr do
          td 'Null'
          td brief[:null]
        end
      end
    end

    def dictionary_table
      html.table(class: 'table table-striped table-hover', id: 'dictionary') do
        dictionary.each do |hash|
          tr do
            td hash[:reaction]
            td hash[:count]
          end
        end
      end
    end
  end
end
