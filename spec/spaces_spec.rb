require 'space'

describe Space do

  describe '.all' do
    it '.all method exists' do
      expect(Space).to respond_to(:all)
    end


    it 'returns a space' do
      add_row_to_places_test_database
      connection = PG.connect(dbname: 'makersbnb_test')
      expect(Space.all[0].name).to eq "Shed"
      expect(Space.all[0]).to be_a Space
      expect(Space.all[0].owner).to eq "Joe"
      expect(Space.all[0].availability).to eq "t"
      expect(Space.all[0].description).to eq "Lots of spiders"
      expect(Space.all[0].date).to eq "2020-11-10"
      expect(Space.all[0].price).to eq "2"

    end

  end

  describe '.create' do
    it '.create a new space' do
      space = Space.create(name: 'Shed', owner: 'Joe', availability: true, description: 'Lots of spiders', date: '2020-11-10', price: 2, renter: nil)
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
