# coding: utf-8
require 'spec_helper'
require_relative '../../../lib/thesaurus/comparison/brief.rb'
describe Thesaurus::Comparison::Brief do
  let(:correlation) { Thesaurus::Comparison::Brief.new(
                        dictionary1: dictionary1,
                        dictionary2: dictionary2
                      ) }
  let(:dictionary1) {
    [
      { reaction: 'мемы', count: 56 },
      { reaction: 'are', count: 47 },
      { reaction: 'funtastic', count: 95 },
      { reaction: '!', count: 7 }
    ]
  }
  let(:dictionary2) {
    [
      { reaction: 'no', count: 170 },
      { reaction: 'all', count: 44 },
      { reaction: 'мемы', count: 53 },
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
  end

  it 'outputs brief correctly' do
    @result[:all].must_equal 605
    @result[:all_first].must_equal 205
    @result[:all_second].must_equal 400
    @result[:distinct].must_equal 7
    @result[:same].must_equal 3
    @result[:different].must_equal 4
  end
end
