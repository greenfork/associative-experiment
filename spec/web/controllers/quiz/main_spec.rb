require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/main'

describe Web::Controllers::Quiz::Main do
  let(:action) { Web::Controllers::Quiz::Main.new }
  let(:params) { Hash[quiz_id: quiz_id] }
  let(:quiz_repository) { QuizRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:quiz_id) { 1 }
  let(:number_of_words) { 2 }

  before do
    quiz_repository.clear
    quiz = quiz_repository.create(
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 20,
      number_of_words: number_of_words,
      sex_flag: true,
      age_flag: false,
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
    stimulus_repository.clear
    stim1 = stimulus_repository.create(
      stimulus: 'stim1',
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    stim2 = stimulus_repository.create(
      stimulus: 'stim2',
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    stim3 = stimulus_repository.create(
      stimulus: 'stim3',
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    quiz_repository.clear_stimuli_join_table(quiz.id)
    quiz_repository.insert_stimuli_into(quiz.id, [stim1, stim2, stim3])

    @stimuli = [stim1.stimulus, stim2.stimulus, stim3.stimulus]

    ::I18n.locale = :ru
  end

  it 'exposes given number of @stimuli' do
    action.call(params)
    action.stimuli.count.must_equal number_of_words
    action.stimuli.each { |s| @stimuli.must_include s.stimulus }
  end

  describe '[POST]' do
    let(:params) { Hash['REQUEST_METHOD' => 'POST', quiz_id: quiz_id] }

    it ' is successful' do
      response = action.call(params)
      response[0].must_equal 200
    end
  end

  describe '[GET]' do
    let(:params) { Hash['REQUEST_METHOD' => 'GET', quiz_id: quiz_id] }

    it 'reloads if quiz session is present' do
      params['rack.session'] = { "q#{params[:quiz_id]}" => { person_data_validated: true } }

      response = action.call(params)
      response[0].must_equal 200
    end

    it 'redirects to main page if no session is present' do
      response = action.call(params)
      response[0].must_equal 302
    end
  end
end
