require 'pg'
class Space

  attr_accessor :id, :name, :owner, :availability, :description, :date, :price

  def initialize(id, name, owner, availability, description, date, price)
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

    add_row_to_places_test_database

  end

end
