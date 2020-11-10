require 'space'

describe Space do

  describe '.all' do
    it '.all method exists' do
      expect(Space).to respond_to(:all)
    end


    it 'returns a space' do
      add_row_to_places_test_database
      connection = PG.connect(dbname: 'makersbnb_test')
      expect(Space.all).to include("Shed")

    end

  end

  describe '.create' do
    it '.create a new space' do
      Space.create(name: 'Shed', owner: 'Joe', availability: 'TRUE', description: 'Lots of spiders', date: "TO_DATE('10/11/2020', 'DD/MM/YYYY')", price: 2)
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec('SELECT * FROM spaces')
      expect(Space.all).to include('Shed')
    end
  end


end
