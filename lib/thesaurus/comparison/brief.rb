module Thesaurus
  module Comparison
    class Brief
      attr_reader :dictionary1, :dictionary2, :result

      def initialize(dictionary1:, dictionary2:)
        @dictionary1 = dictionary1
        @dictionary2 = dictionary2
        @result = {}
      end

      def call
        move_to_R
        calculate
        @result[:all_first] = R.all_first
        @result[:all_second] = R.all_second
        @result[:all] = result[:all_first] + result[:all_second]
        @result[:distinct] = R.distinct
        @result[:same] = R.same
        @result[:different] = result[:distinct] - result[:same]
        result
      end

      def move_to_R
        ['dictionary1', 'dictionary2'].each do |string_dictionary|
          dictionary = eval(string_dictionary)
          reactions = []
          counts = []
          dictionary.each do |dict|
            dict[:reaction] = 'nil' if dict[:reaction].nil?
            reactions << dict[:reaction]
            counts << dict[:count]
          end
          R.reactions = reactions
          R.counts = counts
          R.eval "#{string_dictionary} <- data.frame(reactions = reactions, "\
                 'counts = counts)'
        end
      end

      def calculate
        R.eval <<-EOF
joined <- merge(dictionary1, dictionary2, by="reactions",
                     suffixes = c("1", "2"))
all_first <- sum(dictionary1$counts)
all_second <- sum(dictionary2$counts)
distinct <- length(table(c(as.character(dictionary1$reactions),
                           as.character(dictionary2$reactions))))
same <- length(joined$reactions)
EOF
      end
    end
  end
end
