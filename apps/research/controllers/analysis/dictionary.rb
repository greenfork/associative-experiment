require_relative './dictionary_validation.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    expose :dictionary, :brief

    def call(params)
      if request.post?
        authorized?
        send_422 && return unless params.valid? && params[:selection]
        stimulus_id = StimulusRepository.new.find_id(params[:selection][:word])
        send_422(:word) && return if stimulus_id.nil?

        reactions = ReactionRepository.new.find_by_params(stimulus_id)
        expose_dictionary(reactions)
        expose_brief(@dictionary)
      end
    end

    private

    def authorized?
      @redirect_url = routes.auth_path
      check_for_logged_in_user
    end

    def send_422(symbol = nil, msg = nil)
      params.errors.add(symbol, msg) if symbol
      @dictionary = @brief = nil
      self.status = 422
    end

    # @reactions: %w[reac1 reac2 ...]
    def expose_dictionary(reactions)
      reaction_array = reactions.to_a.map {|r| r.reaction.nil? ? 'nil' : r.reaction }
      reaction_list = reaction_array.uniq

      @dictionary = []
      reaction_list.each do |reaction|
        reaction_hash = Hash[reaction: reaction, count: reaction_array.count(reaction)]
        @dictionary << reaction_hash
      end
      @dictionary = @dictionary.sort_by { |hash| [-hash[:count], hash[:reaction]] }
    end

    # @dictionary: [Hash[reaction: 'reac1', count: 10, ...], ...]
    def expose_brief(dictionary)
      @brief = Hash[total: 0, distinct: 0, single: 0, null: 0]
      dictionary.each do |hash|
        @brief[:total] += hash[:count]
        @brief[:distinct] += 1
        @brief[:single] += 1 if hash[:count] == 1
        @brief[:null] += hash[:count] if hash[:reaction] == 'nil'
      end
    end
  end
end
