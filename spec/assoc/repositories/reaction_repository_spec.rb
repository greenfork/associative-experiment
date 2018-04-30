require 'spec_helper'
require 'helper_funcs'

describe ReactionRepository do
  let(:repository) { ReactionRepository.new }
  let(:quiz_id) { 1 }

  before do
    HelperFuncs::Database.new.full_database_setup
  end

  it 'queries reactions of the specified stimulus, person and quiz' do
    repository.get_reactions_of(1, 1, quiz_id).last[:reaction].must_equal 'reac1'
    repository.get_reactions_of(1, 1).last[:reaction].must_equal 'reac1'
    repository.get_reactions_of(1).last[:reaction].must_equal 'reac1-2'
    repository.get_reactions_of(1).to_a.size.must_equal 2
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

  describe ReactionRepository.new.get_dictionary do
    before do
      HelperFuncs::Database.new.fill_with_reactions
    end

    it 'shows selection of type straight' do
      result = repository.get_dictionary(type: :straight)
      result[0].reaction.must_equal 'reac1'
      result[0].stimulus.must_equal 'stim1'
      result[0].pair_count.must_equal 22
      result.last.reaction.must_equal 'reac3-2'
      result.last.stimulus.must_equal 'stim3'
      result.last.pair_count.must_equal 1
    end

    it 'shows selection of type reversed' do
      result = repository.get_dictionary(type: :reversed)
      result[0].reaction.must_be_nil
      result[0].stimulus.must_equal 'stim1'
      result[0].pair_count.must_equal 3
      result.last.reaction.must_equal 'reac6'
      result.last.stimulus.must_equal 'stim1'
      result.last.pair_count.must_equal 10
    end

    it 'shows selection of type incidence' do
      result = repository.get_dictionary(type: :incidence)
      result[0].reaction.must_be_nil
      result[0].stimulus.must_equal 'stim1'
      result[0].pair_count.must_equal 3
      result.last.reaction.must_equal 'reac3-2'
      result.last.stimulus.must_equal 'stim3'
      result.last.pair_count.must_equal 1
    end

    def assert_reactions_belong_to_person1(result)
      result[0].reaction.must_equal 'reac1'
      result[0].stimulus.must_equal 'stim1'
      result[0].pair_count.must_equal 22
      result.map(&:reaction).wont_include 'reac1-2'
      result.map(&:reaction).wont_include 'reac2-2'
      result.map(&:reaction).wont_include 'reac3-2'
    end

    it 'shows selection according to sex' do
      result = repository.get_dictionary(
        options: { reactions: {}, people: { sex: 'male' } }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection according to nationality' do
      result = repository.get_dictionary(
        options: { reactions: {}, people: { nationality1: 'Russian' } }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection according to quiz id' do
      result = repository.get_dictionary(
        options: { reactions: { quiz_id: 1 }, people: {} }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection according to region' do
      result = repository.get_dictionary(
        options: { reactions: {}, people: { region: 'Moscow' } }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection according to native_language' do
      result = repository.get_dictionary(
        options: { reactions: {}, people: { native_language: 'Russian' } }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection according to age' do
      result = repository.get_dictionary(
        options: { reactions: {}, people: { age_from: '18' } }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection according to date' do
      result = repository.get_dictionary(
        options: { reactions: {}, people: { date_to: Time.new(2018, 1, 4) } }
      )
      assert_reactions_belong_to_person1(result)
    end

    it 'shows selection for one stimulus' do
      result = repository.get_dictionary(word_list: ['stim1'])
      result[0].reaction.must_equal 'reac1'
      result[0].stimulus.must_equal 'stim1'
      result[0].pair_count.must_equal 22
      result.map(&:stimulus).wont_include 'stim2'
      result.map(&:stimulus).wont_include 'stim3'
    end

    it 'shows selection for a list of stimuli' do
      result = repository.get_dictionary(word_list: ['stim2', 'stim3'])
      result[0].reaction.must_equal 'reac2'
      result[0].stimulus.must_equal 'stim2'
      result[0].pair_count.must_equal 1
      result.map(&:stimulus).wont_include 'stim1'
    end

    it 'shows selection for one reaction' do
      result = repository.get_dictionary(
        options: { reactions: { reaction: 'reac2' }, people: {} }
      )
      result[0].reaction.must_equal 'reac2'
      result[0].stimulus.must_equal 'stim1'
      result[0].pair_count.must_equal 18
      result.map(&:reaction).uniq.must_equal ['reac2']
    end
  end
end
