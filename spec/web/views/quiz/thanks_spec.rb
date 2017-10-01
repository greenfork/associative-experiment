require 'spec_helper'
require_relative '../../../../apps/web/views/quiz/thanks'

describe Web::Views::Quiz::Thanks do
  let(:exposures) { Hash[uuid: uuid, quiz_title: quiz_title] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/quiz/thanks.html.erb') }
  let(:view)      { Web::Views::Quiz::Thanks.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:uuid) { SecureRandom.uuid }
  let(:quiz_title) { 'QuizA' }

  it 'shows UUID and quiz_title' do
    rendered.scan(/#{uuid}/).count.must_equal 1
    rendered.scan(/#{quiz_title}/).count.must_equal 1
  end
end
