Hanami::Model.migration do
  change do
    create_table :quizzes do
      primary_key :id

      column :title, String, null: false
      column :language, String, null: false
      column :is_active, TrueClass, default: 0, null: false
      column :is_reviewed_automatically, TrueClass, default: 1, null: false
      # person flags (whether these attributes should be asked to fill in)
      column :sex_flag, TrueClass, default: 1, null: false
      column :age_flag, TrueClass, default: 1, null: false
      column :profession_flag, TrueClass, default: 1, null: false
      column :region_flag, TrueClass, default: 1, null: false
      column :residence_place_flag, TrueClass, default: 1, null: false
      column :birth_place_flag, TrueClass, default: 1, null: false
      column :nationality1_flag, TrueClass, default: 1, null: false
      column :nationality2_flag, TrueClass, default: 1, null: false
      column :spoken_languages_flag, TrueClass, default: 1, null: false
      column :native_language_flag, TrueClass, default: 1, null: false
      column :communication_language_flag, TrueClass, default: 1, null: false
      column :education_language_flag, TrueClass, default: 1, null: false
      column :quiz_language_level_flag, TrueClass, default: 1, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
