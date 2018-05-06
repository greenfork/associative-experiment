module Research::Controllers::Analysis::Parser
  class SelectionOptions
    attr_reader :raw, :parsed_options

    def initialize(raw_options)
      @raw = raw_options
      @parsed_options = {
        options: { people: {}, reactions: {} },
        type: :straight,
        word_list: []
      }
      parse_type
      parse_reactions
      parse_people
      parse_word
    end

    private

    def parse_type
      parsed_options[:type] = :straight if raw[:type] == 'straight'
      parsed_options[:type] = :reversed if raw[:type] == 'reversed'
      parsed_options[:type] = :incidence if raw[:type] == 'incidence'
    end

    def parse_reactions
      parsed_options[:options][:reactions][:quiz_id] = disabled?(raw[:quiz_id])
    end

    def parse_people
      parsed_options[:options][:people] = {
        sex: sex_param(raw[:sex]),
        age_from: raw[:age_from],
        age_to: raw[:age_to],
        nationality1: disabled?(raw[:nationality1]),
        native_language: disabled?(raw[:native_language]),
        region: disabled?(raw[:region]),
        date_from: to_time(raw[:date_from]),
        date_to: to_time(raw[:date_to])
      }
    end

    def disabled?(param)
      return nil if param == '--'
      param
    end

    def parse_word
      if raw[:type] == 'straight'
        parsed_options[:word_list] = [raw[:word]]
      elsif raw[:type] == 'reversed'
        parsed_options[:options][:reactions][:reaction] = raw[:word]
      end
    end

    def sex_param(sex)
      return nil if sex == 'all'
      sex
    end

    def to_time(ru_string)
      return nil if ru_string.nil?
      day, month, year = ru_string.split('.')
      Time.new(year, month, day)
    end
  end
end
