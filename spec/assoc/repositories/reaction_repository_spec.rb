require 'spec_helper'
require 'helper_funcs'

HelperFuncs::Database.new.full_database_setup

describe ReactionRepository do
  let(:repository) { ReactionRepository.new }
  let(:quiz_id) { 1 }

  it 'queries reactions of the specified stimulus, person and quiz' do
    repository.get_reactions_of(1, 1, quiz_id).last[:reaction].must_equal 'reac1'
    repository.get_reactions_of(1, 1).last[:reaction].must_equal 'reac1'
    repository.get_reactions_of(1).last[:reaction].must_equal 'reac1-2'
    repository.get_reactions_of(1).to_a.size.must_equal 2
  end

  it 'queries reactions with the following params' do
    result = repository.find_by_params(1).to_a
    ['reac1', 'reac1-2'].must_include result[0].reaction
    ['reac1', 'reac1-2'].must_include result[1].reaction

    result = repository.find_by_params(1, people: { sex: 'male', age: 17..20, profession: 'profession',
      region: 'Moscow', residence_place: 'Moscow', birth_place: 'Moscow', nationality1: 'Russian',
      spoken_languages: 1, native_language: 'Russian', communication_language: 'Russian',
      education_language: 'Russian', quiz_language_level: 'good' }).one!
    result.reaction.must_equal 'reac1'
  end

  it 'inserts multiple records at once' do
    list = [
      {
        reaction: 'reac1',
        person_id: 1,
        stimulus_id: 1,
        quiz_id: quiz_id
      },
      {
        reaction: 'reac1',
        person_id: 1,
        stimulus_id: 1,
        quiz_id: quiz_id
      }
    ]
    result = repository.create_many(list)
    result.count.must_equal 2
  end
end
