module Web::Controllers::Home
  class Index
    include Web::Action

    expose :quizzes

    def call(params)
      @quizzes = QuizRepository.new.active_quizzes.to_a
    end
  end
end
