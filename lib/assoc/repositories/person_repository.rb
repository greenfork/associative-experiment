class PersonRepository < Hanami::Repository
  associations do
    has_many :reactions
  end

  NIL_VALUES = [nil, '', '/']

  def distinct(field)
    raise "field must be symbol but currently is #{field} of type \
#{field.class}" unless field.is_a? Symbol
    people.select(field).to_a.map(&field).uniq
          .reject { |e| NIL_VALUES.include? e }.sort
  end
end
