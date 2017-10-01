module Web::Views::Quiz
  class Main
    include Web::View

    def js_main_quiz
      javascript 'main_quiz'
    end

    def insert_backend_data
      html.div do
        div(nil, id: 'quiz-start-time', data: quiz_start_time)
        div(nil, id: 'quiz-time-limit', data: quiz_time_limit)
      end
    end

    def form
      form_for :person, routes.thanks_path , id: 'form' do
        fields_for_collection :stimuli do
          stimulus_info = retrieve_stimulus_info
          div(class: "question form-group#{hidden?}") do
            div(class: 'row') do
              span(
                stimulus_info[:stimulus], class: 'col-sm-4 col-sm-offset-4 text-center',
                style: 'font-size: 20px; margin-bottom: 5px; font-weight: bold;'
              )
            end
            div(class: 'row') do
              div(class: 'col-sm-4 col-sm-offset-4') do
                text_field :reaction, class: 'form-control', autocomplete: 'off'
                hidden_field :start_time, class: 'start-time'
                hidden_field :end_time, class: 'end-time'
                hidden_field :key_log, class: 'key-log'
                hidden_field :stimulus_id, class: 'stimulus-id', value: stimulus_info[:stimulus_id]
              end
            end
          end
        end
        div(class: 'text-center', style: 'font-size: 18px;') do
          span(id: 'current_question') { '1' }
          span "/ #{stimuli.count}"
        end
      end
    end

    private

    def retrieve_stimulus_info
      begin
        {
          stimulus_id: stimuli_enum.peek.id,
          stimulus: stimuli_enum.next.stimulus
        }
      rescue StopIteration
        'iteration_error'
      end
    end

    # fires only once
    def hidden?
      @hidden ||= false
      if !@hidden
        @hidden = true
      else
        output = ' hidden'
      end
      output
    end
  end
end
