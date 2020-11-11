require 'pg'

class User

  attr_reader :id, :username, :password, :signed_in

  def initialize(id:, username:, password:)
  @id = id
  @username = username
  @password = password
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
    result = connection.exec("INSERT INTO users (username, password) VALUES('#{username}', '#{password}') RETURNING id, username, password;")
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

  def sign_in(username:, password:)
    raise "Your password is incorrect" if User.authentication(username, password)
    @signed_in = true
  end

  def sign_out
    @signed_in = false
  end

  private

  def self.authentication(username, password)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    count = 0
    User.all.each {|user| if user.username == username
    count += 1
    end
    raise "Your username doesn't exist" if count < 1
    }
    
    result = connection.exec("SELECT * FROM users WHERE username = '#{username}' ")
    result[0]['password'] != password ? true : false

  end


end
