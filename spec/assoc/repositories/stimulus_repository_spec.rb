require 'spec_helper'
require 'helper_funcs'

describe StimulusRepository do
  let(:repository) { StimulusRepository.new }
  let(:quiz_id) { 1 }

  before do
    HelperFuncs::Database.new.full_database_setup
  end

  it 'shows stimuli of a specified quiz' do
    repository.get_stimuli_of(quiz_id).count.must_equal 3
    repository.get_stimuli_of(quiz_id)[0].stimulus.must_equal 'stim1'
  end

  it 'shows id of a specified stimulus' do
    repository.find_id('stim1').must_equal 1
    repository.find_id('stim3').must_equal 3
  end
end
