class QuizRepository < Hanami::Repository
  def active_quizzes(id = nil)
    if !id
      quizzes.where(is_active: true)
    else
      quizzes.where(is_active: true, id: id)
    end
  end
end
