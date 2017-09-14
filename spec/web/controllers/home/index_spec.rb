require 'spec_helper'
require_relative '../../../../apps/web/controllers/home/index'

describe Web::Controllers::Home::Index do
  let(:action) { Web::Controllers::Home::Index.new }
  let(:params) { Hash[] }
  let(:repository) { QuizRepository.new }

  before do
    repository.clear

    @quiz = repository.create(title: "QuizA", language: "rus", is_active: true, is_reviewed_automatically: true,
    sex_flag: true, age_flag: true, profession_flag: true, region_flag: true, residence_place_flag: true,
    birth_place_flag: true, nationality1_flag: true, nationality2_flag: true, spoken_languages_flag: true,
    native_language_flag: true, communication_language_flag: true, education_language_flag: true,
    quiz_language_level_flag: true, created_at: 1505331469, updated_at: 1505331469)
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes quizzes' do
    action.call(params)
    action.exposures[:quizzes].must_equal [@quiz]
  end
end
