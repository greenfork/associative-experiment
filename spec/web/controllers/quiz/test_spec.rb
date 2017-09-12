require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/test'

describe Web::Controllers::Quiz::Test do
  let(:action) { Web::Controllers::Quiz::Test.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
