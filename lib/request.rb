require 'pg'


class Request
  attr_accessor :approved

  def initialize
  @approved = false

  end

  def self.accept(id:, requester:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
     result = connection.exec("UPDATE spaces SET availability = NOT availability, renter = '#{requester.username}' WHERE id = #{id} RETURNING id, name, owner, availability, description, date, price, renter;")

     Space.new(id: result[0]['id'] , name: result[0]['name'], owner: result[0]['owner'], availability: result[0]['availability'], description: result[0]['description'], date: result[0]['date'] , price: result[0]['price'], renter: result[0]['renter'] )

  end






end
