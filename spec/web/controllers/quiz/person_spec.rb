require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/person'

describe Web::Controllers::Quiz::Person do
  let(:action) { Web::Controllers::Quiz::Person.new }
  let(:params) { Hash[id: quiz_id] }
  let(:repository) { QuizRepository.new }
  let(:quiz_id) { 1 }

  before do
    repository.clear

    repository.create(id: quiz_id, title: "QuizA", language: "rus", is_active: false, is_reviewed_automatically: true,
    sex_flag: false, age_flag: true, profession_flag: true, region_flag: true, residence_place_flag: true,
    birth_place_flag: true, nationality1_flag: true, nationality2_flag: true, spoken_languages_flag: true,
    native_language_flag: true, communication_language_flag: true, education_language_flag: true,
    quiz_language_level_flag: true, created_at: 1505331469, updated_at: 1505331469)

    @flags = {
      :sex => false, :age => true, :profession => true, :region => true,
      :residence_place => true, :birth_place => true, :nationality1 => true, :nationality2 => true,
      :spoken_languages => true, :native_language => true, :communication_language => true,
      :education_language => true, :quiz_language_level => true
    }
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes flags' do
    action.call(params)
    action.flags.must_equal @flags
  end
end
