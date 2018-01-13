module Research::Controllers::Analysis::Stats
  # Straight means the relation Stimulus -> Reaction. It gets a number of
  # reactions if the stimulus is specified. Reverse is the opposite.
  class BriefStraight
    attr_reader :dictionary, :brief

    def initialize(dictionary)
      @dictionary = dictionary
      @brief = { total: 0, distinct: 0, single: 0, null: 0 }
      generate_brief
    end

    private

    def generate_brief
      dictionary.each do |hash|
        brief[:total] += hash[:count]
        brief[:distinct] += 1
        brief[:single] += 1 if hash[:count] == 1
        brief[:null] += hash[:count] if hash[:reaction] == 'nil'
      end
    end
  end
end
