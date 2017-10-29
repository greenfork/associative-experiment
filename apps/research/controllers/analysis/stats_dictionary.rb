module Research::Controllers::Analysis::Stats
  class Dictionary
    attr_reader :reactions, :dictionary

    def initialize(reactions)
      @reactions = reactions
      @dictionary = []
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

    # hash = { reaction: 'reac1', count: 18 }
    def insert_hashes
      reaction_list.each do |reaction|
        hash = { reaction: reaction, count: count_occurences(reaction) }
        dictionary << hash
      end
    end

    def count_occurences(reaction)
      reaction_array.count(reaction)
    end

    def reaction_array
      reactions.to_a.map do |r|
        r.reaction.nil? ? 'nil' : r.reaction
      end
    end

    def reaction_list
      reaction_array.uniq
    end
  end
end
