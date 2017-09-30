require 'spec_helper'
require_relative '../../../../apps/web/views/quiz/thanks'

describe Web::Views::Quiz::Thanks do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/quiz/thanks.html.erb') }
  let(:view)      { Web::Views::Quiz::Thanks.new(template, exposures) }
  let(:rendered)  { view.render }
end
