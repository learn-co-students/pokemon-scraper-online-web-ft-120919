require 'pry'
class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id= nil, name)
        @id = id
        @name = name
        @type = type        
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?,?)
        SQL
        db.execute(sql,name, type )
        # binding.pry       
    end
    def self.find(id,db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = '#{id}'
        SQL
        poke_mon = db.execute(sql)[0]
        new_pokemon = Pokemon.new(poke_mon[0], poke_mon[1])
        new_pokemon.type = poke_mon[2]
        new_pokemon        
    end
end
