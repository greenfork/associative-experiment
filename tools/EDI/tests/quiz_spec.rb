require_relative 'spec_helper.rb'
require_relative '../quiz.rb'

describe EDI::Quiz do
  let(:quiz_id) { 1 }
  let(:settings) do
    Hash[
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 20,
      number_of_words: stimuli_list.size,
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
    ]
  end
  let(:stimuli_list) do
    [
      { stimulus: 'apple', translation: 'yabloko' },
      { stimulus: 'peach', translation: 'persik' },
      { stimulus: 'grapefruit', translation: nil },
      { stimulus: 'banana', translation: 'banan' }
    ]
  end
  let(:stimulus_repository) { StimulusRepository.new }
  let(:quiz_repository) { QuizRepository.new }

  before do
    quiz_repository.clear
    @quiz = EDI::Quiz.new(settings: settings, stimuli_list: stimuli_list)
    stimulus_repository.clear
    stimulus_repository.create(stimulus: stimuli_list[0][:stimulus],
                               translation: stimuli_list[0][:translation],
                               created_at: Time.now,
                               updated_at: Time.now)
    @expected_quiz = Quiz.new(
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 20,
      number_of_words: stimuli_list.size,
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
  end

  it 'returns quiz object' do
    @quiz.quiz.must_equal @expected_quiz
    @quiz.id.must_equal quiz_id
  end

  it 'yields missing stimuli' do
    @quiz.missing_stimuli do |s|
      s = { stimulus: s.stimulus, translation: s.translation }
      stimuli_list[1..-1].must_include s
    end
  end

  it 'throws exception if stimuli are missing' do
    -> { @quiz.bind_stimuli }.must_raise EDI::Quiz::MissingStimuliException
  end

  it 'binds stimuli to the current quiz via join table' do
    @quiz.missing_stimuli do |s|
      stimulus_repository.create(
        stimulus: s.stimulus,
        translation: s.translation
      )
    end
    @quiz.bind_stimuli
    stim = stimulus_repository.get_stimuli_of(quiz_id)
    stim.wont_be_empty
    stim.each do |s|
      stimuli_list.must_include(
        stimulus: s.stimulus,
        translation: s.translation
      )
    end
  end
end
