require 'pg'
require 'time'

class Space

  attr_reader :id, :name, :owner, :availability, :description, :date, :price, :renter
  attr_writer :availability, :renter

  def initialize(id:,name:, owner:, availability:, description:, date:, price:, renter:)
    @id = id
    @name = name
    @owner = owner
    @availability = availability
    @description = description
    @date = date
    @price = price
    @renter = renter
  end

  def self.find(number)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
     result = connection.exec("SELECT * FROM spaces WHERE id = #{number}")

     Space.new(id: result[0]['id'], name: result[0]['name'], owner: result[0]['owner'],
      availability: result[0]['availability'], description: result[0]['description'],
      date: result[0]['date'], price: result[0]['price'], renter: result[0]['renter'])
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
        id: space['id'],
        name: space['name'],
        owner: space['owner'],
        availability: space['availability'],
        description: space['description'],
        date: space['date'],
        price: space['price'],
        renter: space['renter']
        )}

  end

  def self.create(name:, owner:, availability:, description:, date:, price:, renter:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test') #name is slightly different
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    name = name.gsub("'"){"''"}
    description = description.gsub("'"){"''"}
    result = connection.exec("INSERT INTO spaces (name, owner, availability, description, date, price, renter) VALUES('#{name}', '#{owner}', #{availability}, '#{description}', TO_DATE('#{date}', 'YYYY-MM-DD'), #{price}, '#{renter}') RETURNING id, name, owner, availability, description, date, price, renter ;")
    Space.new(id: result[0]['id'] , name: result[0]['name'], owner: result[0]['owner'], availability: result[0]['availability'], description: result[0]['description'], date: result[0]['date'] , price: result[0]['price'], renter: result[0]['renter'] )

  end

  # This Function is run when it is created.
  # If the date set is before today,
  def self.date_available?(date)
    time_now = Time.now.strftime('%F')
    compare = date

    time_now > compare
  end



end
