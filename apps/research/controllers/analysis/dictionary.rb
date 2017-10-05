require_relative './dictionary_validation.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    def call(params)
      if request.post?
        ReactionRepository.new.find_by_params(stimulus: params[:dict][:word]).to_a
      end
    end
  end
end
