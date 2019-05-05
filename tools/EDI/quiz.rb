module EDI
  # Creates record for quiz and corresponding stimuli in the database
  # and binds them together via join table
  class Quiz
    class MissingStimuliException < StandardError; end

    attr_reader :quiz, :settings, :stimuli_list, :id

    # @param settings [Hash] all the corresponding columns in the database
    # @param stimuli_list [Array<String>] all the stimuli that this quiz
    #   consists of
    def initialize(settings:, stimuli_list:)
      @settings = settings
      @stimuli_list = stimuli_list
      create_quiz(QuizRepository.new)
      stimuli(StimulusRepository.new)
    end

    # Yields all the stimuli missing in the database
    # @yield all the stimuli missing in the database
    # @yieldparam s [String] stimulus which is not present in the database
    def missing_stimuli
      stimuli.each { |s| yield s if s.id.nil? }
    end

    # Connects all the stimuli to the current quiz via join table in database
    def bind_stimuli
      stimulus_repository = StimulusRepository.new
      stim = stimuli(stimulus_repository, refetch: true)
      if stim.any? { |s| s.id.nil? }
        raise MissingStimuliException, 'Some stimuli are missing from database'
      end
      stim.select! { |s| stimulus_repository.find(s.id).nil? }
      if !stim.empty?
        QuizRepository.new.insert_stimuli_into(quiz.id, stim)
      end
    end

    # Returns an array of Stimulus objects
    # @param stimulus_repository an object that has a method #find_id(s)
    #   which returns stimulus' id from database where param 's' is the
    #   stimulus itself
    # @param refetch [Boolean] if true it refreshes the cached value of
    #   all stimuli, false by default
    # @return [Array<Stimulus>] objects with IDs corresponding to records
    #   in database or with ID = nil if there's no such record
    def stimuli(stimulus_repository = nil, refetch: false)
      return @stimuli unless @stimuli.nil? || refetch
      @stimuli = []
      # TODO: `s` should be an array of hashes. Change readme to indicate
      #       this requirement and change later its current implementation
      stimuli_list.each do |s|
        # s = s.is_a?(String) ? s : s[:stimulus]
        id = stimulus_repository.find_id(s)
        @stimuli << Stimulus.new(
          id: id,
          stimulus: s
          # translation: s[:translation]
        )
      end
      @stimuli
    end

    private

    def create_quiz(quiz_repository)
      @quiz = quiz_repository.find_by_title(settings[:title])
      @quiz ||= quiz_repository.create(settings)
      @id = @quiz.id
    end
  end
end
