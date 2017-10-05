require 'spec_helper'
require_relative '../../../../apps/research/controllers/analysis/dictionary'
require 'helper_funcs'

describe Research::Controllers::Analysis::Dictionary do
  let(:action) { Research::Controllers::Analysis::Dictionary.new }
  let(:params) { Hash[] }

  before do
    HelperFuncs::Database.new.full_database_setup
    @user = UserRepository.new.find(1)
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  describe 'with UNauthenticated user' do
    let(:params) {
      Hash[
        selection: {
          word: 'stim1'
        },
        'REQUEST_METHOD' => 'POST'
      ]
    }

    it 'redirects to the login page' do
      response = action.call(params)
      response[0].must_equal 302
    end
  end

  describe 'with authenticated user' do
    describe 'with a word provided [POST]' do
      let(:params) {
        Hash[
          selection: {
            word: 'stim1'
          },
          'REQUEST_METHOD' => 'POST',
          'rack.session' => {
            current_user: @user
          }
        ]
      }

      it 'exposes dictionary values' do
        response = action.call(params)
        response[0].must_equal 200
        action.dictionary.must_equal Hash['reac1' => 1, 'reac1-2' => 1]
      end
    end
  end
end
