class Pokemon
# responsible for saving, adding, removing, or changing anything about each Pokémon.
  attr_accessor :id, :name, :type, :db

  def initialize (id: nil, name: , type: , db: nil)
    @id, @name, @type= id, name, type
    if !@db.nil?
      @db = db
    end
  end

  def update
    sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
    @db.execute(sql, self.name, self.type, self.id)
  end

  def self.drop_table
    sql =  <<-SQL
     DROP TABLE IF EXISTS pokemon
    SQL
    @db.execute(sql)
  end

  def self.save(nm, typ, db)
      sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
      SQL
      db.execute(sql, nm, typ)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.create(name, type)
    pokemon = Pokeman.new(name, type)
    pokemon.save
    pokemon
  end

  def self.find(id, db)
    sql = <<-SQL
     SELECT *
     FROM pokemon
     WHERE id = ?
     LIMIT 1
    SQL
    db.execute(sql, id).map do |row|
      self.new_from_db(row,db)
    end.first
  end

  def self.new_from_db(row, dbc)
    id = row[0]
    name =  row[1]
    type = row[2]
    pokemon = self.new(id:id,name:name, type:type,  db: dbc)
    pokemon  # return the newly created instance
  end

end
