require_relative './comparison/comparison_validation.rb'

module Research::Controllers::Analysis
  class Comparison
    include Research::Action
    params ComparisonValidation

    expose :stimuli, :quizzes, :nationalities, :regions, :native_languages,
           :with_translation, :selection, :correlation, :brief,
           :common_reactions

    def call(params)
      expose_possible_values
      unless session[:selection].nil?
        @selection = session[:selection]
        session[:selection] = nil
      end

      if request.post?
        authorized?
        return unless params.valid? && params[:selection]
        word1 = params[:selection][:dataset1][:word].strip
        word2 = params[:selection][:dataset2][:word].strip
        stimulus1_id = StimulusRepository.new.find_id(word1)
        stimulus2_id = StimulusRepository.new.find_id(word2)
        params.errors.add(:word) && return if stimulus1_id.nil?
        params.errors.add(:word) && return if stimulus2_id.nil?

        options1 = params[:selection][:dataset1]
        options2 = params[:selection][:dataset2]
        parsed_options1 = Parser::SelectionOptions.new(options1).parsed_options
        parsed_options2 = Parser::SelectionOptions.new(options2).parsed_options
        dictionary1 = Stats::Dictionary.new(options: parsed_options1)
                                       .dictionary
        dictionary2 = Stats::Dictionary.new(options: parsed_options2)
                                       .dictionary

        correlation = Thesaurus::Comparison::Correlation.new(
          dictionary1: dictionary1,
          dictionary2: dictionary2
        )
        correlation.call
        @correlation = correlation.result
        @common_reactions = correlation.common_reactions
        @brief = Thesaurus::Comparison::Brief.new(
          dictionary1: dictionary1,
          dictionary2: dictionary2
        ).call
      end
    end

    private

    def authorized?
      @redirect_url = routes.auth_path
      session[:selection] = params[:selection]
      check_for_logged_in_user # this redirects if user is not authorized
      session[:selection] = nil
    end

    def expose_possible_values
      @stimuli = StimulusRepository.new.all.map(&:stimulus).sort || []
      @quizzes = QuizRepository.new.all.sort_by(&:title).map do |quiz|
        { "#{quiz.title}, #{quiz.language}" => quiz.id }
      end
      @quizz_names = { '--' => '--' }
      @quizzes.each { |q| @quizz_names[q.values[0]] = q.keys[0] }
      @nationalities    = PersonRepository.new.distinct(:nationality1)
                            .map { |n| { n => n } }
      @regions          = PersonRepository.new.distinct(:region)
                            .map { |r| { r => r } }
      @native_languages = PersonRepository.new.distinct(:native_language)
                            .map { |nl| { nl => nl } }
      @with_translation = params.dig(:selection, :translation)
    end
  end
end
