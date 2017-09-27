require_relative './quiz_validation'

module Web::Controllers::Quiz
  class Test
    include Web::Action
    params QuizValidation

    expose :stimuli, :time, :words

    def call(params)
      @stimuli = I18n.t 'web.quiz.test.stimuli'
      quiz_key = "q#{params[:quiz_id]}".to_sym
      expose_quiz_info

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
          session[quiz_key] ||= {}
          session[quiz_key][:person_data_validated] = true
        end

      elsif request.get?
        unless session.key?(quiz_key) && session[quiz_key][:person_data_validated]
          redirect_to routes.path(:person, params[:quiz_id])
        end
      end
    end

    private

    # returns {key: bool} for each quiz key
    def field_flags
      # required fields for all quizzes in general
      required_fields = %i[
        sex age profession region
        residence_place birth_place nationality1
        spoken_languages native_language communication_language
        education_language quiz_language_level
      ]
      quiz = QuizRepository.new.find(params[:quiz_id])
      fields = {}
      required_fields.each do |field|
        fields[field] = quiz.send("#{field}_flag")
      end

      fields
    end

    # expose number of words and available time limit
    def expose_quiz_info
      quiz = QuizRepository.new.find(params[:quiz_id])
      @time = quiz.available_time
      @words = quiz.number_of_words
    end
  end
end
