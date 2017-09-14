class QuizRepository < Hanami::Repository
  def active_quizzes
    quizzes.where(is_active: true)
  end
end
