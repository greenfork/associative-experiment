Hanami::Model.migration do
  change do
    create_table :stimuluses do
      primary_key :id

      column :stimulus, String, null: false, unique: true
      column :translation_komi, String, null: true
      column :translation_yakut, String, null: true
      column :translation_buryat, String, null: true
      column :translation_tatar, String, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
