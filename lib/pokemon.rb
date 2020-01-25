class Pokemon
  
  attr_accessor :name, :type
  attr_reader :id, :db
  
  def initialize(id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id, db)
    poke = db.execute("SELECT * FROM pokemon WHERE id = ?", id)[0]
    self.new(id: poke[0], name: poke[1], type: poke[2], db: db)
  end
  
end
