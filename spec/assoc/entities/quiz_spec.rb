require 'spec_helper'

describe Quiz do
  it 'can be initialized' do
    quiz = Quiz.new(title: "QuizA", language: "rus", is_active: true, is_reviewed_automatically: true,
    sex_flag: true, age_flag: true, profession_flag: true, region_flag: true, residence_place_flag: true,
    birth_place_flag: true, nationality1_flag: true, nationality2_flag: true, spoken_languages_flag: true,
    native_language_flag: true, communication_language_flag: true, education_language_flag: true,
    quiz_language_level_flag: true, created_at: 1505331469, updated_at: 1505331469)
    quiz.title.must_equal "QuizA"
  end
end
