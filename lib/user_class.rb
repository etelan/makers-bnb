require 'pg'

class User

  attr_reader :id, :username, :password

  def initialize(id:, username:, password:)
  @id = id
  @username = username
  @password = password
  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'MakersBnb')
    end

    result = connection.exec('SELECT * FROM users')
    result.map { |user| user['username']}
  end


  def self.create(username:, password:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'MakersBnb')
    end
    result = connection.exec("INSERT INTO users (username, password) VALUES('#{username}', '#{password}') RETURNING id, username, password;")
    User.new(id: result[0]['id'], username: result[0]['username'], password: result[0]['password'])
  end

  def self.delete(id:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'MakersBnb')
    end
    result = connection.exec("DELETE FROM users WHERE id = #{id}")
  end

end
