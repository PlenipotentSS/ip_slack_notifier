#IP Slack Notifier
A simple ruby app that notifies via slack any public ip changes. Currently uses ifconfig.co website for public IP. This assumes you have ```ruby``` and ```bundler``` installed.

##To use:

1. Run ```bundle install```
2. Create file ```.env``` file in root:

  ```
    SLACK_URL={{SLACK API URL}}
    SLACK_CHANNEL={{channel to post to}}
    COMPUTER_NAME={{computer identifier}}
  ```

3. Modify schedule to run as much as needed.
4. run ```whenever --update-crontab```

##Logs
For any issues check ```log/ip_logger.log``` for any issues