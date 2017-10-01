module Web::Controllers::Quiz
  class Thanks
    include Web::Action

    expose :uuid, :quiz_title

    def call(params)
      @uuid = SecureRandom.uuid
      @quiz_title = QuizRepository.new.find(get_from_session(:quiz_id)).title

      PersonRepository.new.create(
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
        total_time: get_from_session(:total_time),
        quiz_id: get_from_session(:quiz_id)
      )
    end

    private

    def get_from_session(key)
      session[:person][key] if session.key?(:person)
    end
  end
end
