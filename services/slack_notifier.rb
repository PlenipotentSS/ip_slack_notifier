require 'slack-notifier'
require 'socket'
require_relative 'ip_logger'

class SlackNotifier
  require 'dotenv' 
  Dotenv.load("#{File.dirname(__FILE__)}/../.env")

  # log the message to variables found in .env in root
  def log(msg)
    if !"#{ENV["SLACK_URL"]}".empty? && !"#{ENV["SLACK_CHANNEL"]}".empty?
      ping_name = Socket.gethostname
      if !"#{ENV["COMPUTER_NAME"]}".empty?
        ping_name = "#{ENV["COMPUTER_NAME"]}"
      end

      begin
        notifier = Slack::Notifier.new "#{ENV["SLACK_URL"]}", channel: "##{ENV["SLACK_CHANNEL"]}",
                                                      username: "#{ping_name}"
        notifier.ping "#{msg}"
      rescue
        logger.log("Cannot Reach Slack")
      end
    end
  end

  private

    # get the logger as object
    def logger
      @logger ||= IpLogger.new
      @logger
    end

end