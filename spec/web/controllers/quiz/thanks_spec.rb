require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/thanks'

describe Web::Controllers::Quiz::Thanks do
  let(:action) { Web::Controllers::Quiz::Thanks.new }
  let(:params) {
    Hash[
      'rack.session' => {
        person: {
          sex: 'male',
          age: 21,
          total_time: 280,
          quiz_id: quiz_id
        }
      }
    ]
  }
  let(:person_repository) { PersonRepository.new }
  let(:quiz_repository) { QuizRepository.new }
  let(:quiz_id) { 1 }
  let(:quiz_title) { 'QuizA' }

  before do
    quiz_repository.clear
    quiz_repository.create(
      id: quiz_id,
      title: quiz_title,
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 300,
      number_of_words: 10,
      sex_flag: true,
      age_flag: true,
      profession_flag: false,
      region_flag: false,
      residence_place_flag: false,
      birth_place_flag: false,
      nationality1_flag: false,
      nationality2_flag: false,
      spoken_languages_flag: false,
      native_language_flag: false,
      communication_language_flag: false,
      education_language_flag: false,
      quiz_language_level_flag: false,
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    person_repository.clear
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes UUID and quiz_title' do
    action.call(params)
    action.uuid.wont_be_empty
    action.quiz_title.must_equal quiz_title
  end

  it 'writes right data into DB about respondent' do
    action.call(params)
    person = person_repository.last

    person.sex.must_equal 'male'
    person.age.must_equal 21
    person.profession.must_be_nil
    person.region.must_be_nil
    person.residence_place.must_be_nil
    person.birth_place.must_be_nil
    person.nationality1.must_be_nil
    person.nationality2.must_be_nil
    person.spoken_languages.must_be_nil
    person.native_language.must_be_nil
    person.communication_language.must_be_nil
    person.education_language.must_be_nil
    person.quiz_language_level.must_be_nil

    person.uuid.must_equal action.uuid
    person.date.wont_be_nil
    [true, false].must_include person.is_reviewed
    person.total_time.wont_be_nil
    person.quiz_id.must_equal quiz_id
  end
end
