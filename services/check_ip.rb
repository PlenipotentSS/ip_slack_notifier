require_relative 'ip_logger'
require_relative 'slack_notifier'

class CheckIp
  require 'net/http'
  require 'uri'

  #filename to temporary current ip file
  @@filename = "#{File.dirname(__FILE__)}/../tmp/current_ip"

  #
  # run the checker in one class call
  def self.run
    checker = CheckIp.new
    checker.check
  end

  #
  # check ifconfig.co/ip to for the current ip and
  # manage writing and reading past ip
  def check
    uri = URI.parse("https://ifconfig.co/ip")
    begin
      response = Net::HTTP.get_response(uri)
      if response.code == "200" || response.code == 200
        current_ip = "#{response.body}".strip
        saved_ip = "#{read_current_ip}".strip
        if current_ip != saved_ip
          logger.log("New IP: #{current_ip}")
          slack_notifier.log("New IP: #{current_ip}")
          write_current_ip(current_ip)
        end
      else
        logger.log("Cannot Reach ifconfig.co")
      end
    rescue => e
      logger.log("Error checking IFCONFIG")
      logger.log("#{e.inspect}")
    end
    nil
  end

  # 
  # read current ip address from file
  # nil otherwise
  def read_current_ip
    if File.exist?(@@filename)
      File.open(@@filename, &:gets)
    end
  end

  #
  # write the ip to the current file
  def write_current_ip(this_ip)
    if File.exists?(@@filename)
      File.delete(@@filename)
    end
    out_file = File.new(@@filename, "w+")
    out_file.puts("#{this_ip}")
    out_file.close
  end

  private

    # get the slack notifier as object
    def slack_notifier
      @notifier ||= SlackNotifier.new
      @notifier
    end

    # get the logger as object
    def logger
      @logger ||= IpLogger.new
      @logger
    end

end