require 'spec_helper'
require_relative '../../../../apps/research/views/authorization/login'

describe Research::Views::Authorization::Login do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/authorization/login.html.erb') }
  let(:view)      { Research::Views::Authorization::Login.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    skip 'This is an auto-generated test. Edit it and add your own tests.'

    # Example
    view.foo.must_equal exposures.fetch(:foo)
  end
end
