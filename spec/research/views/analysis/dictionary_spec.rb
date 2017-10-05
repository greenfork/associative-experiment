require 'spec_helper'
require_relative '../../../../apps/research/views/analysis/dictionary'

describe Research::Views::Analysis::Dictionary do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/analysis/dictionary.html.erb') }
  let(:view)      { Research::Views::Analysis::Dictionary.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    skip 'This is an auto-generated test. Edit it and add your own tests.'

    # Example
    view.foo.must_equal exposures.fetch(:foo)
  end
end
