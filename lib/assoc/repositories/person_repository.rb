class PersonRepository < Hanami::Repository
  associations do
    has_many :reactions
  end
end
