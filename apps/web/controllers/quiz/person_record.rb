module Web::Controllers::Quiz
  class PersonRecord
    attr_reader :person, :uuid, :quiz_start_time, :person_record

    def initialize(person, uuid, quiz_start_time)
      @person = person
      @uuid = uuid
      @quiz_start_time = quiz_start_time
      create_record
    end

    def id
      person_record.id
    end

    private

    def create_record
      @person_record = PersonRepository.new.create(
        uuid: uuid,
        sex: person[:sex],
        age: person[:age],
        profession: person[:profession],
        region: person[:region],
        residence_place: person[:residence_place],
        birth_place: person[:birth_place],
        nationality1: person[:nationality1],
        nationality2: person[:nationality2],
        spoken_languages: person[:spoken_languages],
        native_language: person[:native_language],
        communication_language: person[:communication_language],
        education_language: person[:education_language],
        quiz_language_level: person[:quiz_language_level],
        date: Time.now,
        is_reviewed: true,
        total_time: Time.now.to_i - quiz_start_time,
        quiz_id: person[:quiz_id]
      )
    end
  end
end
