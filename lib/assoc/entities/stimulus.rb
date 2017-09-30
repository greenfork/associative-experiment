class Stimulus < Hanami::Entity
  # workaround for fields_for_collection in views/quiz/main.erb
  def dig(key)
    nil
  end
end
