module Web::Controllers::Quiz
  class Person
    include Web::Action

    expose :person_attributes

    def call(params)
      @person_attributes = [
        :sex, :age, :profession, :region, :residence_place, :birth_place,
        :nationality1, :nationality2, :spoken_languages, :native_language,
        :communication_language, :education_language, :quiz_language_level
      ]
    end
  end
end
