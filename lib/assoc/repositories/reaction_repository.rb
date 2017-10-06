class ReactionRepository < Hanami::Repository
  associations do
    belongs_to :stimulus
    belongs_to :person
    belongs_to :quiz
  end

  def get_reactions_of(stimulus_id, person_id = nil, quiz_id = nil)
    if !quiz_id.nil?
      reactions.where(stimulus_id: stimulus_id, person_id: person_id, quiz_id: quiz_id)
    elsif !person_id.nil?
      reactions.where(stimulus_id: stimulus_id, person_id: person_id)
    else
      reactions.where(stimulus_id: stimulus_id)
    end
  end

  def find_by_params(stimulus_id, options = { reactions: {}, people: {} })
    query_options = { relations[:reactions][:stimulus_id].qualified => stimulus_id }

    options.each do |entity, opts|
      opts.each do |column, value|
        query_options.merge!(relations[entity][column].qualified => value)
      end
    end

    aggregate(:person).join(:person).where(query_options).map_to(Reaction)
  end

  def create_many(list)
    time = Time.now.to_i
    list = list.map { |r| r.merge(created_at: time, updated_at: time) }
    command(:create, reactions, result: :many).call(list)
  end
end
