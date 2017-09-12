require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/main'

describe Web::Controllers::Quiz::Main do
  let(:action) { Web::Controllers::Quiz::Main.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
