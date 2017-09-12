require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/thanks'

describe Web::Controllers::Quiz::Thanks do
  let(:action) { Web::Controllers::Quiz::Thanks.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
