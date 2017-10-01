require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/thanks'

describe Web::Controllers::Quiz::Thanks do
  let(:action) { Web::Controllers::Quiz::Thanks.new }
  let(:params) {
    Hash[
      'rack.session' => {
        person: {
          sex: 'male',
          age: 21,
          quiz_id: quiz_id
        },
        quiz_start_time: 1_506_247_198
      },
      person: {
        stimuli: [
          {
            'reaction' => '4elovek',
            'start_time' => 1_506_247_198,
            'end_time' => 1_506_247_200,
            'key_log' => '[{"key":"s","timestamp":1506857565356},{"key":"d","timestamp":1506857565380}]',
            'stimulus_id' => 1
          },
          {
            'reaction' => 'lud',
            'start_time' => 1_506_247_201,
            'end_time' => 1_506_247_205,
            'key_log' => '[{"key":"t","timestamp":1506857565356},{"key":"a","timestamp":1506857565380}]',
            'stimulus_id' => 2
          },
          {
            'reaction' => 'clovek',
            'start_time' => 1_506_247_208,
            'end_time' => 1_506_247_215,
            'key_log' => '[{"key":"u","timestamp":1506857565356}]',
            'stimulus_id' => 3
          }
        ]
      }
    ]
  }
  let(:person_repository) { PersonRepository.new }
  let(:quiz_repository) { QuizRepository.new }
  let(:stimulus_repository) { StimulusRepository.new }
  let(:reaction_repository) { ReactionRepository.new }
  let(:quiz_id) { 1 }
  let(:quiz_title) { 'QuizA' }
  let(:number_of_words) { 3 }

  before do
    quiz_repository.clear
    quiz_repository.create(
      id: quiz_id,
      title: quiz_title,
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 300,
      number_of_words: number_of_words,
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
    person_repository.clear
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
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes UUID and quiz_title' do
    action.call(params)
    action.uuid.wont_be_empty
    action.quiz_title.must_equal quiz_title
  end

  it 'writes right data into DB about respondent' do
    action.call(params)
    person = person_repository.last

    person.sex.must_equal 'male'
    person.age.must_equal 21
    person.profession.must_be_nil
    person.region.must_be_nil
    person.residence_place.must_be_nil
    person.birth_place.must_be_nil
    person.nationality1.must_be_nil
    person.nationality2.must_be_nil
    person.spoken_languages.must_be_nil
    person.native_language.must_be_nil
    person.communication_language.must_be_nil
    person.education_language.must_be_nil
    person.quiz_language_level.must_be_nil

    person.uuid.must_equal action.uuid
    person.date.must_be_kind_of Time
    [true, false].must_include person.is_reviewed
    person.total_time.must_be_kind_of Integer
    person.quiz_id.must_equal quiz_id
  end

  it 'writes right data into DB about reactions' do
    action.call(params)

    (1..number_of_words).each do |index|
      stimulus = stimulus_repository.find(index)
      stimulus.wont_be_nil

      reaction = reaction_repository.get_reactions_of(index).last
      case index
      when 1
        reaction[:reaction].must_equal '4elovek'
        reaction[:reaction_time].must_equal 1_506_247_200 - 1_506_247_198
        reaction[:keylog].must_equal '[{"key":"s","timestamp":1506857565356},{"key":"d","timestamp":1506857565380}]'
        reaction[:stimulus_id].must_equal 1
      when 2
        reaction[:reaction].must_equal 'lud'
      when 3
        reaction[:reaction].must_equal 'clovek'
      end
    end
  end
end
