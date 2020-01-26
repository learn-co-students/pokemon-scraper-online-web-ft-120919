class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize (id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save (name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find (id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    array = db.execute(sql, id).first
    student = self.new(id: array[0], name: array[1], type: array[2], db: db)
    student
  end
end
