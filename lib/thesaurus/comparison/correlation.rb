module Thesaurus
  module Comparison
    class Correlation
      attr_reader :dictionary1, :dictionary2, :result, :common_reactions,
                  :x, :y

      def initialize(dictionary1:, dictionary2:)
        @dictionary1 = dictionary1
        @dictionary2 = dictionary2
        @result = {}
      end

      def call
        extract_common_reactions
        move_to_R
        calculate
        @result[:pearson] = R.pearson
        @result[:spearman] = R.spearman
        @result[:kendall] = R.kendall
        result
      end

      private

      def extract_common_reactions
        @common_reactions = {}
        keys = @dictionary1.map { |d| d[:reaction] } &
               @dictionary2.map { |d| d[:reaction] }
        keys.sort.each { |key| @common_reactions[key] = [] }
        dictionary1.each do |reac|
          if keys.include? reac[:reaction]
            @common_reactions[reac[:reaction]][0] = reac[:count]
          end
        end
        dictionary2.each do |reac|
          if keys.include? reac[:reaction]
            @common_reactions[reac[:reaction]][1] = reac[:count]
          end
        end
      end

      def move_to_R
        @x = []
        @y = []
        common_reactions.each do |_k, v|
          @x << v[0]
          @y << v[1]
        end
        R.x = x
        R.y = y
      end

      def calculate
        R.eval <<-EOF
pearson <- cor(x, y, method = "pearson")
spearman <- cor(x, y, method = "spearman")
kendall <- cor(x, y, method = "kendall")
EOF
      end
    end
  end
end
