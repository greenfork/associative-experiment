module Web::Views::Quiz
  class Person
    include Web::View

    def person
      PersonRepository.new.first
    end
    def quiz
      QuizRepository.new.find(id: params[:id])
    end
  end
end
