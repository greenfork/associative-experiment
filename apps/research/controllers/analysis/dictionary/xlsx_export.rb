module Research::Controllers::Analysis
  # Writes given data to xlsx file representation. Use method #xlsx to retrieve
  # string representation of it.
  class XlsxExport
    attr_reader :params, :dictionary, :brief, :xlsx, :quizz_names

    def initialize(params:, dictionary:, brief:, quizz_names:)
      @params = params
      @dictionary = dictionary
      @brief = brief
      @quizz_names = quizz_names
      compose_xlsx
    end

    def compose_xlsx
      workbook = RubyXL::Workbook.new
      @ws = workbook[0]
      write_personal_data
      write_brief
      write_dictionary
      @xlsx = workbook.stream.string
    end

    private

    def write_personal_data
      @ws.add_cell(0, 0, t('.word'))
      @ws.add_cell(0, 1, params[:word])
      @ws.add_cell(2, 0, t('.type'))
      @ws.add_cell(2, 1, t(".#{params[:type]}"))
      @ws.add_cell(3, 0, t('.sex'))
      @ws.add_cell(3, 1, t(".#{params[:sex]}"))
      @ws.add_cell(4, 0, t('.quiz'))
      @ws.add_cell(4, 1, quizz_names[params[:quiz_id]])
      @ws.add_cell(5, 0, t('.age'))
      @ws.add_cell(5, 1, t('.from'))
      @ws.add_cell(5, 2, params[:age_from])
      @ws.add_cell(5, 3, t('.to'))
      @ws.add_cell(5, 4, params[:age_to])
      @ws.add_cell(6, 0, t('.region'))
      @ws.add_cell(6, 1, params[:region])
      @ws.add_cell(7, 0, t('.nationality'))
      @ws.add_cell(7, 1, params[:nationality1])
      @ws.add_cell(8, 0, t('.native-language'))
      @ws.add_cell(8, 1, params[:native_language])
      @ws.add_cell(9, 0, t('.date'))
      @ws.add_cell(9, 1, t('.from'))
      @ws.add_cell(9, 2, params[:date_from])
      @ws.add_cell(9, 3, t('.to'))
      @ws.add_cell(9, 4, params[:date_to])
    end

    def write_brief
      @ws.add_cell(11, 0, t('.total'))
      @ws.add_cell(11, 1, brief[:total])
      @ws.add_cell(12, 0, t('.distinct'))
      @ws.add_cell(12, 1, brief[:distinct])
      @ws.add_cell(12, 2, format('%.2f%',
                                 brief[:distinct].to_f / brief[:total] * 100))
      @ws.add_cell(13, 0, t('.single'))
      @ws.add_cell(13, 1, brief[:single])
      @ws.add_cell(13, 2, format('%.2f%',
                                 brief[:single].to_f / brief[:total] * 100))
      @ws.add_cell(14, 0, t('.nil'))
      @ws.add_cell(14, 1, brief[:null])
      @ws.add_cell(14, 2, format('%.2f%',
                                 brief[:null].to_f / brief[:total] * 100))
    end

    def write_dictionary
      if params[:type] == 'straight'
        word_sym = :reaction
        word_label = t('.reaction')
      elsif params[:type] == 'reversed'
        word_sym = :stimulus
        word_label = t('.stimulus')
      end
      @ws.add_cell(16, 0, word_label)
      @ws.add_cell(16, 1, t('.count'))
      @ws.add_cell(16, 2, t('.percent'))

      row = 17
      dictionary.each do |record|
        @ws.add_cell(row, 0, record[word_sym])
        @ws.add_cell(row, 1, record[:count])
        @ws.add_cell(
          row,
          2,
          (record[:count].to_f / brief[:total] * 100).round(2)
        )
        row += 1
      end
    end

    def t(key, options = {})
      key = "research.analysis.dictionary#{key}"
      ::I18n.t key, options
    end
  end
end
