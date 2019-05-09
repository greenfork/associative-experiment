require_relative '../../../../tools/EDI/main.rb'

module Admin
  module Controllers
    module Forms
      class Upload
        include Admin::Action

        def call(params)
          if request.post?
            parser = ParseFormsFromExcel.new(
              respondents_xlsx: params[:form][:respondents][:tempfile],
              respondents_headers: %w[id sex age profession region
                                      residence_place birth_place
                                      nationality1 nationality2
                                      spoken_languages native_language
                                      communication_language
                                      education_language],
              forms_xlsx: params[:form][:forms][:tempfile],
              forms_headers: %w[person_id stimulus stimulus_translation
                                reaction reaction_translation
                                reaction_translation_comment]
            ).call

            quiz_settings = {
              id: 0,
              title: 'Тыва 03.2019',
              language: 'тувинский',
              is_active: false,
              is_reviewed_automatically: false,
              available_time: 20,
              number_of_words: parser.stimuli.size,
              sex_flag: true,
              age_flag: false,
              profession_flag: false,
              region_flag: false,
              residence_place_flag: false,
              birth_place_flag: false,
              nationality1_flag: false,
              nationality2_flag: false,
              spoken_languages_flag: false,
              native_language_flag: false,
              communication_language_flag: false,
              education_language_flag: false,
              quiz_language_level_flag: false,
              created_at: Date.new(2018, 11, 19),
              updated_at: Date.new(2018, 11, 19)
            }

            EDI::Main.new(
              stimuli: parser.stimuli.uniq,
              quiz_settings: quiz_settings,
              people: parser.people
            ).persist

            flash[:successful_data_loading] = 'Данные были успешно загружены'
          end
        end
      end
    end
  end
end
