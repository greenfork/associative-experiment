Hanami::Model.migration do
  change do
    create_table :reactions do
      primary_key :id

      column :reaction, String, null: false
      column :translation, String, null: true
      column :translation_comment, String, null: true, size: 1023
      column :reaction_time, Integer, null: true
      column :keylog, String, null: true, size: 1023

      foreign_key :person_id, :people, on_delete: :cascade, on_update: :cascade, null: false
      foreign_key :stimulus_id, :stimuli, on_delete: :cascade, on_update: :cascade, null: false
      foreign_key :quiz_id, :quizzes, on_delete: :set_null, on_update: :cascade, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
