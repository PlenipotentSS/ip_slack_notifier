class IpLogger
  require 'logger'

  # initialize ip logger
  def initialize
    @logger = Logger.new("#{File.dirname(__FILE__)}/../log/ip_logger.log", 'monthly')
  end

  # log message to logger file
  def log(msg)
    @logger.debug "#{msg}"
  end

end