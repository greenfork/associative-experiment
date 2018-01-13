module Research::Controllers::Analysis::Parser
  class SelectionOptions
    attr_reader :raw, :parsed_options

    def initialize(raw_options)
      @raw = raw_options
      @parsed_options = { people: {}, reactions: {} }
      parse_options
    end

    private

    def parse_options
      parsed_options[:people] = parse_people
      parsed_options[:reactions] = parse_reactions
    end

    def parse_reactions
      raw[:type] == 'reversed' ? { reaction: raw[:word].strip } : {}
    end

    def parse_people
      {
        sex: sex_param(raw[:sex]),
        age: age_param(raw[:age_from], raw[:age_to]),
        nationality1: raw[:nationality1],
        native_language: raw[:native_language],
        date: date_param(raw[:date_from], raw[:date_to])
      }
    end

    def sex_param(sex)
      return nil if sex == 'all'
      sex
    end

    def age_param(age_from, age_to)
      return nil if age_from.nil? && age_to.nil?
      return (age_from.to_i..1000) if age_to.nil?
      return (0..age_to.to_i) if age_from.nil?
      (age_from.to_i..age_to.to_i)
    end

    def date_param(date_from, date_to)
      return nil if date_from.nil? && date_to.nil?
      return (date_from..(Time.now + (60 * 60 * 24))) if date_to.nil?
      return (0..date_to) if date_from.nil?
      (date_from..date_to)
    end
  end
end
