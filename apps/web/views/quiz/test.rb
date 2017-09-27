module Web::Views::Quiz
  class Test
    include Web::View

    def js_test_quiz
      javascript 'test_quiz'
    end

    def form
      form_for :test, routes.quiz_path(quiz_id: params[:quiz_id]),
               id: 'form', class: 'form-horizontal' do
        # stimuli exposed in controller
        stimuli.each_with_index do |s, i|
          hidden =  if i == 0
                      ''
                    else
                      ' hidden'
                    end
          div(class: "qdiv#{i} question form-group#{hidden}") do
            div(class: 'row') do
              span(
                s, class: 'col-sm-4 col-sm-offset-4 text-center',
                style: 'font-size: 20px; margin-bottom: 5px;'
              )
            end
            div(class: 'row') do
              div(class: 'col-sm-4 col-sm-offset-4') do
                html.input(
                  class: 'form-control', id: "qinp#{i}",
                  autocomplete: 'off', type: 'text', name: 'q[]'
                )
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
  end
end
