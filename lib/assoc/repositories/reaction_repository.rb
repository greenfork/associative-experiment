class ReactionRepository < Hanami::Repository
  associations do
    belongs_to :stimulus
    belongs_to :person
    belongs_to :quiz
  end

  def get_reactions_of(stimulus_id, person_id = nil, quiz_id = nil)
    if !quiz_id.nil?
      reactions.where(
        stimulus_id: stimulus_id, person_id: person_id, quiz_id: quiz_id
      )
    elsif !person_id.nil?
      reactions.where(stimulus_id: stimulus_id, person_id: person_id)
    else
      reactions.where(stimulus_id: stimulus_id)
    end
  end

  def find_by_params(stimulus_id, options = { reactions: {}, people: {} })
    query_options = {
      relations[:reactions][:stimulus_id].qualified => stimulus_id
    }

    options.each do |entity, opts|
      opts.each do |column, value|
        unless value.nil?
          query_options.merge!(relations[entity][column].qualified => value)
        end
      end
    end

    aggregate(:person).join(:person).where(query_options).map_to(Reaction)
  end

  def create_many(list)
    time = Time.now
    list = list.map { |r| r.merge(created_at: time, updated_at: time) }
    command(:create, reactions, result: :many).call(list)
  end

  def get_dictionary(quiz_id: nil,
                     options: { reactions: {}, people: {} },
                     type: :straight)
    # TODO: add sex, age, native_language, date where clauses
    reaction = options[:reactions][:reaction]
    nationality1 = options[:people][:nationality1]
    unless reaction.nil?
      w_reaction = " AND reaction = '#{reaction.gsub("'", "''")}'"
    end
    unless nationality1.nil?
      w_nationality1 = " AND nationality1 = '#{nationality1.gsub("'", "''")}'"
    end
    w_quiz_id = " AND r.quiz_id = #{Integer(quiz_id)}" unless quiz_id.nil?
    order = 'stimulus, pair_count DESC, reaction' if type == :straight
    order = 'reaction, pair_count DESC, stimulus' if type == :reversed

    sql = <<-SQL.gsub(/^ */, '')
        SELECT r.reaction, r.translation, s.stimulus, COUNT(*) as pair_count
        FROM reactions r
        JOIN stimuli s ON s.id = r.stimulus_id
        JOIN people p ON p.id = r.person_id
        WHERE 1 = 1#{w_quiz_id}#{w_reaction}#{w_nationality1}
        GROUP BY reaction, stimulus
        ORDER BY #{order}
    SQL
    root.read(sql).to_a
  end
end
