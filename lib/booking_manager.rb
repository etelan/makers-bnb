require 'pg'
require 'request'

class BookingManager

  def initialize
  @approved

  end

  def self.approve(id:)
    Request.new.approved = Request.accept(id).availability
  end


end
