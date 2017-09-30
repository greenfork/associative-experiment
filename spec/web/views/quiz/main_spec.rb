require 'spec_helper'
require_relative '../../../../apps/web/views/quiz/main'

describe Web::Views::Quiz::Main do
  let(:exposures) {
    Hash[
      params: { person: { stimuli: stimuli } },
      stimuli: stimuli,
      stimuli_enum: stimuli.to_enum
    ]
  }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/quiz/main.html.erb') }
  let(:view)      { Web::Views::Quiz::Main.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:stimuli)   {
    [
      Stimulus.new(stimulus: 'stim1'),
      Stimulus.new(stimulus: 'stim2'),
      Stimulus.new(stimulus: 'stim3')
    ]
  }

  it 'has all the reaction inputs' do
    rendered.scan(/id="person-stimuli-\d+-reaction"/).count.must_equal exposures[:stimuli].count
  end

  it 'displays every stimulus label only once' do
    exposures[:stimuli].each { |s| rendered.scan(/#{s.stimulus}/).count.must_equal 1 }
  end

  it 'has no errors during iteration of stimuli in enumerator' do
    rendered.scan(/iteration_error/).count.must_equal 0
  end

  it 'shows only first field, others are hidden' do
    rendered.scan(/class=('|")[a-zA-Z _-]*hidden/).count.must_equal exposures[:stimuli].count - 1
  end
end
