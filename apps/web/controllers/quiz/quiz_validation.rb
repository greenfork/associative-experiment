require_relative '../../../../config/initializers/locale'

module Web::Controllers::Quiz
  class QuizValidation < Web::Action::Params
    # arrays of described values
    REGIONS = ::I18n.t('web.quiz.person.regions').values
    QUIZ_LANGUAGE_LEVELS = ::I18n.t('web.quiz.person.quiz_language_levels').values
    LANGUAGES = ::I18n.t('languages')

    params do
      required(:person).schema do
        optional(:sex).filled(:str?, included_in?: %w[male female])
        optional(:age).filled(:int?, included_in?: 1..100)
        optional(:profession).filled(:str?)
        optional(:region).filled(:str?, included_in?: REGIONS)
        optional(:residence_place).filled(:str?)
        optional(:birth_place).filled(:str?)
        optional(:nationality1).filled(:str?)
        optional(:nationality2).filled(:str?)
        optional(:spoken_languages).filled(:int?, included_in?: 1..100)
        optional(:native_language).filled(:str?, included_in?: LANGUAGES)
        optional(:communication_language).filled(:str?, included_in?: LANGUAGES)
        optional(:education_language).filled(:str?, included_in?: LANGUAGES)
        optional(:quiz_language_level).filled(:str?, included_in?: QUIZ_LANGUAGE_LEVELS)
      end

      required(:quiz_id).filled(:int?)
    end
  end
end
