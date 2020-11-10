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
      space = Space.create(name: 'Shed', owner: 'Joe', availability: true, description: 'Lots of spiders', date: "10/11/2020", price: 2)
      persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM spaces WHERE id = #{space.id};")

      expect(space).to be_a Space
      expect(space.id).to eq persisted_data.first['id']
      expect(space.name).to eq 'Shed'
      expect(space.owner).to eq 'Joe'
      expect(space.availability).to eq "t"
      expect(space.description).to eq 'Lots of spiders'
      expect(space.date).to eq "2020-11-10"
      expect(space.price).to eq "2"
    end
  end


end
