require 'rspec'
require 'request'
require 'Space'

describe Request do
describe '.accept' do
  it 'accept request' do
    user = User.create(username: 'jack_black', password: 'hello123' )
    space = Space.create(name: 'Shed', owner: 'Joe', availability: true, description: 'Lots of spiders', date: '2020-11-10', price: 2, renter: nil)
    accepted = Request.accept(id: space.id, requester: user)
    expect(accepted.availability).to eq('f')
  end
end
end
