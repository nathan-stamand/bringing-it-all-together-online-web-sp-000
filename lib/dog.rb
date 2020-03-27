class Dog 
  attr_accessor :id, :name, :breed
  
  def initialize(name:, breed:, id:nil)
    @name = name
    @breed = breed 
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL 
    CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT)
    SQL
    
    DB[:conn].execute(sql)
    
  end
  
  def self.drop_table 
    
    sql = <<-SQL 
    DROP TABLE IF EXISTS dogs
    SQL
    
    DB[:conn].execute(sql)
  end 
  
  def self.new_from_db(row)
    dog = Dog.new(name:row[1], breed:row[2], id:row[0])
    dog
  end 
  
  def self.find_by_name(name)
    
    sql = <<-SQL 
    SELECT * FROM dogs 
    WHERE name = ?
    SQL
    
    DB[:conn].execute(sql, name)
    
  end
  
  def save 
    sql = <<-SQL 
    INSERT INTO dogs (name, breed) VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.breed) 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")
  
    
  end
  
  def self.create(dog_hash)
    dog = Dog.new(name:dog_hash[:name], breed:dog_hash[:breed], id:nil)
    dog
  end 
  
end 