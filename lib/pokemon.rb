class Pokemon
    attr_accessor :id, :name, :type, :db, :hp
    def initialize(id:,name:,type:,db:,hp:nil)
        @id = id 
        @name = name
        @type = type 
        @db = db
    end 
        
    def self.save(name,type,db)
            sql = <<-DUMPSTERFIRE
                INSERT INTO pokemon (name,type)
                VALUES (?,?)
            DUMPSTERFIRE
            db.execute(sql,name,type)
    end 
    def self.find(id,db)
        sql = <<-JESUSCHRISTFIXME
            SELECT * FROM pokemon WHERE id == ?
        JESUSCHRISTFIXME
        db.execute(sql,i)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]

    end 
end 
yield
