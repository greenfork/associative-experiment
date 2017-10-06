module HelperFuncs
  class Database
    def full_database_setup
      quiz_repository = QuizRepository.new
      stimulus_repository = StimulusRepository.new
      person_repository = PersonRepository.new
      reaction_repository = ReactionRepository.new
      user_repository = UserRepository.new
      quiz_id = 1

      quiz_repository.clear
      quiz_repository.create(
        id: quiz_id,
        title: 'QuizA',
        language: 'rus',
        is_active: true,
        is_reviewed_automatically: false,
        available_time: 300,
        number_of_words: 3,
        sex_flag: true,
        age_flag: true,
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
        quiz_language_level_flag: false
      )
      stimulus_repository.clear
      stim1 = stimulus_repository.create(
        id: 1,
        stimulus: 'stim1'
      )
      stim2 = stimulus_repository.create(
        id: 2,
        stimulus: 'stim2'
      )
      stim3 = stimulus_repository.create(
        id: 3,
        stimulus: 'stim3'
      )
      quiz_repository.clear_stimuli_join_table(quiz_id)
      quiz_repository.insert_stimuli_into(quiz_id, [stim1, stim2, stim3])
      person_repository.clear
      person_repository.create(
        id: 1,
        uuid: SecureRandom.uuid,
        date: Time.now.to_i,
        is_reviewed: true,
        total_time: Time.now.to_i,
        quiz_id: quiz_id,
        # attributes
        sex: 'male',
        age: 18,
        profession: 'profession',
        region: 'Moscow',
        residence_place: 'Moscow',
        birth_place: 'Moscow',
        nationality1: 'Russian',
        nationality2: nil,
        spoken_languages: 1,
        native_language: 'Russian',
        communication_language: 'Russian',
        education_language: 'Russian',
        quiz_language_level: 'good'
      )
      person_repository.create(
        id: 2,
        uuid: SecureRandom.uuid,
        date: Time.now.to_i,
        is_reviewed: false,
        total_time: Time.now.to_i,
        quiz_id: quiz_id
      )
      reaction_repository.clear
      reaction_list = []
      reaction_list << Hash[
        reaction: 'reac1',
        person_id: 1,
        stimulus_id: 1,
        quiz_id: quiz_id
      ]
      reaction_list << Hash[
        reaction: 'reac2',
        person_id: 1,
        stimulus_id: 2,
        quiz_id: quiz_id
      ]
      reaction_list << Hash[
        reaction: 'reac3',
        person_id: 1,
        stimulus_id: 3,
        quiz_id: quiz_id
      ]
      reaction_list << Hash[
        reaction: 'reac1-2',
        person_id: 2,
        stimulus_id: 1,
        quiz_id: quiz_id
      ]
      reaction_list << Hash[
        reaction: 'reac2-2',
        person_id: 2,
        stimulus_id: 2,
        quiz_id: quiz_id
      ]
      reaction_list << Hash[
        reaction: 'reac3-2',
        person_id: 2,
        stimulus_id: 3,
        quiz_id: quiz_id
      ]
      reaction_repository.create_many(reaction_list)
      user_repository.clear
      user_repository.create(
        id: 1,
        login: 'admin',
        hashed_pass: '$2a$10$MUB/egr2hes9swF0WidSyORRSFiKYnVSTcFqhEeR6zKJRUVc.65F2',
        email: 'admin@mail.ru',
        role: 'admin'
      )
      user_repository.create(
        id: 2,
        login: 'researcher',
        hashed_pass: '$2a$10$abmjS5tEGVpsyPp61Z43sOPKFdFHVrFW5Wv8jXH85WC1YIFym8ggS',
        email: 'researcher@mail.ru',
        role: 'researcher'
      )
    end

    # fill reactions for stim1 (id = 1)
    def fill_with_reactions
      reaction_repository = ReactionRepository.new
      quiz_id = 1
      reaction_list = []

      10.times do
        reaction_list << Hash[
          reaction: 'reac1',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac2',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac3',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
      end

      8.times do
        reaction_list << Hash[
          reaction: 'reac1',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac2',
          person_id: 2,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac4',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
      end

      7.times do
        reaction_list << Hash[
          reaction: 'reac5',
          person_id: 2,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac6',
          person_id: 2,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac3',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
      end

      3.times do
        reaction_list << Hash[
          reaction: 'reac1',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: 'reac6',
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
        reaction_list << Hash[
          reaction: nil,
          person_id: 1,
          stimulus_id: 1,
          quiz_id: quiz_id
        ]
      end

      reaction_repository.create_many(reaction_list)
    end
  end

  class Authentication
    def admin
      UserRepository.new.find(1)
    end

    def researcher
      UserRepository.new.find(2)
    end
  end
end
