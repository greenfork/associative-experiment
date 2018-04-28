# coding: utf-8

require 'spec_helper'
require_relative '../../../../apps/research/controllers/analysis/dictionary/stats_dictionary.rb'
require 'support/dictionary_statistics'

describe Research::Controllers::Analysis::Stats::Dictionary do
  let(:dictionary) { Research::Controllers::Analysis::Stats::Dictionary }
  let(:params) { Hash[] }

  before do
    helper = HelperFuncs::DictionaryStatistics.new
    @reactions = helper.reactions2
    @expected_dictionary = helper.expected_dictionary2
  end

  it 'works with a given set of reactions' do
    repository = ReactionRepository.new
    repository.stub :get_dictionary, @reactions do
      stats = dictionary.new(options: {}, repository: repository)
      stats.dictionary.must_equal @expected_dictionary
    end
  end
end
