# coding: utf-8
module Research::Views::Analysis
  class Comparison
    include Research::View

    def js_analysis_dictionary
      javascript 'analysis_dictionary'
    end

    def selection_form
      form_for :selection, routes.comparison_path, class: 'form-horizontal',
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
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              datalist :word, stimuli, 'stimuli', class: 'form-control',
                       autocomplete: 'off', required: true
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              datalist :word, stimuli, 'stimuli', class: 'form-control',
                       autocomplete: 'off', required: true
            end
          end
        end

        # type
        div(class: 'form-group') do
          label t('.type'), class: 'col-sm-2 control-label'
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              div(class: 'radio') do
                label('straight-type', class: 'radio-inline') do
                  radio_button :type, 'straight',
                               checked: true
                  span(t('.straight'))
                end
                label('reversed-type', class: 'radio-inline') do
                  radio_button :type, 'reversed'
                  span(t('.reversed'))
                end
              end
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              div(class: 'radio') do
                label('straight-type', class: 'radio-inline') do
                  radio_button :type, 'straight',
                               checked: true
                  span(t('.straight'))
                end
                label('reversed-type', class: 'radio-inline') do
                  radio_button :type, 'reversed'
                  span(t('.reversed'))
                end
              end
            end
          end
        end

        # sex
        div(class: 'form-group') do
          label t('.sex'), class: 'col-sm-2 control-label'
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              div(class: 'radio') do
                label('sex-all', class: 'radio-inline') do
                  radio_button :sex, 'all', checked: true
                  span(t('.all'))
                end
                label('sex-male', class: 'radio-inline') do
                  radio_button :sex, 'male'
                  span(t('.male'))
                end
                label('sex-female', class: 'radio-inline') do
                  radio_button :sex, 'female'
                  span(t('.female'))
                end
              end
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              div(class: 'radio') do
                label('sex-all', class: 'radio-inline') do
                  radio_button :sex, 'all', checked: true
                  span(t('.all'))
                end
                label('sex-male', class: 'radio-inline') do
                  radio_button :sex, 'male'
                  span(t('.male'))
                end
                label('sex-female', class: 'radio-inline') do
                  radio_button :sex, 'female'
                  span(t('.female'))
                end
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
          fields_for :dataset1 do
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
          fields_for :dataset2 do
            div(class: 'col-sm-2 col-sm-offset-1') do
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
        end

        # quiz_id
        div(class: 'form-group') do
          label t('.quiz'), for: 'selection-quiz-id',
                class: 'col-sm-2 control-label'
          options = { '--' => '--' }
          quizzes.each do |quiz|
            options.merge! quiz
          end
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              select :quiz_id, options, class: 'form-control'
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              select :quiz_id, options, class: 'form-control'
            end
          end
        end

        # region
        div(class: 'form-group') do
          label t('.region'), for: 'selection-region',
                class: 'col-sm-2 control-label'
          options = { '--' => '--' }
          regions.each { |r| options.merge! r }
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              select :region, options, class: 'form-control'
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              select :region, options, class: 'form-control'
            end
          end
        end

        # nationality1
        div(class: 'form-group') do
          label t('.nationality'), for: 'selection-nationality1',
                class: 'col-sm-2 control-label'
          options = { '--' => '--' }
          nationalities.each { |n| options.merge! n }
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              select :nationality1, options, class: 'form-control'
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              select :nationality1, options, class: 'form-control'
            end
          end
        end

        # native_language
        div(class: 'form-group') do
          label t('.native-language'), for: 'selection-native-language',
                class: 'col-sm-2 control-label'
          options = { '--' => '--' }
          native_languages.each { |nl| options.merge! nl }
          div(class: 'col-sm-5') do
            fields_for :dataset1 do
              select :native_language, options, class: 'form-control'
            end
          end
          div(class: 'col-sm-5') do
            fields_for :dataset2 do
              select :native_language, options, class: 'form-control'
            end
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
          fields_for :dataset1 do
            div(class: 'col-sm-2') do
              text_field :date_from, class: 'form-control',
                         placeholder: t('.from'), autocomplete: 'off',
                         pattern: '\d\d\.\d\d\.\d\d\d\d'
            end
            div(class: 'col-sm-2') do
              text_field :date_to, class: 'form-control',
                         placeholder: t('.to'), autocomplete: 'off',
                         pattern: '\d\d\.\d\d\.\d\d\d\d'
            end
          end
          fields_for :dataset1 do
            div(class: 'col-sm-2 col-sm-offset-1') do
              text_field :date_from, class: 'form-control',
                         placeholder: t('.from'), autocomplete: 'off',
                         pattern: '\d\d\.\d\d\.\d\d\d\d'
            end
            div(class: 'col-sm-2') do
              text_field :date_to, class: 'form-control',
                         placeholder: t('.to'), autocomplete: 'off',
                         pattern: '\d\d\.\d\d\.\d\d\d\d'
            end
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

    def comparison_table
      html.table(class: 'table table-striped table-hover', id: 'comparison') do
        tr do
          th t('.title')
          th t('.value')
        end
        tr do
          td t('.pearson')
          td correlation[:pearson].round(6)
        end
        tr do
          td t('.spearman')
          td correlation[:spearman].round(6)
        end
        tr do
          td "#{t('.kendall')} (τ-a)"
          td correlation[:kendall].round(6)
        end
        tr do
          td "#{t('.function')} f"
          td correlation[:f_function]
        end
        tr do
          td "#{t('.function')} g"
          td correlation[:g_function].round(6)
        end
      end
    end

    def brief_table
      html.table(class: 'table table-striped table-hover', id: 'brief') do
        tr do
          td t('.all-words')
          td brief[:all]
        end
        tr do
          td t('.distinct-words')
          td brief[:distinct]
        end
        tr do
          td t('.same-words')
          td brief[:same]
        end
        tr do
          td t('.different-words')
          td brief[:different]
        end
      end
    end

    def dictionary_table
      html.table(class: 'table table-striped table-hover', id: 'brief') do
        tr do
          th t('.word')
          th "#{t('.count')} #{t('.for-first')}"
          th "#{t('.count')} #{t('.for-second')}"
        end
        common_reactions.each do |word, counts|
          tr do
            td word
            td counts[0]
            td counts[1]
          end
        end
      end
    end

    def show_error(msg)
      html.div(class: 'alert alert-danger') { msg }
    end

    def t(string, options = {})
      ::I18n.t("research.analysis.dictionary#{string}", options)
    end
  end
end
