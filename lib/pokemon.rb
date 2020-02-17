class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, id:nil, db:)
        @name = name
        @type = type
        @id = id
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) VALUES (?,?);
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon WHERE id = ? ;
        SQL

        row = db.execute(sql, id).flatten
        Pokemon.new(id:row[0], name:row[1], type:row[2], db:db)
    end



end
