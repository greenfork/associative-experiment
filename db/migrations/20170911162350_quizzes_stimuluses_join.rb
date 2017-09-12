Hanami::Model.migration do
  change do
    create_table :quizzes_stimuluses_join do
      # many-to-many connection table
      foreign_key :quiz_id, :quizzes, on_delete: :cascade, on_update: :cascade
      foreign_key :stimulus_id, :stimuli, on_delete: :cascade, on_update: :cascade
      primary_key [:quiz_id, :stimulus_id]
      index [:quiz_id, :stimulus_id]
    end
  end
end
