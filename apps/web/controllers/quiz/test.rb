require_relative './quiz_validation'

module Web::Controllers::Quiz
  class Test
    include Web::Action
    params QuizValidation

    def call(params)
      quiz_key = "q#{params[:quiz_id]}".to_sym

      if request.post?
        redirect_me = catch :invalid_input do
          if params.valid?
            field_flags.each do |field, flag|
              if flag
                throw(:invalid_input, true) if !params[:person][field]
              else
                throw(:invalid_input, true) unless !params[:person][field]
              end
            end
          else
            throw(:invalid_input, true)
          end

          false
        end

        if redirect_me
          redirect_to routes.path(:person, params[:quiz_id])
        else
          session[quiz_key] ||= Hash.new
          session[quiz_key][:person_data_validated] = true
        end

      elsif request.get?
        unless session.has_key?(quiz_key) && session[quiz_key][:person_data_validated]
          redirect_to routes.path(:person, params[:quiz_id])
        end
      end
    end

    private

    # returns {key: bool} for each quiz key
    def field_flags
      # required fields for all quizzes in general
      required_fields = [
        :sex, :age, :profession, :region,
        :residence_place, :birth_place, :nationality1,
        :spoken_languages, :native_language, :communication_language,
        :education_language, :quiz_language_level
      ]
      quiz = QuizRepository.new.find(params[:quiz_id])
      fields = Hash.new
      required_fields.each do |field|
        fields[field] = quiz.send("#{field}_flag")
      end

      fields
    end
  end
end
