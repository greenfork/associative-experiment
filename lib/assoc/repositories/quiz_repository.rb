class QuizRepository < Hanami::Repository
  associations do
    has_many :people
    has_many :reactions
  end

  def active_quizzes(id = nil)
    if !id
      quizzes.where(is_active: true)
    else
      quizzes.where(is_active: true, id: id)
    end
  end

  def insert_stimuli_into(quiz_id, stimuli)
    sql = 'INSERT INTO quizzes_stimuli_join (quiz_id, stimulus_id) VALUES '
    stimuli.each do |s|
      sql << "(#{Integer(quiz_id)}, #{Integer(s.id)}), "
    end
    sql = sql[0...-2] << ';'

    quizzes.read(sql).insert
  end

  def clear_stimuli_join_table(quiz_id)
    sql = "DELETE FROM quizzes_stimuli_join WHERE quiz_id = #{Integer(quiz_id)}"
    quizzes.read(sql).delete
  end
end
