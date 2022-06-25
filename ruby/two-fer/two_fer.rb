class TwoFer
  RESPONSE = 'One for %<name>s, one for me.'
  PRONOUN  = 'you'

  def self.two_fer(name = PRONOUN) = format(RESPONSE, { name: })
end
