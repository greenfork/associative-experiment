require 'spec_helper'
require_relative '../../../../apps/research/controllers/authorization/login'

describe Research::Controllers::Authorization::Login do
  let(:action) { Research::Controllers::Authorization::Login.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
