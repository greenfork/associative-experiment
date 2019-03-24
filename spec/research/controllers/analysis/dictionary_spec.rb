# coding: utf-8
require 'spec_helper'
require_relative '../../../../apps/research/controllers/analysis/dictionary'
require 'helper_funcs'

describe Research::Controllers::Analysis::Dictionary do
  let(:action) { Research::Controllers::Analysis::Dictionary.new }
  let(:params) { Hash[] }

  before do
    HelperFuncs::Database.new.full_database_setup
    HelperFuncs::Database.new.fill_with_reactions
    @user = HelperFuncs::Authentication.new.admin
  end

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
    action.params.errors.must_equal Hash.new
  end

  it 'exposes possible values for form inputs' do
    action.call(params)
    action.exposures.keys.must_include :stimuli
    action.exposures.keys.must_include :quizzes
    action.exposures.keys.must_include :nationalities
    action.exposures.keys.must_include :regions
    action.exposures.keys.must_include :native_languages
    action.exposures.keys.must_include :with_translation
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
            word: 'stim1',
            type: 'straight',
            output: 'html',
            translation: false
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
        action.dictionary[0].keys.must_include :reaction
      end

      it 'exposes brief values' do
        response = action.call(params)
        response[0].must_equal 200
        action.brief.keys.must_include :total
      end
    end

    describe 'with full list of parameters' do
      let(:params) {
        Hash[
          selection: {
            word: 'stim1',
            type: 'straight',
            output: 'html',
            translation: false,
            sex: 'all',
            age_from: 1,
            age_to: 100,
            region: 'Москва',
            nationality1: 'Russian',
            native_language: 'русский'
          },
          'REQUEST_METHOD' => 'POST',
          'rack.session' => {
            current_user: @user
          }
        ]
      }

      it 'exposes dictionary and brief' do
        response = action.call(params)
        response[0].must_equal 200
        action.exposures[:dictionary].wont_be_nil
        action.exposures[:brief].wont_be_nil
      end
    end

    describe 'with a word provided [POST], request for xlsx document' do
      let(:params) {
        Hash[
          selection: {
            word: 'stim1',
            type: 'straight',
            output: 'xlsx',
            translation: false
          },
          'REQUEST_METHOD' => 'POST',
          'rack.session' => {
            current_user: @user
          }
        ]
      }
      let(:quizz_names) { Hash[] }

      it 'offers xlsx file for download' do
        response = action.call(params)
        response[0].must_equal 200
        response[1]['Content-Type'].must_equal(
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
        response[1]['Content-Disposition'].must_equal(
          "attachment; filename=#{params[:selection][:word]}.xlsx"
        )
      end
    end
  end
end
