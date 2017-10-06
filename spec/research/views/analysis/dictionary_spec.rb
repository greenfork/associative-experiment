require 'spec_helper'
require_relative '../../../../apps/research/views/analysis/dictionary'

describe Research::Views::Analysis::Dictionary do
  let(:exposures) { Hash[params: {}, dictionary: nil, brief: nil] }
  let(:template)  { Hanami::View::Template.new('apps/research/templates/analysis/dictionary.html.erb') }
  let(:view)      { Research::Views::Analysis::Dictionary.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'shows selection form' do
    rendered.scan(/name="selection\[word\]"/).count.must_equal 1
    rendered.scan(/name="selection\[type\]"/).count.must_equal 2
    rendered.scan(/name="selection\[sex\]"/).count.must_equal 3
    rendered.scan(/name="selection\[age_from\]"/).count.must_equal 1
    rendered.scan(/name="selection\[age_to\]"/).count.must_equal 1
    rendered.scan(/name="selection\[region\]"/).count.must_equal 1
    rendered.scan(/name="selection\[nationality1\]"/).count.must_equal 1
    rendered.scan(/name="selection\[native_language\]"/).count.must_equal 1
    rendered.scan(/name="selection\[date_from\]"/).count.must_equal 1
    rendered.scan(/name="selection\[date_to\]"/).count.must_equal 1
    rendered.scan(/type="submit"/).count.must_equal 1
  end

  it 'doesnt show summary and dictionary tables' do
    rendered.scan(/id="summary"/).count.must_equal 0
    rendered.scan(/id="dictionary"/).count.must_equal 0
  end

  describe 'with dictionary data supplied' do
    let(:exposures) {
      Hash[
        params: {},
        dictionary: {
          'reac1' => 128,
          'reac2' => 86,
          'reac3' => 18
        },
        brief: {
          total: 232,
          distinct: 3,
          single: 0,
          null: 0
        }
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
    end
  end
end
