module Web::Views::Home
  class Index
    include Web::View

    def title
      t ".title"
    end

    def active_quizzes
      QuizRepository.new.active_quizzes
    end
  end
end
