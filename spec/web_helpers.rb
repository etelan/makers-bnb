def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE spaces;")
  connection.exec("TRUNCATE users;")
end

def add_row_to_places_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO spaces (name, owner, availability, description, date, price) VALUES('Shed', 'Joe', TRUE, 'Lots of spiders', TO_DATE('2020-11-10', 'YYYY-MM-DD'), 2);")
end

def add_row_to_users_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO users (username, password) VALUES('Joe', 'password');" )
end
