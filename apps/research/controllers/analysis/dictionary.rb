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
        stimulus_id = StimulusRepository.new.find_id(
          params[:selection][:word].strip
        )
        send_422(:word) && return if stimulus_id.nil?

        reactions = ReactionRepository.new.find_by_params(
          stimulus_id,
          reaction_params(params[:selection])
        )
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

    def reaction_params(params)
      people = {
        sex: sex_param(params[:sex]),
        age: age_param(params[:age_from], params[:age_to]),
        nationality1: params[:nationality1],
        native_language: params[:native_language],
        date: date_param(params[:date_from], params[:date_to])
      }
      reactions = {}
      { reactions: reactions, people: people }
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
