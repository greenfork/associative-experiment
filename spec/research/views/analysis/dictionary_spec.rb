# coding: utf-8
require 'spec_helper'
require_relative '../../../../apps/research/views/analysis/dictionary'
require 'helper_funcs'

describe Research::Views::Analysis::Dictionary do
  let(:exposures) { Hash[params: params, dictionary: nil, brief: nil, stimuli: [], quizzes: [], nationalities: [], regions: [], native_languages: [], with_translation: nil, selection: nil] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/analysis/dictionary.html.erb') }
  let(:view)      { Research::Views::Analysis::Dictionary.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:params)    { HelperFuncs::Pampam.new(selection: {}) }

  before do
    ::I18n.locale = :ru
  end

  it 'shows selection form' do
    rendered.scan(/name="selection\[word\]"/).count.must_equal 1
    rendered.scan(/name="selection\[type\]"/).count.must_equal 2
    rendered.scan(/name="selection\[sex\]"/).count.must_equal 3
    rendered.scan(/name="selection\[age_from\]"/).count.must_equal 1
    rendered.scan(/name="selection\[age_to\]"/).count.must_equal 1
    rendered.scan(/name="selection\[quiz_id\]"/).count.must_equal 1
    rendered.scan(/name="selection\[region\]"/).count.must_equal 1
    rendered.scan(/name="selection\[nationality1\]"/).count.must_equal 1
    rendered.scan(/name="selection\[native_language\]"/).count.must_equal 1
    rendered.scan(/name="selection\[date_from\]"/).count.must_equal 1
    rendered.scan(/name="selection\[date_to\]"/).count.must_equal 1
    rendered.scan(/type="submit"/).count.must_equal 1
    rendered.scan(/id="xlsx-export"/).count.must_equal 1
    rendered.scan(/name="selection\[output\]"/).count.must_equal 1
  end

  it 'doesnt show summary and dictionary tables' do
    rendered.scan(/id="summary"/).count.must_equal 0
    rendered.scan(/id="dictionary"/).count.must_equal 0
  end

  describe 'with dictionary data supplied' do
    let(:exposures) {
      Hash[
        params: params,
        dictionary: [
          { reaction: 'reac1', count: 128 },
          { reaction: 'reac2', count: 86 },
          { reaction: 'reac3', count: 18 }
        ],
        brief: {
          total: 232,
          distinct: 3,
          single: 0,
          null: 0
        },
        stimuli: [], quizzes: [], nationalities: [], regions: [], native_languages: [], with_translation: true, selection: nil,
        type: :straight
      ]
    }

    it 'displays summary table' do
      rendered.scan(/id="brief"/).count.must_equal 1
      rendered.scan(/\b232\b/).count.must_equal 1
    end

    it 'displays dictionary table' do
      rendered.scan(/id="dictionary"/).count.must_equal 1
      rendered.scan(/reac1/).count.must_equal 1
      rendered.scan(/reac2/).count.must_equal 1
      rendered.scan(/reac3/).count.must_equal 1
      rendered.scan(/\b18\b/).count.must_equal 1
      rendered.scan(/\b86\b/).count.must_equal 1
      rendered.scan(/\b128\b/).count.must_equal 1
      rendered.scan(/\bРеакция\b/).count.must_equal 1
      rendered.scan(/\bКоличество\b/).count.must_equal 1
      rendered.scan(/\bПроцент\b/).count.must_equal 1
    end
  end

  describe 'with errors present' do
    let(:exposures) { Hash[params: params, dictionary: nil, brief: nil, stimuli: [], quizzes: [], nationalities: [], regions: [], native_languages: [], with_translation: false, selection: nil] }
    let(:params) do
      pampam = HelperFuncs::Pampam.new(selection: {})
      pampam[:selection][:word] = 'abc'
      pampam.errors[:word] = ['msg']
      pampam.errors[:selection] = {}
      pampam.errors[:selection][:age_from] = ['msg']
      pampam.errors[:selection][:date_to] = ['msg']
      pampam.errors[:selection][:type] = ['msg']
      pampam
    end

    it 'shows error' do
      view.selection_form.to_s.scan(/\balert-danger\b/).count.must_equal 3
    end
  end
end
