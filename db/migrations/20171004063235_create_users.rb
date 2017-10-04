Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :login, String, null: false
      column :hashed_pass, String, null: false
      column :email, String, null: true
      column :role, String, null: true
      column :token, String, null: true
      column :password_reset_sent_at, DateTime, null: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
