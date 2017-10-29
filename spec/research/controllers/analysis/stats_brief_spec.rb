# coding: utf-8

require 'spec_helper'
require_relative '../../../../apps/research/controllers/analysis/stats_brief.rb'
require 'support/dictionary_statistics'

describe Research::Controllers::Analysis::Stats::Brief do
  let(:brief) { Research::Controllers::Analysis::Stats::Brief }
  let(:params) { Hash[] }

  before do
    helper = HelperFuncs::DictionaryStatistics.new
    @expected_dictionary = helper.expected_dictionary
    @expected_brief = helper.expected_brief
  end

  describe 'statistics algorithm' do
    it 'works with a given set of reactions' do
      stats = brief.new(@expected_dictionary)
      stats.brief.must_equal @expected_brief
    end
  end
end
