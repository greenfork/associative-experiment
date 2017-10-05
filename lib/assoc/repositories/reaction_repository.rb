class ReactionRepository < Hanami::Repository
  def get_reactions_of(stimulus_id, person_id = nil, quiz_id = nil)
    if !quiz_id.nil?
      reactions.where(stimulus_id: stimulus_id, person_id: person_id, quiz_id: quiz_id)
    elsif !person_id.nil?
      reactions.where(stimulus_id: stimulus_id, person_id: person_id)
    else
      reactions.where(stimulus_id: stimulus_id)
    end
  end

  def find_by_params(stimulus_id, options = {})
    
  end
end
