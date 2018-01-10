# coding: utf-8
module HelperFuncs
  class DictionaryStatistics
    attr_reader :person, :reaction1, :reaction2, :reaction3

    def initialize
      @person = Person.new(
        id: 1,
        uuid: '284e7435-2ff7-4586-9a48-b60cef231bb0',
        sex: 'male',
        age: 18,
        profession: nil,
        region: 'Москва',
        residence_place: nil,
        birth_place: nil,
        nationality1: 'русский',
        nationality2: nil,
        spoken_languages: nil,
        native_language: 'бурятский',
        communication_language: nil,
        education_language: nil,
        quiz_language_level: nil,
        date: '2017-10-24 15:53:00 UTC',
        is_reviewed: false,
        total_time: nil,
        quiz_id: 2,
        created_at: '2017-10-24 15:53:00 UTC',
        updated_at: '2017-10-24 15:53:00 UTC'
      )
      @reaction1 = Reaction.new(
        id: 1,
        reaction: 'reac1',
        translation: nil,
        translation_comment: nil,
        reaction_time: nil,
        keylog: nil,
        person_id: 1,
        stimulus_id: 1,
        quiz_id: 1,
        created_at: '2017-10-24 15:53:00 UTC',
        updated_at: '2017-10-24 15:53:00 UTC',
        person: @person
      )
      @reaction2 = Reaction.new(
        id: 2,
        reaction: 'reac2',
        person_id: 1,
        stimulus_id: 1,
        quiz_id: 1,
        person: @person
      )
      @reaction3 = Reaction.new(
        id: 3,
        reaction: 'reac3',
        person_id: 1,
        stimulus_id: 1,
        quiz_id: 1,
        person: @person
      )
    end

    def reactions
      [reaction1, reaction2, reaction3, reaction3]
    end

    def expected_dictionary
      [
        { reaction: 'reac3', count: 2,
          translation: nil, translation_comment: nil },
        { reaction: 'reac1', count: 1,
          translation: nil, translation_comment: nil },
        { reaction: 'reac2', count: 1,
          translation: nil, translation_comment: nil }
      ]
    end

    def expected_brief
      { total: 4, distinct: 3, single: 2, null: 0 }
    end
  end
end
