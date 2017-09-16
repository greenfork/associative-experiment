module Web::Controllers::Quiz
  class Person
    include Web::Action

    expose :flags

    def call(params)
      @flags = Hash.new
      flags_array = [
        :sex, :age, :profession, :region,
        :residence_place, :birth_place, :nationality1, :nationality2,
        :spoken_languages, :native_language, :communication_language,
        :education_language, :quiz_language_level
      ]

      repository = QuizRepository.new
      quiz = repository.find(params[:quiz_id])
      flags_array.each do |flag|
        @flags[flag] = quiz.send("#{flag}_flag")
      end
    end
  end
end
