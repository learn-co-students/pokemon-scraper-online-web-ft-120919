require 'pry'

class Pokemon

    attr_accessor :name, :type, :db, :id

    def initialize(id: nil, name:, type:, db:)
        @name = name
        @id = id
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        # binding.pry    
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0] 
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL
        array_pk_info = db.execute(sql, id)[0]
        self.new(id: array_pk_info[0], name: array_pk_info[1], type: array_pk_info[2], db: db)
    end

end
