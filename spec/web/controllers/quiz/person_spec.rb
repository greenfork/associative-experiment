require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/person'

describe Web::Controllers::Quiz::Person do
  let(:action) { Web::Controllers::Quiz::Person.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
