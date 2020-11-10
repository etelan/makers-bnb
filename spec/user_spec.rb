require 'user_class'

describe User do
  describe '.all' do
    it '.all method exists' do
      expect(User).to respond_to(:all)
    end
    it 'returns all usernames' do
      add_row_to_users_test_database
      connection = PG.connect(dbname: 'makersbnb_test')
      expect(User.all).to include "Joe"

    end
  end

  describe '.create' do
    it "create a new user" do
    user = User.create(username: 'jack_black', password: 'hello123' )
    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM users WHERE id = #{user.id};")

    expect(user).to be_a User
    expect(user.id).to eq persisted_data.first['id']
    expect(user.username).to eq 'jack_black'
    expect(user.password).to eq 'hello123'
    end
  end
  describe '.delete' do
    it 'deletes a user' do
    user = User.create(username: 'jack_black', password: 'hello123' )

    User.delete(id: user.id)

    expect(User.all.length).to eq 0
    end
  end
end
