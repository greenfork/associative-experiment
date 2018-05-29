require_relative '../../../spec_helper'

describe Research::Controllers::Analysis::Comparison do
  let(:action) { Research::Controllers::Analysis::Comparison.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
