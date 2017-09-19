require 'spec_helper'
require_relative '../../../../apps/web/views/home/index'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[quizzes: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes quizzes' do
    view.quizzes.must_equal exposures.fetch(:quizzes)
  end

  describe 'when there are quizzes' do
    let(:quizA) { Quiz.new(id: 1, title: 'QuizA') }
    let(:quizB) { Quiz.new(id: 2, title: 'QuizB') }
    let(:quizC) { Quiz.new(id: 3, title: 'QuizC') }
    let(:exposures) { Hash[quizzes: [quizA, quizB, quizC]] }

    it 'lists all links to quizzes' do
      rendered.scan(%r{href="[\/\d]*person[\/\d]*"}).count.must_equal 3
      rendered.must_include 'QuizA'
      rendered.must_include 'QuizB'
      rendered.must_include 'QuizC'
    end
  end

  describe 'when there are no quizzes' do
    it 'does not output links to quizzes' do
      rendered.wont_match %r{href="[\/\d]*person[\/\d]*"}
    end
  end
end
