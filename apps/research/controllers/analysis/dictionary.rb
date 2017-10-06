require_relative './dictionary_validation.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    expose :dictionary, :brief

    def call(params)
      if request.post?
        authorized?

        stimulus_id = StimulusRepository.new.find_id(params[:selection][:word])
        reactions = ReactionRepository.new.find_by_params(stimulus_id).to_a.map(&:reaction)
        @dictionary = {}
        reactions.each do |reaction|
          if dictionary.key? reaction
            @dictionary[reaction] += 1
          else
            @dictionary[reaction] = 1
          end
        end

        @brief = Hash[total: 0, distinct: 0, single: 0, null: 0]
        @dictionary.each do |reaction, count|
          @brief[:total] += count
          @brief[:distinct] += 1
          @brief[:single] += 1 if count == 1
          @brief[:null] += count if reaction.nil?
        end
      end
    end

    private

    def authorized?
      @redirect_url = routes.auth_path
      check_for_logged_in_user
    end
  end
end
