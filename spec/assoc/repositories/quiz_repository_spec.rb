require 'spec_helper'

describe QuizRepository do
  let(:repository) { QuizRepository.new }
  before do
    repository.clear
    repository.create(
      title: 'QuizA',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: true,
      available_time: 20,
      number_of_words: 100,
      sex_flag: true,
      age_flag: true,
      profession_flag: true,
      region_flag: true,
      residence_place_flag: true,
      birth_place_flag: true,
      nationality1_flag: true,
      nationality2_flag: true,
      spoken_languages_flag: true,
      native_language_flag: true,
      communication_language_flag: true,
      education_language_flag: true,
      quiz_language_level_flag: true,
      created_at: 1_505_331_469,
      updated_at: 1_505_331_469
    )
    repository.create(
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: true,
      available_time: 20,
      number_of_words: 100,
      sex_flag: true,
      age_flag: true,
      profession_flag: true,
      region_flag: true,
      residence_place_flag: true,
      birth_place_flag: true,
      nationality1_flag: true,
      nationality2_flag: true,
      spoken_languages_flag: true,
      native_language_flag: true,
      communication_language_flag: true,
      education_language_flag: true,
      quiz_language_level_flag: true,
      created_at: 1_505_331_469,
      updated_at: 1_505_331_469
    )
    repository.create(
      title: 'QuizC',
      language: 'rus',
      is_active: false,
      is_reviewed_automatically: true,
      available_time: 20,
      number_of_words: 100,
      sex_flag: true,
      age_flag: true,
      profession_flag: true,
      region_flag: true,
      residence_place_flag: true,
      birth_place_flag: true,
      nationality1_flag: true,
      nationality2_flag: true,
      spoken_languages_flag: true,
      native_language_flag: true,
      communication_language_flag: true,
      education_language_flag: true,
      quiz_language_level_flag: true,
      created_at: 1_505_331_469,
      updated_at: 1_505_331_469
    )
  end

  it 'queries only active quizzes' do
    repository.active_quizzes.count.must_equal 2
  end
end
