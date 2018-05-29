require_relative '../../../../../config/initializers/locale'

module Research::Controllers::Analysis
  class ComparisonValidation < Research::Action::Params
    # arrays of described values
    REGIONS = ::I18n.t('regions').values + ['--']
    QUIZ_LANGUAGE_LEVELS = ::I18n.t('quiz_language_levels').values
    LANGUAGES = ::I18n.t('languages') + ['--']

    params do
      optional(:selection).schema do
        required(:dataset1).schema do
          required(:word).filled(:str?)
          required(:type).filled(:str?, included_in?: %w[straight reversed])
          optional(:sex).filled(:str?, included_in?: %w[male female all])
          optional(:age_from).maybe(:int?, included_in?: 1..200)
          optional(:age_to).maybe(:int?, included_in?: 1..200)
          optional(:profession).maybe(:str?)
          optional(:quiz_id).filled(:str?)
          optional(:region).filled(:str?, included_in?: REGIONS)
          optional(:residence_place).maybe(:str?)
          optional(:birth_place).maybe(:str?)
          optional(:nationality1).filled(:str?)
          optional(:nationality2).maybe(:str?)
          optional(:spoken_languages).filled(:int?, included_in?: 1..100)
          optional(:native_language).filled(:str?, included_in?: LANGUAGES)
          optional(:communication_language).filled(:str?, included_in?: LANGUAGES)
          optional(:education_language).filled(:str?, included_in?: LANGUAGES)
          optional(:quiz_language_level).filled(:str?, included_in?: QUIZ_LANGUAGE_LEVELS)
          optional(:date_from).maybe(:str?)
          optional(:date_to).maybe(:str?)
        end

        required(:dataset2).schema do
          required(:word).filled(:str?)
          required(:type).filled(:str?, included_in?: %w[straight reversed])
          optional(:sex).filled(:str?, included_in?: %w[male female all])
          optional(:age_from).maybe(:int?, included_in?: 1..200)
          optional(:age_to).maybe(:int?, included_in?: 1..200)
          optional(:profession).maybe(:str?)
          optional(:quiz_id).filled(:str?)
          optional(:region).filled(:str?, included_in?: REGIONS)
          optional(:residence_place).maybe(:str?)
          optional(:birth_place).maybe(:str?)
          optional(:nationality1).filled(:str?)
          optional(:nationality2).maybe(:str?)
          optional(:spoken_languages).filled(:int?, included_in?: 1..100)
          optional(:native_language).filled(:str?, included_in?: LANGUAGES)
          optional(:communication_language).filled(:str?, included_in?: LANGUAGES)
          optional(:education_language).filled(:str?, included_in?: LANGUAGES)
          optional(:quiz_language_level).filled(:str?, included_in?: QUIZ_LANGUAGE_LEVELS)
          optional(:date_from).maybe(:str?)
          optional(:date_to).maybe(:str?)
        end

        required(:output).filled(:str?, included_in?: %w[html xlsx])
        required(:translation).filled(:bool?)
      end
    end
  end
end
