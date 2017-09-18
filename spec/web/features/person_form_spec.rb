require 'features_helper'

describe 'person form' do
  let(:repository) { QuizRepository.new }
  let(:quiz_id) { 2 }

  before do
    repository.clear
    repository.create(id: quiz_id, title: "QuizB", language: "rus", is_active: true, is_reviewed_automatically: false,
    sex_flag: true, age_flag: true, profession_flag: false, region_flag: true, residence_place_flag: false,
    birth_place_flag: false, nationality1_flag: false, nationality2_flag: false, spoken_languages_flag: false,
    native_language_flag: false, communication_language_flag: false, education_language_flag: false,
    quiz_language_level_flag: false, created_at: 1505331469, updated_at: 1505331469)

    I18n.locale = :ru

    Capybara.current_driver = Capybara.javascript_driver
  end

  after do
    Capybara.current_driver = Capybara.default_driver
  end

  it 'is fully filled and submitted' do
    visit Web.routes.path(:person, quiz_id)

    choose('person-male')
    select('3', from: 'person-age')
    select('Москва', from: 'person-region')
    click_button('submit')
    page.assert_current_path(Web.routes.path(:test, quiz_id))
  end

  it 'is partially filled and submitted' do
    path = Web.routes.path(:person, quiz_id)
    visit path

    select('Москва', from: 'person-region')
    click_button('submit')
    all(".alert").count.must_equal 2
    page.assert_current_path(path)
  end
end
