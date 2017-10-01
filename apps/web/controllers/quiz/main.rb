module Web::Controllers::Quiz
  class Main
    include Web::Action

    expose :stimuli, :stimuli_enum, :quiz_time_limit, :quiz_start_time

    def call(params)
      session[:quiz_start_time] ||= Time.now.to_i
      quiz_key = "q#{params[:quiz_id]}".to_sym
      expose_stimuli
      expose_stimuli_enumerator
      @params = params.to_h.merge(person: { stimuli: @stimuli })

      if request.post?
        # pass
      elsif request.get?
        unless session.key?(quiz_key) && session[quiz_key][:person_data_validated]
          redirect_to routes.path(:person, params[:quiz_id])
        end
      end
    end

    private

    def expose_stimuli
      all_stimuli = StimulusRepository.new.get_stimuli_of(params[:quiz_id], is_active: true)
      quiz = QuizRepository.new.find(params[:quiz_id])
      @quiz_time_limit = quiz.available_time
      @quiz_start_time = session[:quiz_start_time]
      @stimuli = shuffle_stimuli(all_stimuli.to_a, quiz.number_of_words)
    end

    def shuffle_stimuli(stimuli, number_of_words)
      stimuli.shuffle[0...number_of_words]
    end

    def expose_stimuli_enumerator
      @stimuli_enum = @stimuli.to_enum
    end
  end
end
