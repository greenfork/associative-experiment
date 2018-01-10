# coding: utf-8
require_relative 'spec_helper.rb'
require_relative '../main.rb'

describe EDI::Main do
  let(:main) { EDI::Main }
  let(:quiz_id) { 1 }
  let(:settings) {
    Hash[
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 20,
      number_of_words: 4,
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
  }
  let(:stimuli_list) { %w[молоко дерево облако] }
  let(:reaction_list) { %w[корова смола белое яблоко] }
  let(:people) {
    [
      {
        data: {
          sex: male,
          age: 18,
          profession: 'plotnik',
          region: 'Москва'
        },
        reactions: [
          {
            reaction: reaction_list[0],
            stimulus: stimuli_list[0],
            translation: 'без перевода',
            translation_comment: 'без комментариев'
          },
          {
            reaction: reaction_list[1],
            stimulus: stimuli_list[1]
          }
        ]
      },
      {
        data: {
          sex: female,
          age: age20,
          profession: professionStudentka,
          region: regionKazan
        },
        reactions: [
          {
            reaction: reaction_list[2],
            stimulus: stimuli_list[0]
          },
          {
            reaction: reaction_list[3],
            stimulus: stimuli_list[2]
          }
        ]
      }
    ]
  }
  let(:person_repository) { PersonRepository.new }
  let(:reaction_repository) { ReactionRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:quiz_repository) { QuizRepository.new }
  let(:male) { 'm' }
  let(:female) { 'f' }
  let(:age20) { 20 }
  let(:regionKazan) { 'Казань' }
  let(:professionStudentka) { 'студентка' }

  before do
    quiz_repository.clear
    person_repository.clear
    stimulus_repository.clear
    reaction_repository.clear
    @main = main.new(stimuli: stimuli_list,
                     quiz_settings: settings,
                     people: people)
  end

  it 'exists' do
    @main.stimuli_array.must_equal stimuli_list
    @main.quiz_settings.must_equal settings
    @main.people.must_equal people
  end

  it 'persists person data to the database' do
    @main.persist
    person_repository.first.sex.must_equal male
    person_repository.last.sex.must_equal female
    person_repository.last.region.must_equal regionKazan
    person_repository.last.profession.must_equal professionStudentka
    person_repository.last.age.must_equal age20
  end

  it 'persists reaction data to the database' do
    @main.persist

    reaction = reaction_repository.all[0]
    reaction.reaction.must_equal reaction_list[0]
    person_id = person_repository.first.id
    reaction.person_id.must_equal person_id
    reaction.quiz_id.must_equal quiz_id
    stimulus_id = stimulus_repository.find_id(stimuli_list[0])
    reaction.stimulus_id.must_equal stimulus_id

    reaction = reaction_repository.all[1]
    reaction.reaction.must_equal reaction_list[1]
    person_id = person_repository.first.id
    reaction.person_id.must_equal person_id
    reaction.quiz_id.must_equal quiz_id
    stimulus_id = stimulus_repository.find_id(stimuli_list[1])
    reaction.stimulus_id.must_equal stimulus_id

    reaction = reaction_repository.all[2]
    reaction.reaction.must_equal reaction_list[2]
    person_id = person_repository.last.id
    reaction.person_id.must_equal person_id
    reaction.quiz_id.must_equal quiz_id
    stimulus_id = stimulus_repository.find_id(stimuli_list[0])
    reaction.stimulus_id.must_equal stimulus_id

    reaction = reaction_repository.all[3]
    reaction.reaction.must_equal reaction_list[3]
    person_id = person_repository.last.id
    reaction.person_id.must_equal person_id
    reaction.quiz_id.must_equal quiz_id
    stimulus_id = stimulus_repository.find_id(stimuli_list[2])
    reaction.stimulus_id.must_equal stimulus_id
  end
end
