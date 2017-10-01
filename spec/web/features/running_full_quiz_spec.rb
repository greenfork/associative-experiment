require 'features_helper'

describe 'running full quiz' do
  let(:quiz_repository) { QuizRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:quiz_id) { 1 }
  let(:number_of_words) { 2 }
  let(:available_time) { 20 }

  before do
    quiz_repository.clear
    quiz_repository.create(
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: available_time,
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
    quiz_repository.clear_stimuli_join_table(quiz_id)
    quiz_repository.insert_stimuli_into(quiz_id, [stim1, stim2, stim3])

    I18n.locale = :ru
    Capybara.current_driver = Capybara.javascript_driver
  end
  after do
    Capybara.current_driver = Capybara.default_driver
  end

  it 'successfully passes and outputs UUID' do
    visit Web.routes.path(:person, quiz_id)
    choose('person-male')
    click_button('submit')

    find('input').send_keys :enter
    find('input').send_keys :enter
    find('input').send_keys :enter

    number_of_words.times do
      find('input').send_keys :enter
    end

    find('#uuid').text.wont_be_empty
  end
end
