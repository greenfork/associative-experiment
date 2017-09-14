require 'spec_helper'

describe Web.routes do
  it 'homepage is home/index' do
    home_path = Web.routes.root_path
    home_path.must_equal '/'
  end
end
