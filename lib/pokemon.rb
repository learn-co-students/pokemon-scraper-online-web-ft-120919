class Pokemon
    attr_accessor :id, :name, :type, :db

    @@all = []

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type)
        VALUES (?,?)", [name, type])   
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]     

    end

    def self.find(id_num, db)
        pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", [id_num])
        new_id = pokemon[0][0]
        new_name = pokemon[0][1]
        new_type = pokemon[0][2]
        new_pokemon = self.new(id: new_id, name: new_name, type: new_type, db: db)
        new_pokemon

    end
end
