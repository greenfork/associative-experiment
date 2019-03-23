require "spec_helper"

describe Admin::Views::ApplicationLayout do
  let(:layout)   { Admin::Views::ApplicationLayout.new({ format: :html }, "contents") }
  let(:rendered) { layout.render }

  it 'contains application name' do
    rendered.must_include('Admin')
  end
end
