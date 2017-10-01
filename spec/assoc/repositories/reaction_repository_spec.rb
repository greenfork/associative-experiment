require 'spec_helper'

describe ReactionRepository do
  let(:quiz_repository) { QuizRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:person_repository) { PersonRepository.new }
  let(:reaction_repository) { ReactionRepository.new }
  let(:quiz_id) { 1 }

  before do
    quiz_repository.clear
    quiz_repository.create(
      id: quiz_id,
      title: 'QuizA',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 300,
      number_of_words: 3,
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
    stimulus_repository.clear
    stim1 = stimulus_repository.create(
      id: 1,
      stimulus: 'stim1',
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    stim2 = stimulus_repository.create(
      id: 2,
      stimulus: 'stim2',
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    stim3 = stimulus_repository.create(
      id: 3,
      stimulus: 'stim3',
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    )
    quiz_repository.clear_stimuli_join_table(quiz_id)
    quiz_repository.insert_stimuli_into(quiz_id, [stim1, stim2, stim3])
    person_repository.clear
    person_repository.create(
      id: 1,
      uuid: SecureRandom.uuid,
      date: Time.now.to_i,
      is_reviewed: true,
      total_time: Time.now.to_i,
      quiz_id: quiz_id
    )
    reaction_repository.clear
    reaction_repository.create(
      reaction: 'reac1',
      person_id: 1,
      stimulus_id: 1,
      quiz_id: quiz_id
    )
    reaction_repository.create(
      reaction: 'reac2',
      person_id: 1,
      stimulus_id: 2,
      quiz_id: quiz_id
    )
    reaction_repository.create(
      reaction: 'reac3-1',
      person_id: 1,
      stimulus_id: 3,
      quiz_id: quiz_id
    )
    reaction_repository.create(
      reaction: 'reac3-2',
      person_id: 1,
      stimulus_id: 3,
      quiz_id: quiz_id
    )
  end

  it 'queries reaction of the specified stimulus, person and quiz' do
    reaction_repository.get_reactions_of(1, 1, quiz_id).last[:reaction].must_equal 'reac1'
    reaction_repository.get_reactions_of(1, 1).last[:reaction].must_equal 'reac1'
    reaction_repository.get_reactions_of(1).last[:reaction].must_equal 'reac1'
    reaction_repository.get_reactions_of(3).to_a.size.must_equal 2
  end
end
