require 'spec_helper'
require_relative '../../../../apps/research/views/authentication/login'

describe Research::Views::Authentication::Login do
  let(:exposures) { Hash[params: {}, error: nil] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/authentication/login.html.erb') }
  let(:view)      { Research::Views::Authentication::Login.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'shows login form' do
    rendered.scan(/name="user\[login\]"/).count.must_equal 1
    rendered.scan(/name="user\[password\]"/).count.must_equal 1
  end

  describe 'with error present' do
    let(:exposures) { Hash[params: {}, error: true] }

    it 'shows error' do
      rendered.scan(/class=('|")\balert\b/).count.must_be :>, 0
    end
  end
end
