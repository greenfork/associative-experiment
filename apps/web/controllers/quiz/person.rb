module Web::Controllers::Quiz
  class Person
    include Web::Action

    expose :flags

    def call(params)
      @flags = {}
      flags_array = %i[
        sex age profession region
        residence_place birth_place nationality1 nationality2
        spoken_languages native_language communication_language
        education_language quiz_language_level
      ]

      repository = QuizRepository.new
      quiz = repository.active_quizzes(params[:quiz_id]).first
      if quiz
        flags_array.each do |flag|
          @flags[flag] = quiz.send("#{flag}_flag")
        end
      else
        redirect_to routes.root_path
      end
    end
  end
end
