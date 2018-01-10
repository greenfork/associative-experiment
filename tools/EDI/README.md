# EDI -- Electronic Data interchange
This tool allows to transfer all written data in electronic format to the
database of this project

## Usage

!!IMPORTANT!! The script should load project environment and it is recommended
to use rake task for this purpose `bundle exec rake script`

``` ruby
edi = EDI::Main.new(stimuli: stimuli, quiz_settings: settings, people: people)
edi.persist
```

Stimuli is an array of stimuli, e.g. `%w[life death eternity]`

Settings is an array of flag values corresponding to the columns in the quiz
table in the database, e.g.

``` ruby
Hash[
      id: quiz_id,
      title: 'QuizB',
      language: 'rus',
      is_active: true,
      is_reviewed_automatically: false,
      available_time: 20,
      number_of_words: stimuli_list.size,
      sex_flag: true,
      age_flag: false,
      profession_flag: false,
      region_flag: false,
      residence_place_flag: false,
      birth_place_flag: false,
      nationality1_flag: false,
      nationality2_flag: false,
      spoken_languages_flag: false,
      native_language_flag: false,
      communication_language_flag: false,
      education_language_flag: false,
      quiz_language_level_flag: false,
      created_at: 1_505_331_469, updated_at: 1_505_331_469
    ]
```

People is an array of 'person' hashes which have person's data and associated
reactions with the following structure:

`people[0][:data]` -- hash of flag values corresponding to the columns in the
person table in the database

`people[0][:reactions][0]` -- hash with the required :reaction and
:stimulus keys and optional :translation, :translation_comment keys with
values of a class String

e.g.

``` ruby
[
      {
        data: {
          sex: 'm',
          age: 18,
          profession: 'плотник',
          region: 'Москва'
        },
        reactions: [
          {
            reaction: корова,
            stimulus: молоко,
            translation: 'без перевода',
            translation_comment: 'без комментариев'
          },
          {
            reaction: смола,
            stimulus: дерево
          }
        ]
      },
      {
        data: {
          sex: 'f',
          age: 20,
          profession: 'студентка',
          region: 'Казань'
        },
        reactions: [
          {
            reaction: 'белое',
            stimulus: 'молоко'
          },
          {
            reaction: 'яблоко',
            stimulus: 'облако'
          }
        ]
      }
    ]
```

## Testing
All tests should be run from the project root, not this tool's root.
