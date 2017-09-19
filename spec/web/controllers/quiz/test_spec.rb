require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/test'

describe Web::Controllers::Quiz::Test do
  let(:action) { Web::Controllers::Quiz::Test.new }
  let(:params) { Hash[person: {}, quiz_id: 1] }
  let(:repository) { QuizRepository.new }

  before do
    repository.clear
    repository.create(
      id: 1,
      title: 'QuizA',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      sex_flag: true,
      age_flag: true,
      profession_flag: false,
      region_flag: true,
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
    repository.create(
      id: 2,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: true,
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
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    ::I18n.locale = :ru
  end

  describe 'personal data [POST]' do
    let(:params) { Hash[person: {}, 'REQUEST_METHOD' => 'POST', quiz_id: 1] }

    it 'is fully supplied and valid' do
      params[:person][:sex] = 'male'
      params[:person][:age] = 13
      params[:person][:region] = 'Москва'

      response = action.call(params)
      response[0].must_equal 200
    end

    it 'is partially supplied' do
      params[:person][:sex] = 'male'
      params[:person][:age] = 13

      response = action.call(params)
      response[0].must_equal 302
    end

    it 'is fully supplied but not valid' do
      params[:person][:sex] = 'male'
      params[:person][:age] = 13
      params[:person][:region] = 'Moscow'

      response = action.call(params)
      response[0].must_equal 302
    end

    it 'is provided with every possible argument' do
      params[:quiz_id] = 2

      params[:person][:sex] = 'female'
      params[:person][:age] = 87
      params[:person][:profession] = 'механик'
      params[:person][:region] = 'Татарстан'
      params[:person][:residence_place] = 'Казань'
      params[:person][:birth_place] = 'Казань'
      params[:person][:nationality1] = 'татарин'
      params[:person][:nationality2] = 'татарин'
      params[:person][:spoken_languages] = 2
      params[:person][:native_language] = 'русский'
      params[:person][:communication_language] = 'русский'
      params[:person][:education_language] = 'татарский'
      params[:person][:quiz_language_level] = 'Свободно пишу и разговариваю'

      response = action.call(params)
      response[0].must_equal 200
    end
  end

  describe 'reloading page [GET]' do
    let(:params) { Hash['REQUEST_METHOD' => 'GET', quiz_id: 1] }

    it 'redirects if no data was posted during this session' do
      response = action.call(params)
      response[0].must_equal 302
    end

    it 'reloads current state if person data validated' do
      params['rack.session'] = { "q#{params[:quiz_id]}" => { person_data_validated: true } }

      response = action.call(params)
      response[0].must_equal 200
    end
  end
end
