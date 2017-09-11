Hanami::Model.migration do
  change do
    create_table :people do
      primary_key :id

      column :sex, String, null: true
      column :age, Integer, null: true
      column :profession, String, null: true
      column :region, String, null: true
      column :residence_place, String, null: true
      column :birth_place, String, null: true
      column :nationality1, String, null: true
      column :nationality2, String, null: true
      column :spoken_languages, Integer, null: true
      column :native_language, String, null: true
      column :communication_language, String, null: true
      column :education_language, String, null: true
      column :date, DateTime, null: true
      column :viewed, TrueClass, defualt: 0
      column :total_time, Integer, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
