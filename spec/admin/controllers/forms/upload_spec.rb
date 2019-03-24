require_relative '../../../spec_helper'

describe Admin::Controllers::Forms::Upload do
  let(:action) { Admin::Controllers::Forms::Upload.new }
  let(:params) { Hash[] }

  it 'is fails with no login' do
    response = action.call(params)
    response[0].must_equal 302
  end
end
