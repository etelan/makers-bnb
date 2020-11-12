require 'user_class'

describe User do
  describe '.all' do
    it '.all method exists' do
      expect(User).to respond_to(:all)
    end
    it 'returns all usernames' do
      add_row_to_users_test_database
      connection = PG.connect(dbname: 'makersbnb_test')
      expect(User.all[0].username).to eq "Joe"
      expect(User.all[0].password).to eq "password"

    end
  end

  describe '.create' do
    it "create a new user" do
    user = User.create(username: 'jack_black', password: 'hello123' )
    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM users WHERE id = #{user.id};")

    expect(user).to be_a User
    expect(user.id).to eq persisted_data.first['id']
    expect(user.username).to eq 'jack_black'
    expect(BCrypt::Password.new(user.password)).to eq 'hello123'
    end
  end
  describe '.delete' do
    it 'deletes a user' do
    user = User.create(username: 'jack_black', password: 'hello123' )

    User.delete(id: user.id)

    expect(User.all.length).to eq 0
    end
  end
  #fail if password and username incorrect (2 clauses), can't sign in if already signed in
  describe 'sign_in' do
    it "sign user in" do
      user = User.create(username: 'jack_black', password: 'hello123' )
      authenticated_user = User.sign_in(username: 'jack_black', password: 'hello123' )

      expect(authenticated_user.signed_in?).to eq true
    end
    it "fail if username is incorrect" do
        user = User.create(username: 'jack_black', password: 'password')

        expect(User.sign_in(username: 'joe', password: 'password')).to be_nil
    end
    it "fail if password is incorrect" do
        user = User.create(username: 'jack_black', password: 'password')

        expect(User.sign_in(username: 'jack_black', password: 'password123')).to be_nil
    end
  end
end
