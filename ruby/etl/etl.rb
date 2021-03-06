class ETL
  def self.transform(old)
    old.each_with_object({}) do |(points, letters), result|
      letters.each { |letter| result[letter.downcase] = points }
    end
  end
end
