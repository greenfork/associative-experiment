module Research::Views::Analysis
  class Dictionary
    include Research::View

    def js_analysis_dictionary
      javascript 'analysis_dictionary'
    end

    def selection_form
      form_for :selection, routes.dict_path, class: 'form-horizontal',
               values: { selection: selection } do
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
            datalist :word, stimuli, 'stimuli', class: 'form-control',
                     autocomplete: 'off', required: true
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
            number_field :age_from, class: 'form-control',
                         placeholder: t('.from'), autocomplete: 'off',
                         min: 1, max: 200
          end
          div(class: 'col-sm-2') do
            number_field :age_to, class: 'form-control',
                       placeholder: t('.to'), autocomplete: 'off',
                       min: 1, max: 200
          end
        end

        # quiz_id
        div(class: 'form-group') do
          label t('.quiz'), for: 'selection-quiz-id',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = { '--' => '--' }
            quizzes.each do |quiz|
              options.merge! quiz
            end
            select :quiz_id, options, class: 'form-control'
          end
        end

        # region
        div(class: 'form-group') do
          label t('.region'), for: 'selection-region',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = { '--' => '--' }
            regions.each { |r| options.merge! r }
            select :region, options, class: 'form-control'
          end
        end

        # nationality1
        div(class: 'form-group') do
          label t('.nationality'), for: 'selection-nationality1',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = { '--' => '--' }
            nationalities.each { |n| options.merge! n }
            select :nationality1, options, class: 'form-control'
          end
        end

        # native_language
        div(class: 'form-group') do
          label t('.native-language'), for: 'selection-native-language',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            options = { '--' => '--' }
            native_languages.each { |nl| options.merge! nl }
            select :native_language, options, class: 'form-control'
          end
        end

        # date
        div(class: 'form-group', id: 'date-selection') do
          if params.errors.dig(:selection, :date_from) ||
             params.errors.dig(:selection, :date_to)
            div(show_error(t('.errors.bad_date_format')))
          end
          label t('.date'), for: 'selection-date-from',
                class: 'col-sm-2 control-label'
          div(class: 'col-sm-3') do
            text_field :date_from, class: 'form-control',
                       placeholder: t('.from'), autocomplete: 'off',
                       pattern: '\d\d\.\d\d\.\d\d\d\d'
          end
          div(class: 'col-sm-3') do
            text_field :date_to, class: 'form-control',
                       placeholder: t('.to'), autocomplete: 'off',
                       pattern: '\d\d\.\d\d\.\d\d\d\d'
          end
        end

        # translation
        div(class: 'form-group') do
          label t('.translation'), class: 'col-sm-2 control-label'
          div(class: 'col-sm-10') do
            div(class: 'checkbox') do
              label('translation', class: 'radio-inline') do
                check_box :translation,
                          checked_value: true,
                          unchecked_value: false
                span(t('.switch-on'))
              end
            end
          end
        end

        # submit
        div(class: 'form-group') do
          div(class: 'col-sm-offset-2 col-sm-10') do
            submit t('.submit'), id: 'submit', class: 'btn btn-default'
            button(
              t('.xlsx-export'),
              class: 'btn btn-default',
              id: 'xlsx-export'
            )
          end
        end

        # output
        hidden_field :output, value: 'html'
      end
    end

    def brief_table_straight
      html.table(class: 'table table-striped table-hover', id: 'brief') do
        tr do
          th t('.total')
          td brief[:total]
        end
        tr do
          th t('.distinct')
          td format('%d / %.2f%', brief[:distinct],
                    brief[:distinct].to_f / brief[:total] * 100)
        end
        tr do
          th t('.single')
          td format('%d / %.2f%', brief[:single],
                    brief[:single].to_f / brief[:total] * 100)
        end
        tr do
          th t('.nil')
          td format('%d / %.2f%', brief[:null],
                    brief[:null].to_f / brief[:total] * 100)
        end
      end
    end

    def brief_table_reversed
      html.table(class: 'table table-striped table-hover', id: 'brief') do
        tr do
          th t('.total')
          td brief[:total]
        end
        tr do
          th t('.distinct')
          td format('%d / %.2f%', brief[:distinct],
                    brief[:distinct].to_f / brief[:total] * 100)
        end
        tr do
          th t('.single')
          td format('%d / %.2f%', brief[:single],
                    brief[:single].to_f / brief[:total] * 100)
        end
      end
    end

    def dictionary_table_straight
      html.table(class: 'table table-striped table-hover', id: 'dictionary') do
        tr do
          th t('.reaction')
          th t('.translation') if with_translation
          th t('.count')
          th t('.percent')
        end
        dictionary.each do |hash|
          tr do
            td hash[:reaction]
            td hash[:translation] if with_translation
            td hash[:count]
            td format('%.2f', hash[:count].to_f / brief[:total] * 100)
          end
        end
      end
    end

    def dictionary_table_reversed
      html.table(class: 'table table-striped table-hover', id: 'dictionary') do
        tr do
          th t('.stimulus')
          th t('.translation') if with_translation
          th t('.count')
          th t('.percent')
        end
        dictionary.each do |hash|
          tr do
            td hash[:stimulus]
            td hash[:st_translation] if with_translation
            td hash[:count]
            td format('%.2f', hash[:count].to_f / brief[:total] * 100)
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
