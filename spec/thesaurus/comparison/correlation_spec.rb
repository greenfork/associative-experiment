require 'spec_helper'
require_relative '../../../lib/thesaurus/comparison/correlation.rb'
describe Thesaurus::Comparison::Correlation do
  let(:correlation) { Thesaurus::Comparison::Correlation.new(
                        dictionary1: dictionary1,
                        dictionary2: dictionary2
                      ) }
  let(:dictionary1) {
    [
      { reaction: 'memes', count: 56 },
      { reaction: 'are', count: 47 },
      { reaction: 'funtastic', count: 95 },
      { reaction: '!', count: 7 }
    ]
  }
  let(:dictionary2) {
    [
      { reaction: 'no', count: 170 },
      { reaction: 'all', count: 44 },
      { reaction: 'memes', count: 53 },
      { reaction: 'are', count: 13 },
      { reaction: 'dead', count: 44 },
      { reaction: '!', count: 76 }
    ]
  }

  before do
    @result = correlation.call
  end

  it 'exposes right values' do
    correlation.result.wont_be_nil
    correlation.common_reactions.must_equal(
      'memes' => [56, 53],
      'are' => [47, 13],
      '!' => [7, 76]
    )
  end

  it 'outputs correlation correctly' do
    @result[:pearson].must_equal(-0.6588241249624094963977)
    @result[:spearman].must_equal(-0.5)
    @result[:kendall].must_equal(-0.3333333333333333703408)
  end
end
