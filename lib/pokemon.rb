class Pokemon
    attr_accessor :name, :type, :db, :id
    #attr_reader :id

    def initialize(attr_hash)
        attr_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}=")
        end
    end

    def self.save(name, type, db)
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
        attr_hash = {:id => "nil", :name => "nil", :type => "nil"}    
        attr_hash[:id] = db.execute(sql, id)[0][0]
        attr_hash[:name] = db.execute(sql, id)[0][1]
        attr_hash[:type] = db.execute(sql, id)[0][2]
        pokemon = Pokemon.new(attr_hash)

    end
end
