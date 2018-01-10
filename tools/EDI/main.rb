# should load the project environment
require_relative './quiz.rb'

module EDI
  # Takes results of an associative linguistic experiment and puts in into
  # the database creating records for quiz, stimuli, people and reactions
  class Main
    attr_reader :stimuli_array, :quiz_settings, :people

    # @param stimuli_array [Array<String>] array of stimuli
    # @param quiz_settings [Hash] hash of flag values corresponding to the
    #  columns in the quiz table in the database
    # @param people [Array<Hash>] array of 'person' hashes which have person's
    #  data and associated reactions with the following structure:
    #
    #  people[0][:data] -- hash of flag values corresponding to the columns
    #  in the person table in the database
    #
    #  people[0][:reactions][0] -- hash with the required :reaction and
    #  :stimulus keys and optional :translation, :translation_comment keys with
    #  values of a class String
    def initialize(stimuli:, quiz_settings:, people:)
      @stimuli_array = stimuli
      @quiz_settings = quiz_settings
      @people = people
    end

    # Writes all data to the database
    def persist
      quiz = create_quiz(stimuli_array, quiz_settings)
      quiz_id = quiz.id
      stimuli = quiz.stimuli

      people.each do |person|
        person = person[1] if people.is_a? Hash
        person_id = add_person(person[:data], quiz_id: quiz_id)
        add_reactions(person[:reactions],
                      quiz_id: quiz_id,
                      person_id: person_id,
                      stimuli: stimuli)
      end
    end

    private

    def create_quiz(stimuli_array, quiz_settings)
      quiz = EDI::Quiz.new(settings: quiz_settings,
                           stimuli_list: stimuli_array)

      quiz.missing_stimuli do |s|
        StimulusRepository.new.create(stimulus: s)
      end

      quiz.bind_stimuli
      quiz
    end

    def add_person(person_data, quiz_id:)
      person_data[:quiz_id] = quiz_id
      person_data[:uuid] = SecureRandom.uuid
      person_data[:is_reviewed] = 1
      person = PersonRepository.new.create(person_data)
      person.id
    end

    def add_reactions(reactions, person_id:, quiz_id:, stimuli:)
      reactions.map! do |r|
        stimulus_id = find_stimulus_id(r[:stimulus], stimuli)
        if stimulus_id.nil?
          r = nil
          next
        end
        r.merge!(person_id: person_id,
                 quiz_id: quiz_id,
                 stimulus_id: stimulus_id)

        r.reject! { |key, _| key == :stimulus }
      end
      ReactionRepository.new.create_many(reactions.compact)
    end

    def find_stimulus_id(stimulus, stimuli)
      stimuli.each do |s|
        return s.id if s.stimulus == stimulus
      end
      nil
    end
  end
end
