require_relative '../../../spec_helper'

describe Research::Views::Analysis::Comparison do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/analysis/comparison.html.erb') }
  let(:view)      { Research::Views::Analysis::Comparison.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
