require 'features_helper'

def quiz_hash(id = 1, is_active = true, title = 'QuizA')
  Hash[
    id: id,
    title: title,
    language: 'rus',
    is_active: is_active,
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
  ]
end

describe 'list quizzes' do
  let(:repository) { QuizRepository.new }
  before do
    repository.clear
    repository.create(quiz_hash(1))
    repository.create(quiz_hash(2, true, 'QuizB'))
    repository.create(quiz_hash(3, false, 'QuizC'))
  end

  it 'lists active quizzes' do
    visit '/'

    within '#quizzes' do
      all('a').size.must_equal 2
    end
  end

  it 'links to the next page' do
    visit '/'

    within '#quizzes' do
      click_link('QuizA')
      current_path = Web.routes.path(:person, 1)
      page.assert_current_path(current_path)
    end
  end
end
