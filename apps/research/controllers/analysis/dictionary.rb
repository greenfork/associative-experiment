require_relative './dictionary/dictionary_validation.rb'
require_relative './dictionary/stats_dictionary.rb'
require_relative './dictionary/stats_brief.rb'
require_relative './dictionary/parser_selection_options.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    expose :dictionary, :brief, :stimuli, :type, :quizzes, :nationalities,
           :regions, :native_languages

    def call(params)
      expose_possible_values

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

    def expose_possible_values
      @stimuli = StimulusRepository.new.all.map(&:stimulus).sort || []
      @quizzes = QuizRepository.new.all.map do |quiz|
        { "#{quiz.title}, #{quiz.language}" => quiz.id }
      end
      @nationalities    = PersonRepository.new.distinct(:nationality1)
                                          .map { |n| { n => n } }
      @regions          = PersonRepository.new.distinct(:region)
                                          .map { |r| { r => r } }
      @native_languages = PersonRepository.new.distinct(:native_language)
                                          .map { |nl| { nl => nl } }
    end
  end
end
