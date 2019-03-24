require_relative '../../../spec_helper'

describe Admin::Views::Forms::Upload do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/forms/upload.html.erb') }
  let(:view)      { Admin::Views::Forms::Upload.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
