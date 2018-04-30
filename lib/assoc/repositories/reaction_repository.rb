class ReactionRepository < Hanami::Repository
  associations do
    belongs_to :stimulus
    belongs_to :person
    belongs_to :quiz
  end

  def get_reactions_of(stimulus_id, person_id = nil, quiz_id = nil)
    if !quiz_id.nil?
      reactions.where(
        stimulus_id: stimulus_id, person_id: person_id, quiz_id: quiz_id
      )
    elsif !person_id.nil?
      reactions.where(stimulus_id: stimulus_id, person_id: person_id)
    else
      reactions.where(stimulus_id: stimulus_id)
    end
  end

  def create_many(list)
    time = Time.now
    list = list.map { |r| r.merge(created_at: time, updated_at: time) }
    command(:create, reactions, result: :many).call(list)
  end

  def get_dictionary(options: { reactions: {}, people: {} },
                     type: :straight,
                     reversed_with_translation: false,
                     word_list: [])
    quiz_id = options[:reactions][:quiz_id]
    reaction = options[:reactions][:reaction] # word in case of reversed dict
    nationality1 = options[:people][:nationality1]
    sex = options[:people][:sex]
    region = options[:people][:region]
    native_language = options[:people][:native_language]
    age_from = options[:people][:age_from]
    age_to = options[:people][:age_to]
    date_from = options[:people][:date_from]
    date_to = options[:people][:date_to]
    w_reaction = " AND reaction = '#{sqlc(reaction)}'" unless reaction.nil?
    unless nationality1.nil?
      w_nationality1 = " AND nationality1 = '#{sqlc(nationality1)}'"
    end
    w_sex = " AND sex = '#{sqlc(sex)}'" unless sex.nil?
    w_region = " AND region = '#{sqlc(region)}'" unless region.nil?
    unless native_language.nil?
      w_native_language = " AND native_language = '#{sqlc(native_language)}'"
    end
    unless age_from.nil? && age_to.nil?
      age_from = 0 if age_from.nil?
      age_to = 1_000 if age_to.nil?
      w_age = " AND (age BETWEEN #{Integer(age_from)} AND #{Integer(age_to)})"
    end
    unless date_from.nil? && date_to.nil?
      date_from = Time.new(0, 1, 1) if date_from.nil?
      date_to = Time.new(3000, 1, 1) if date_to.nil?
      w_date = " AND (date BETWEEN '#{date_from}' AND '#{date_to}')"
    end
    w_quiz_id = " AND r.quiz_id = #{Integer(quiz_id)}" unless quiz_id.nil?
    order = 'stimulus, pair_count DESC, reaction' if type == :straight
    order = 'reaction, pair_count DESC, stimulus' if type == :reversed
    order = 'stimulus, reaction, pair_count DESC' if type == :incidence
    if reversed_with_translation
      st_translation = ', s.translation as st_translation'
      order = 'r.translation, pair_count DESC, st_translation'
    end
    w_list = if word_list.empty? # word in case of straight dict
               ''
             else
               ' AND stimulus IN (' +
                 word_list.map { |w| "'#{w}'" }.join(', ') + ')'
             end

    if ENV['DATABASE_NAME'] == 'mysql-5.7'
      translation = 'ANY_VALUE(r.translation) as translation'
      translation_comment = 'ANY_VALUE(r.translation_comment) as translation_comment'
      if reversed_with_translation
        st_translation = ', ANY_VALUE(s.translation) as st_translation'
      end
    else
      translation = 'r.translation'
      translation_comment = 'r.translation_comment'
    end

    sql = <<-SQL.gsub(/^ */, '')
        SELECT
          r.reaction,
          #{translation},
          #{translation_comment},
          s.stimulus,
          COUNT(*) as pair_count
          #{st_translation}
        FROM reactions r
        JOIN stimuli s ON s.id = r.stimulus_id
        JOIN people p ON p.id = r.person_id
        WHERE 1 = 1#{w_quiz_id}#{w_reaction}#{w_nationality1}#{w_sex}#{w_list}
        #{w_region}#{w_age}#{w_native_language}#{w_date}
        GROUP BY reaction, stimulus
        ORDER BY #{order}
    SQL
    root.read(sql).to_a
  end

  private

  def sqlc(string)
    string.gsub("'", "''")
  end
end
