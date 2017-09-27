require 'spec_helper'
require_relative '../../../../apps/web/views/quiz/test'

describe Web::Views::Quiz::Test do
  let(:exposures) { Hash[stimuli: %i[великий дорога камень], params: { quiz_id: 1 }] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/quiz/test.html.erb') }
  let(:view)      { Web::Views::Quiz::Test.new(template, exposures) }
  let(:rendered)  { view.render }

  before do
    I18n.locale = :ru
  end

  it 'renders given stimuli' do
    rendered.scan(/великий/i).count.must_equal 1
    rendered.scan(/дорога/i).count.must_equal 1
    rendered.scan(/камень/i).count.must_equal 1
  end
end
