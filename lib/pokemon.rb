class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id: nil, name: nil, type: nil, db:nil)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
    db.execute(sql, name, type)
    get_id_sql = "SELECT last_insert_rowid() FROM pokemon;"
    new_id = db.execute(get_id_sql)[0][0]
    new(id: new_id, name: name, type: type, db: db)
  end

  def self.find(search_id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?;"
    row = db.execute(sql, search_id)[0]
    id, name, type = row[0..2]
    new(id: id, name: name, type: type, db: db)
  end
end
