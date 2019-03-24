require_relative '../../../spec_helper'

describe Admin::Views::Authentication::Login do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/authentication/login.html.erb') }
  let(:view)      { Admin::Views::Authentication::Login.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
