module Research::Controllers::Analysis::Stats
  class Dictionary
    attr_reader :options, :dictionary

    def initialize(options:, repository: ReactionRepository.new)
      @options = options
      @dictionary = []
      @repository = repository
      gather_dictionary
    end

    def gather_dictionary
      @repository.get_dictionary(options).each do |pair|
        @dictionary << {
          reaction: pair.reaction,
          stimulus: pair.stimulus,
          count: pair.pair_count,
          translation: pair.translation,
          translation_comment: pair.translation_comment
        }
      end
    end
  end
end
