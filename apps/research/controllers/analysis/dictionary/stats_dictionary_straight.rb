module Research::Controllers::Analysis::Stats
  # Straight means the relation Stimulus -> Reaction. It gets a number of
  # reactions if the stimulus is specified. Reversed is the opposite.
  class DictionaryStraight
    attr_reader :reactions, :dictionary

    def initialize(reactions)
      @reactions = reactions
      @dictionary = []
      @reaction_list = []
      generate_dictionary
    end

    private

    def generate_dictionary
      insert_hashes
      sort_dictionary
    end

    def sort_dictionary
      dictionary.sort_by! { |hash| [-hash[:count], hash[:reaction]] }
    end

    # hash = { reaction: 'reac1', count: 18, translation: 'tr1',
    #  translation_comment: 'tr_c1'}
    def insert_hashes
      reactions.to_a.each do |reac|
        reaction = reac.reaction
        next if @reaction_list.include? reaction
        @reaction_list.push reaction
        count = count_occurences(reaction)
        reaction = 'nil' if reaction.nil?
        hash = { reaction: reaction,
                 count: count,
                 translation: reac.translation,
                 translation_comment: reac.translation_comment }
        dictionary << hash
      end
    end

    def count_occurences(reaction)
      reactions.to_a.count { |r| r.reaction == reaction }
    end
  end
end
