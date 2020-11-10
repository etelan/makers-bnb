require 'pg'
class Space

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test') #name is slightly different
    else
      connection = PG.connect(dbname: 'MakersBnb')
    end
    result = connection.exec('SELECT * FROM spaces')
    result.map {|space| space['name']}

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
