require 'spec_helper'
require_relative '../../../../apps/research/controllers/analysis/dictionary'
require 'helper_funcs'

describe Research::Controllers::Analysis::Dictionary do
  let(:action) { Research::Controllers::Analysis::Dictionary.new }
  let(:params) { Hash[] }

  before do
    HelperFuncs::Database.new.full_database_setup
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  describe 'with a word provided [POST]' do
    let(:params) {
      Hash[
        dict: {
          word: 'stim1'
        },
        'REQUEST_METHOD' => 'POST'
      ]
    }

    it 'exposes dictionary values' do
      response = action.call(params)
      response[0].must_equal 200
      action.dictionary.must_equal ['reac1' => 1, 'reac1-2' => 1]
    end
  end
end
