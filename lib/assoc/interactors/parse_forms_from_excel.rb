# frozen_string_literal: true

require 'hanami/interactor'
require 'rubyXL'

# Takes excel files and their headers as input and returns
# a bunch of artifacts after parsing it.
class ParseFormsFromExcel
  include Hanami::Interactor

  attr_reader :respondents_xlsx, :respondents_headers,
              :forms_xlsx, :forms_headers

  # * +respondents+ - just parsed respondents_xlsx hash
  # * +forms+ - just parsed forms_xlsx hash
  # * +stimulu+ - array of all stimuli used
  # * +people+ - array of objects which are suitable for consumption
  #   by tools/EDI library
  expose :respondents, :forms, :stimuli, :people

  # `respondents_xlsx` and `forms_xlsx` are StringIO buffers which
  # can be acquired with `File.read` or read from the incoming HTTP
  # request or File objects which can be acquired with `File.open`.
  # `respondents_headers` and `forms_headers` are arrays of strings
  # which specify allowed headers of xlsx files. Any header that is
  # not specified in this array will lead to an error.

  def initialize(respondents_xlsx:, respondents_headers:,
                 forms_xlsx:, forms_headers:)
    @respondents_xlsx = respondents_xlsx
    @respondents_headers = respondents_headers
    @forms_xlsx = forms_xlsx
    @forms_headers = forms_headers
  end

  def call
    @respondents = parse_xlsx(respondents_xlsx, respondents_headers)
    @forms = parse_xlsx(forms_xlsx, forms_headers)
    @stimuli = @forms.map { |f| f['stimulus'] }.uniq
    @people = construct_people(@respondents, @forms)
  end

  private

  def construct_people(respondents, forms)
    people = []
    respondents.each do |respondent|
      people << {
        data: respondent,
        reactions: forms.select { |f| f['person_id'] == respondent['id'] }
      }
    end
    people
  end

  # Returns an array of hashes, each key in the hash is header,
  # each value is the corresponding field in the `xlsx_file`
  def parse_xlsx(xlsx_file, headers)
    worksheet = if xlsx_file.is_a? File
                  RubyXL::Parser.parse(xlsx_file)[0]
                elsif xlsx_file.is_a? String
                  RubyXL::Parser.parse_buffer(xlsx_file)[0]
                end
    base_headers = extract_headers(worksheet[0], headers)
    collect_data(worksheet.drop(1), base_headers)
  end

  def extract_headers(row, headers)
    hash = {}
    row.cells.each do |cell|
      if headers.include?(cell.value)
        hash[cell.value] = nil
      else
        error! "#{cell.value} is not allowed as a header"
      end
    end
    hash
  end

  def collect_data(rows, headers)
    result = []
    rows.each do |row|
      hash = headers.dup
      row.cells.zip(headers).each do |cell, (k, _v)|
        next if cell&.value.nil?

        hash[k] = cell.value
      end
      result << hash
    end
    result
  end

  # rubocop:disable Metrics/MethodLength
  def valid?
    if not_string_or_file? respondents_xlsx
      error! 'respondents_xlsx should be a string '
    elsif not_string_or_file? forms_xlsx
      error! 'forms_xlsx should be a string buffer of an xlsx document'
    elsif not_array_of_strings? respondents_headers
      error! 'respondents_headers should be an array of strings'
    elsif not_array_of_strings? forms_headers
      error! 'forms_headers should be an array of strings'
    else
      true
    end
  end
  # rubocop:enable Metrics/MethodLength

  def not_string_or_file?(obj)
    !(obj.is_a?(String) || obj.is_a?(File))
  end

  def not_array_of_strings?(obj)
    !(obj.is_a?(Array) && obj.all? { |el| el.is_a?(String) })
  end
end
