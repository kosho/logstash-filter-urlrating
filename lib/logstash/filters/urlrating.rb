# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require 'net/http'
require 'uri'
require 'json'

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::URLRating < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "urlrating"
  
  # Replace the message with this value.
  # config :message, :validate => :string, :default => "Hello World!"

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

#    if @message
      # Replace the event message with our message as configured in the
      # config file.
#      event["message"] = @message
#    end

    event["url"] = event["http_protocol"] + "://" + event["dst_host"] + event["request_url"]

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example