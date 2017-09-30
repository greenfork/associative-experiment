require 'spec_helper'

describe QuizRepository do
  let(:quiz_repository) { QuizRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:quiz_id) { 1 }

  before do
    quiz_repository.clear
    quiz_repository.create(
      id: quiz_id,
      title: 'QuizA',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: true,
      available_time: 20,
      number_of_words: 2,
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
      created_at: 1_505_331_469,
      updated_at: 1_505_331_469
    )
    quiz_repository.create(
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: true,
      available_time: 20,
      number_of_words: 100,
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
      created_at: 1_505_331_469,
      updated_at: 1_505_331_469
    )
    quiz_repository.create(
      title: 'QuizC',
      language: 'rus',
      is_active: false,
      is_reviewed_automatically: true,
      available_time: 20,
      number_of_words: 100,
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
      created_at: 1_505_331_469,
      updated_at: 1_505_331_469
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
  end

  it 'queries only active quizzes' do
    quiz_repository.active_quizzes.count.must_equal 2
  end

  it 'lists stimuli of the quiz' do
    stimulus_repository.get_stimuli_of(quiz_id).count.must_equal 3
    stimulus_repository.get_stimuli_of(quiz_id)[0].stimulus.must_equal 'stim1'
  end
end
