require 'features_helper'
require 'helper_funcs'

def log_in
  visit '/research/authentication'

  fill_in('user[login]', with: 'admin')
  fill_in('user[password]', with: 'admin')
  find('#submit').click
end

describe 'analysis dictionary form' do
  before do
    HelperFuncs::Database.new.full_database_setup
  end

  it 'shows dictionary and brief for a certain word' do
    log_in
    visit Research.routes.dict_path

    fill_in('selection[word]', with: 'stim1')
    find('#submit').click

    within_table('brief') do
      has_text?('86') # total
      has_text?('3') # null
      has_text?('8') # distinct
      has_text?('1') # single
    end

    within_table('dictionary') do
      has_text?('reac1')
      has_text?('reac1-2')
    end
  end
end
