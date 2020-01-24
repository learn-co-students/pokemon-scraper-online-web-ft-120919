class Pokemon
    attr_accessor :id, :name, :type, :db
    
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db        
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL

        pokemon_data = db.execute(sql, id)[0]
        id = pokemon_data[0]
        name = pokemon_data[1]
        type = pokemon_data[2]
        new_pokemon = Pokemon.new(id: id, name: name, type: type, db: db)
    end
end