# frozen_string_literal: true

require 'hanami/interactor'
require 'rubyXL'
require File.join(Hanami.root, 'tools', 'EDI', 'main')

class AddFormsFromExcel
  include Hanami::Interactor

  attr_reader :respondents, :forms

  # `respondents_xlsx` and `forms_xlsx` are StringIO buffers which
  # can be acquired with `File.read` or read from the incoming HTTP
  # request.
  # `respondents_headers` and `forms_headers` are arrays of strings
  # which specify allowed headers of xlsx files. Any header that is
  # not specified in this array will lead to an error.

  def initialize(respondents_xlsx:, respondents_headers:,
                 forms_xlsx:, forms_headers:)
    @respondents = parse_xlsx(respondents_xlsx, respondents_headers)
    @forms_xlsx = parse_xlsx(forms_xlsx, forms_headers)
  end

  # Returns array of 3 elements:
  #
  # 1. Array of stimuli in the provided forms
  # 2. Options of a quiz which are documented in the tools/EDI
  # 3. Array of person hashes which are documented in the tools/EDI

  def call
  end

  private

  # Returns an array of hashes, each key in the hash is header,
  # each value is the corresponding field in the `xlsx_file`
  def parse_xlsx(xlsx_file, headers)
    worksheet = RubyXL::Parser.parse_buffer(xlsx_file)[0]
  end
end
