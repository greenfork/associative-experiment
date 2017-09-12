Hanami::Model.migration do
  change do
    alter_table :quizzes do
      add_column :quiz_language_level_flag, TrueClass, null: false, default: 1
    end
  end
end
