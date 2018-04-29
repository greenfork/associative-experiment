require_relative './dictionary/dictionary_validation.rb'
require_relative './dictionary/stats_dictionary.rb'
require_relative './dictionary/stats_brief.rb'
require_relative './dictionary/parser_selection_options.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    expose :dictionary, :brief, :datalist_stimuli, :type

    def call(params)
      @datalist_stimuli = all_stimuli || []

      if request.post?
        authorized?
        return unless params.valid? && params[:selection]
        stimulus_id = StimulusRepository.new.find_id(
          params[:selection][:word].strip
        )
        params.errors.add(:word) && return if stimulus_id.nil?

        parsed_options = Parser::SelectionOptions.new(params[:selection])
                                                 .parsed_options

        @type = parsed_options[:type]
        @dictionary = Stats::Dictionary.new(options: parsed_options).dictionary
        @brief = Stats::Brief.new(@dictionary).brief
      end
    end

    private

    def authorized?
      @redirect_url = routes.auth_path
      check_for_logged_in_user
    end

    def all_stimuli
      StimulusRepository.new.all.map(&:stimulus)
    end
  end
end
