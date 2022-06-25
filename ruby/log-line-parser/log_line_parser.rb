class LogLineParser
  attr_reader :log_level, :message
  
  def initialize(line)
    _line, @log_level, @message = line.match(/\[(.+)\]:(.+)/).to_a
    
    @message.strip!
    @log_level.downcase!
  end

  def reformat = "#{@message} (#{@log_level})"
end
