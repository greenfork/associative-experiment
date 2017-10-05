require_relative './dictionary_validation.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    expose :dictionary

    def call(params)
      if request.post?
        authorized?

        stimulus_id = StimulusRepository.new.find_id(params[:selection][:word])
        reactions = ReactionRepository.new.find_by_params(stimulus_id).to_a.map(&:reaction)
        @dictionary = {}
        reactions.each do |reaction|
          if dictionary.key? reaction
            dictionary[reaction] += 1
          else
            dictionary[reaction] = 1
          end
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
