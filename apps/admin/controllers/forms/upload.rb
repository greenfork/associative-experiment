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
          end
        end
      end
    end
  end
end
