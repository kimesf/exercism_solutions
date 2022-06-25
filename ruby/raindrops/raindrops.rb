class Raindrops
  SOUNDS_BY_FACTOR = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }.freeze
  
  def self.convert(n)
    result = SOUNDS_BY_FACTOR.reduce('') do |memo, (factor, sound)|
      memo += sound if (n % factor).zero?
      memo
    end

    result.empty? ? n.to_s : result
  end
end
