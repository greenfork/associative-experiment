require 'spec_helper'
require_relative '../../../../apps/web/views/quiz/person'

describe Web::Views::Quiz::Person do
  let(:exposures) { Hash[
    flags: {
      :sex => true, :age => true, :profession => false, :region => true,
      :residence_place => false, :birth_place => false, :nationality1 => false, :nationality2 => false,
      :spoken_languages => false, :native_language => false, :communication_language => false,
      :education_language => false, :quiz_language_level => false
    },
    params: { quiz_id: 1 },
  ] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/quiz/person.html.erb') }
  let(:view)      { Web::Views::Quiz::Person.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'shows flagged fields' do
    view.flags.each do |flag, value|
      rendered.must_include "person-#{flag}" if value
    end
  end

  it 'hides unflagged fields' do
    view.flags.each do |flag, value|
      rendered.wont_include "person-#{flag}" unless value
    end
  end
end
