# coding: utf-8

require 'spec_helper'
require_relative '../../../../apps/research/controllers/analysis/stats_dictionary.rb'
require 'support/dictionary_statistics'

describe Research::Controllers::Analysis::Stats::Dictionary do
  let(:dictionary) { Research::Controllers::Analysis::Stats::Dictionary }
  let(:params) { Hash[] }

  before do
    helper = HelperFuncs::DictionaryStatistics.new
    @reactions = helper.reactions
    @expected_dictionary = helper.expected_dictionary
  end

  describe 'statistics algorithm' do
    it 'works with a given set of reactions' do
      stats = dictionary.new(@reactions)
      stats.dictionary.must_equal @expected_dictionary
    end
  end
end
