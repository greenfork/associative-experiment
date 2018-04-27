module Research::Views::Analysis
  class Dictionary
    include Research::View

    def selection_form
      form_for :selection, routes.dict_path, class: 'form-horizontal' do
        # word
        div(class: 'form-group') do
          if params.errors.dig(:word)
            div(
              show_error(
                t('.errors.word_not_in_database',
                  word: params[:selection][:word])
              )
            )
          end
          label t('.word'), for: 'selection-word', class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            # text_field :word, class: 'form-control', autocomplete: 'off',
                       # list: 'stimuli'
            datalist :word, datalist_stimuli, 'stimuli', class: 'form-control',
                     autocomplete: 'off'
          end
        end

        # type
        div(class: 'form-group') do
          label t('.type'), class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            div(class: 'radio') do
              label('straight-type', class: 'radio-inline') do
                radio_button :type, 'straight',
                             id: 'selection-straight-type', checked: true
                span(t('.straight'))
              end
              label('reversed-type', class: 'radio-inline') do
                radio_button :type, 'reversed', id: 'selection-reversed-type'
                span(t('.reversed'))
              end
            end
          end
        end

        # sex
        div(class: 'form-group') do
          label t('.sex'), class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            div(class: 'radio') do
              label('sex-all', class: 'radio-inline') do
                radio_button :sex, 'all', id: 'selection-sex-all', checked: true
                span(t('.all'))
              end
              label('sex-male', class: 'radio-inline') do
                radio_button :sex, 'male', id: 'selection-sex-male'
                span(t('.male'))
              end
              label('sex-female', class: 'radio-inline') do
                radio_button :sex, 'female', id: 'selection-sex-female'
                span(t('.female'))
              end
            end
          end
        end

        # age
        div(class: 'form-group') do
          if params.errors.dig(:selection, :age_from) ||
             params.errors.dig(:selection, :age_to)
            div(show_error(t('.errors.irregular_age')))
          end
          label t('.age'), for: 'selection-age-from',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-2') do
            text_field :age_from, class: 'form-control',
                       placeholder: t('.from'), autocomplete: 'off'
          end
          div(class: 'col-sm-2') do
            text_field :age_to, class: 'form-control',
                       placeholder: t('.to'), autocomplete: 'off'
          end
        end

        # region
        div(class: 'form-group') do
          label t('.region'), for: 'selection-region',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = t('regions')
            select :region, options, class: 'form-control'
          end
        end

        # nationality1
        div(class: 'form-group') do
          label t('.nationality'), for: 'selection-nationality1',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            text_field :nationality1, class: 'form-control', autocomplete: 'off'
          end
        end

        # native_language
        div(class: 'form-group') do
          label t('.native-language'), for: 'selection-native-language',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = {}
            t('languages').each do |language|
              options.merge!(Hash[h(language) => h(language)])
            end
            select :native_language, options, class: 'form-control'
          end
        end

        # date
        div(class: 'form-group') do
          if params.errors.dig(:selection, :date_from) ||
             params.errors.dig(:selection, :date_to)
            div(show_error(t('.errors.bad_date_format')))
          end
          label t('.date'), for: 'selection-date-from',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-3') do
            text_field :date_from, class: 'form-control',
                       placeholder: t('.from'), autocomplete: 'off'
          end
          div(class: 'col-sm-3') do
            text_field :date_to, class: 'form-control',
                       placeholder: t('.to'), autocomplete: 'off'
          end
        end

        # submit
        div(class: 'form-group') do
          div(class: 'col-sm-offset-2 col-sm-10') do
            submit t('.submit'), id: 'submit', class: 'btn btn-default'
          end
        end
      end
    end

    def brief_table
      html.table(class: 'table table-striped table-hover', id: 'brief') do
        tr do
          td t('.total')
          td brief[:total]
        end
        tr do
          td t('.distinct')
          td brief[:distinct]
        end
        tr do
          td t('.single')
          td brief[:single]
        end
        tr do
          td t('.nil')
          td brief[:null]
        end
      end
    end

    def dictionary_table
      html.table(class: 'table table-striped table-hover', id: 'dictionary') do
        tr do
          td t('.reaction')
          td t('.count')
          td t('.percent')
        end
        dictionary.each do |hash|
          tr do
            td hash[:reaction]
            td hash[:count]
          end
        end
      end
    end

    private

    def show_error(msg)
      html.div(class: 'alert alert-danger') { msg }
    end
  end
end
