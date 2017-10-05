require 'features_helper'
require 'helper_funcs'

describe 'analysis dictionary form' do
  before do
    HelperFuncs::Database.new.full_database_setup
  end

  it 'shows dictionary for a certain word' do
    visit Research.routes.dict_path

    fill_in('dict[word]', with: 'stim1')
    find_button('#submit').click

    within_table('#dictionary') do
      has_text?('reac1')
      has_text?('reac1-2')
    end
  end
end
