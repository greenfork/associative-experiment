require_relative './dictionary/dictionary_validation.rb'
require_relative './dictionary/stats_dictionary.rb'
require_relative './dictionary/stats_brief.rb'
require_relative './dictionary/parser_selection_options.rb'
require_relative './dictionary/xlsx_export.rb'

module Research::Controllers::Analysis
  class Dictionary
    include Research::Action
    params DictionaryValidation

    expose :dictionary, :brief, :stimuli, :type, :quizzes, :nationalities,
           :regions, :native_languages, :selection

    def call(params)
      expose_possible_values
      unless session[:selection].nil?
        @selection = session[:selection]
        session[:selection] = nil
      end

      if request.post?
        authorized?
        return unless params.valid? && params[:selection]
        params[:selection][:word] = params[:selection][:word].strip
        stimulus_id = StimulusRepository.new.find_id(
          params[:selection][:word].strip
        )
        params.errors.add(:word) && return if stimulus_id.nil?

        parsed_options = Parser::SelectionOptions.new(params[:selection])
                                                 .parsed_options

        @type = parsed_options[:type]
        @dictionary = Stats::Dictionary.new(options: parsed_options).dictionary
        @brief = Stats::Brief.new(@dictionary).brief

        if params[:selection][:output] == 'xlsx'
          self.status = 200
          headers['Content-Type'] =
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
          headers['Content-Disposition'] =
            "attachment; filename=#{params[:selection][:word]}.xlsx"
          self.body = XlsxExport.new(
            params: params[:selection],
            dictionary: @dictionary,
            brief: @brief,
            quizz_names: @quizz_names
          ).xlsx
        end
      end
    end

    private

    def authorized?
      @redirect_url = routes.auth_path
      session[:selection] = params[:selection]
      check_for_logged_in_user # this redirects if user is not authorized
      session[:selection] = nil # this is only executed when user is authorized
    end

    def expose_possible_values
      @stimuli = StimulusRepository.new.all.map(&:stimulus).sort || []
      @quizzes = QuizRepository.new.all.map do |quiz|
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
    end
  end
end
