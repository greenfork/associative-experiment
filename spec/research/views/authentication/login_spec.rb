require 'spec_helper'
require_relative '../../../../apps/research/views/authentication/login'

describe Research::Views::Authentication::Login do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/authentication/login.html.erb') }
  let(:view)      { Research::Views::Authentication::Login.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    skip 'This is an auto-generated test. Edit it and add your own tests.'

    # Example
    view.foo.must_equal exposures.fetch(:foo)
  end
end
