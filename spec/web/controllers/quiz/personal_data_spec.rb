require 'spec_helper'
require_relative '../../../../apps/web/controllers/quiz/personal_data'

describe Web::Controllers::Quiz::PersonalData do
  let(:action) { Web::Controllers::Quiz::PersonalData.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
