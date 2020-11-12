# feature 'authentication' do
#   it 'a user can sign in' do
#     # Create a test user
#     User.create(username: 'Joe', password: 'password')
#
#     # Then sign in as them
#     visit '/login'
#     fill_in(:username, with: 'Joe')
#     fill_in(:password, with: 'password')
#     click_button('Submit')
#
#     expect(page).to have_content 'Welcome, test@example.com'
#   end
# end
