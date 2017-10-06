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

      create_person_record
      create_reaction_records
    end

    private

    def get_from_session(key)
      session[:person][key] if session.key?(:person)
    end

    def create_person_record
      @person = PersonRepository.new.create(
        uuid: @uuid,
        sex: get_from_session(:sex),
        age: get_from_session(:age),
        profession: get_from_session(:profession),
        region: get_from_session(:region),
        residence_place: get_from_session(:residence_place),
        birth_place: get_from_session(:birth_place),
        nationality1: get_from_session(:nationality1),
        nationality2: get_from_session(:nationality2),
        spoken_languages: get_from_session(:spoken_languages),
        native_language: get_from_session(:native_language),
        communication_language: get_from_session(:communication_language),
        education_language: get_from_session(:education_language),
        quiz_language_level: get_from_session(:quiz_language_level),
        date: Time.now.to_i,
        is_reviewed: true,
        total_time: Time.now.to_i - session[:quiz_start_time],
        quiz_id: get_from_session(:quiz_id)
      )
    end

    def create_reaction_records
      reaction_list = []
      params[:person][:stimuli].each do |q|
        # check if it is a "null" reaction
        if q['reaction'].to_s.empty?
          reaction = nil
          reaction_time = nil
          keylog = nil
        else
          reaction = q['reaction']
          reaction_time = q['end_time'].to_i - q['start_time'].to_i
          keylog = q['key_log']
        end

        # check if stimulus_id is a valid id
        stimuli = []
        StimulusRepository.new.get_stimuli_of(get_from_session(:quiz_id)).each do |s|
          stimuli << s.id
        end
        if stimuli.include? q['stimulus_id'].to_i
          stimulus_id = q['stimulus_id'].to_i
        else
          stimulus_id = nil
        end

        reaction_list << Hash[
          reaction: reaction,
          reaction_time: reaction_time,
          keylog: keylog,
          person_id: @person.id,
          stimulus_id: stimulus_id,
          quiz_id: get_from_session(:quiz_id)
        ]
      end
      ReactionRepository.new.create_many(reaction_list)
    end
  end
end
