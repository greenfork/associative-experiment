module Web::Controllers::Quiz
  class ReactionRecord
    attr_reader :reactions, :stimuli, :quiz_id, :person_id

    def initialize(stimuli, quiz_id, person_id)
      @stimuli = stimuli
      @quiz_id = quiz_id
      @person_id = person_id
      @reactions = []
      create_records
    end

    private

    def create_records
      list_reactions
      ReactionRepository.new.create_many(reactions)
    end

    def list_reactions
      stimuli.each do |question|
        add_reaction(question)
      end
    end

    def add_reaction(question)
      @reactions << Hash[
        reaction: reaction(question['reaction']),
        reaction_time: reaction_time(question['start_time'],
                                     question['end_time']),
        keylog: keylog(question['key_log']),
        person_id: person_id,
        stimulus_id: stimulus_id(question['stimulus_id']),
        quiz_id: quiz_id
      ]
    end

    def reaction(reac)
      reac.to_s.empty? ? nil : reac
    end

    def reaction_time(start_time, end_time)
      start_time.to_s.empty? ? nil : (end_time.to_i - start_time.to_i)
    end

    def keylog(key_log)
      key_log.to_s.empty? ? nil : key_log
    end

    def stimulus_id(stimulus_id)
      stimulus_ids.include?(stimulus_id.to_i) ? stimulus_id.to_i : nil
    end

    def stimulus_ids
      return @stimulus_ids unless @stimulus_ids.nil?
      @stimulus_ids = []
      StimulusRepository.new.get_stimuli_of(quiz_id).each do |s|
        @stimulus_ids << s.id
      end
      @stimulus_ids
    end
  end
end
