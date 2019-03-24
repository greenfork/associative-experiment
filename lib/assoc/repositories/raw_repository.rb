# Repository for running raw SQL queries tuned for specific task
class RawRepository < Hanami::Repository
  schema {}

  def associative_core(person: {}, word_list: [])
    unless person[:sex].nil?
      w_sex = " AND sex = '#{person[:sex]}'"
    end
    unless person[:nationality1].nil?
      w_nationality1 = " AND nationality1 = '#{person[:nationality1]}'"
    end

    list = if word_list.empty?
             <<-SQL
(SELECT stimulus FROM stimuli
INTERSECT
SELECT reaction FROM reactions)
SQL
           else
             '(' + word_list.map { |w| "'#{w}'" }.join(', ') + ')'
           end

    sql = <<-SQL
SELECT stimulus, reaction, COUNT(*) AS pair_count
FROM stimuli s
JOIN reactions r ON r.stimulus_id = s.id
JOIN people p ON r.person_id = p.id
WHERE reaction IN #{list}
AND stimulus IN #{list}
#{w_sex}#{w_nationality1}
GROUP BY stimulus, reaction
ORDER BY stimulus, reaction, pair_count;
SQL

    root.read(sql)
  end
end
