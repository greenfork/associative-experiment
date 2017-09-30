require 'features_helper'

describe 'test quiz form' do
  let(:repository) { QuizRepository.new }
  let(:quiz_id) { 2 }

  before do
    repository.clear
    repository.create(
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 20,
      number_of_words: 100,
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
    I18n.locale = :ru
    Capybara.current_driver = Capybara.javascript_driver
  end
  after do
    Capybara.current_driver = Capybara.default_driver
  end

  it 'changes the input and label upon hitting Enter key' do
    visit Web.routes.path(:person, quiz_id)
    choose('person-male')
    click_button('submit')

    # inputs change on function next() which is called when Enter is pressed
    all('input').count.must_equal 1
    input = find('input')
    input.send_keys :enter
    all('input').count.must_equal 1
    input.wont_equal find('input')
  end

  it 'successfully passes after 3 consecutively pressed Enter' do
    visit Web.routes.path(:person, quiz_id)
    choose('person-male')
    click_button('submit')

    find('input').send_keys :enter
    find('input').send_keys :enter
    find('input').send_keys :enter
    page.assert_current_path(Web.routes.quiz_path(quiz_id: quiz_id))
  end
end
