require_relative './person_record.rb'
require_relative './reaction_record.rb'

module Web::Controllers::Quiz
  class Thanks
    include Web::Action

    expose :uuid, :quiz_title

    params do
      required(:person).schema do
        required(:stimuli).schema do
          required(:reaction).filled(:str?)
          required(:start_time).filled(:int?)
          required(:end_time).filled(:int?)
          required(:key_log).filled(:str?)
          required(:stimulus_id).filled(:int?)
        end
      end
    end

    def call(params)
      if get_from_session(:quiz_id).nil?
        redirect_to routes.root_path
      end

      @uuid = SecureRandom.uuid
      @quiz_title = QuizRepository.new.find(get_from_session(:quiz_id)).title

      @person =
        PersonRecord.new(session[:person], @uuid, session[:quiz_start_time])
      ReactionRecord.new(params[:person][:stimuli],
                         get_from_session(:quiz_id),
                         @person.id)
    end

    private

    def get_from_session(key)
      session[:person][key] if session.key?(:person)
    end
  end
end
