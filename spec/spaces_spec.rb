require 'space'

describe Space do

  describe '.all' do
    it '.all method exists' do
      expect(Space).to respond_to(:all)
    end

    it 'returns a space' do
      add_row_to_places_test_database
      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.exec('SELECT * FROM spaces')
      expect(Space.all).to include "#{result[0][0]}"
    end

  end


end
