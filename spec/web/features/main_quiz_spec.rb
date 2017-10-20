require 'features_helper'

def visit_target_page
  visit Web.routes.path(:person, quiz_id)
  choose('person-male')
  find('#submit').click

  find('input').send_keys :enter
  find('input').send_keys :enter
  find('input').send_keys :enter
end

describe 'main quiz' do
  let(:quiz_repository) { QuizRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:quiz_id) { 1 }
  let(:question_id) { 0 }
  let(:number_of_words) { 3 }
  let(:available_time) { 5 }

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

  it 'records time, key logs, reaction' do
    visit_target_page

    div = find('div.question')
    find('input').send_keys 'a', 'b', :enter
    within(div) do
      find("#person-stimuli-#{question_id}-reaction", visible: false).value.must_equal 'ab'
      find("#person-stimuli-#{question_id}-start-time", visible: false).value.wont_be_empty
      find("#person-stimuli-#{question_id}-end-time", visible: false).value.wont_be_empty
      find("#person-stimuli-#{question_id}-key-log", visible: false).value.wont_be_empty
      find("#person-stimuli-#{question_id}-stimulus-id", visible: false).value.wont_be_empty
    end
  end

  it 'changes the input and label upon hitting Enter key' do
    visit_target_page

    input = find('input')
    input.send_keys :enter
    all('input').count.must_equal 1
    input.wont_equal find('input')
  end

  it 'finishes after all the stimuli are submitted' do
    visit_target_page

    number_of_words.times do
      find('input').send_keys :enter
    end
    page.assert_current_path(Web.routes.thanks_path)
  end

  it 'finishes after the time limit was exceeded' do
    visit_target_page

    find('input').send_keys :enter
    sleep available_time + 1
    find('input').send_keys :enter
    page.assert_current_path(Web.routes.thanks_path)
  end
end
