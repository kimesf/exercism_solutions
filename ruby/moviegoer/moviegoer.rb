class NotMovieClubMemberError < RuntimeError; end

class Moviegoer
  attr_reader :ticket_price
  
  ELDER_AGE_RANGE = (60..Float::INFINITY).freeze
  OF_AGE_RANGE    = (18..Float::INFINITY).freeze
  TICKET_PRICE    = 15
  OLD_AGE_PENSION = 5
  
  def initialize(age, member: false)
    @age = age
    @member = member
    @ticket_price = TICKET_PRICE
    
    eval_discounts
  end

  def eval_discounts
    @ticket_price -= OLD_AGE_PENSION if elder?
  end

  def watch_scary_movie? = of_age?

  def claim_free_popcorn!
    raise(NotMovieClubMemberError) unless @member

    "🍿"
  end

  private

  def of_age? = OF_AGE_RANGE.include?(@age)

  def elder? = ELDER_AGE_RANGE.include?(@age)
end
