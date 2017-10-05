class StimulusRepository < Hanami::Repository
  associations do
    has_many :reactions
  end

  def get_stimuli_of(quiz_id, options = {})
    is_active = ' AND is_active = 1' if options[:is_active] == true

    sql = <<-SQL.gsub(/^ {6}/, '')
      SELECT s.*
      FROM quizzes q
      JOIN quizzes_stimuli_join qsj ON qsj.quiz_id = q.id
      JOIN stimuli s ON qsj.stimulus_id = s.id
      WHERE q.id = #{quiz_id}#{is_active}
    SQL

    stimuli.read(sql).to_a
  end

  def find_id(stimulus)
    stimuli.where(stimulus: stimulus).one.id
  end
end
