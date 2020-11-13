require 'pg'
require 'bcrypt'

class User

  attr_reader :id, :username, :password, :signed_in
  attr_writer :signed_in

  def initialize(id:, username:, password:)
  @id = id
  @username = username
  @password = password
  @signed_in = false
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec('SELECT * FROM users')
    result.map { |user|
    User.new(
      id: user['id'],
      username: user['username'],
      password: user['password']
      )}
  end


  def self.create(username:, password:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    encrypted_password = BCrypt::Password.create(password)
    result = connection.exec("INSERT INTO users (username, password) VALUES('#{username}', '#{encrypted_password}') RETURNING id, username, password;")
    @user = User.new(id: result[0]['id'], username: result[0]['username'], password: result[0]['password'])
  end

  def self.find(number)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
     result = connection.exec("SELECT * FROM users WHERE id = #{number}")
     User.new(id: result[0]['id'], username: result[0]['username'], password: result[0]['password'])
  end

  def self.delete(id:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec("DELETE FROM users WHERE id = #{id}")
  end

  def signed_in?
    @signed_in
  end

  def self.sign_in(username:, password:)

    user = User.authentication(username, password)
    if user.nil?
      user
    else
      user.signed_in = true
      user
    end
    # raise "Your password is incorrect" if User.authentication(username, password)
    # @signed_in = true
  end

  def sign_out
    @signed_in = false
  end

  def self.authentication(username, password)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.query("SELECT * FROM users WHERE username = '#{username}'")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], username: result[0]['username'], password: result[0]['password'])
  end


end
