require 'pg'
class Space

  attr_reader :id, :name, :owner, :availability, :description, :date, :price

  def initialize(id:,name:, owner:, availability:, description:, date:, price:)
    @id = id
    @name = name
    @owner = owner
    @availability = availability
    @description = description
    @date = date
    @price = price 
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test') #name is slightly different
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec('SELECT * FROM spaces')
    result.map {|space| 
      Space.new(
        space['id'], 
        space['name'], 
        space['owner'], 
        space['availability'], 
        space['description'],
        space['date'],
        space['price'],        
        )}

  end

  def self.create(name:, owner:, availability:, description:, date:, price:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test') #name is slightly different
    else
      connection = PG.connect(dbname: 'MakersBnb')
    end
    result = connection.exec("INSERT INTO spaces (name, owner, availability, description, date, price) VALUES('#{name}', '#{owner}', #{availability}, '#{description}', TO_DATE('#{date}', 'DD/MM/YYYY'), #{price}) RETURNING id, name, owner, availability, description, date, price ;")
    Space.new(id: result[0]['id'] , name: result[0]['name'], owner: result[0]['owner'], availability: result[0]['availability'], description: result[0]['description'], date: result[0]['date'] , price: result[0]['price'] )
  end

end
