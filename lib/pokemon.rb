class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize(id: 1, name: "Pikachu", type: "electric", db: @db)
    @id = id
    @name =  name
    @type = type
    @db = db 
  end #initialize

  def self.save(a_name, a_type, a_db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    a_db.execute(sql, a_name, a_type)
  end #save

  def self.find(a_id, a_db)
    sql = <<-SQL
      SELECT * FROM pokemon
      WHERE id = ?
      LIMIT 1
    SQL

    row = a_db.execute(sql, a_id)[0]
    self.new(id: row[0], name: row[1], type: row[2])

  end #self.find

end
