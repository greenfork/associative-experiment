require 'spec_helper'
require 'helper_funcs'

describe ReactionRepository do
  let(:reaction_repository) { ReactionRepository.new }
  let(:quiz_id) { 1 }

  before do
    HelperFuncs::Database.new.full_database_setup
  end

  it 'queries reactions of the specified stimulus, person and quiz' do
    reaction_repository.get_reactions_of(1, 1, quiz_id).last[:reaction].must_equal 'reac1'
    reaction_repository.get_reactions_of(1, 1).last[:reaction].must_equal 'reac1'
    reaction_repository.get_reactions_of(1).last[:reaction].must_equal 'reac1-2'
    reaction_repository.get_reactions_of(1).to_a.size.must_equal 2
  end

  it 'queries reactions with the following params' do
    # reaction_repository.find_by_params(1).to_h.must_equal ['reac1', 'reac1-2']
  end
end
