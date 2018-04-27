Hanami::Model.migration do
  change do
    create_table :stimuli do
      primary_key :id

      column :stimulus, String, size: 191, null: false, unique: true
      column :translation, String, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
