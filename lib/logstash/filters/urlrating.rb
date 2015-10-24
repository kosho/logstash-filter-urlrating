# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require 'net/http'
require 'uri'
require 'cgi'
require 'json'

class LogStash::Filters::URLRating < LogStash::Filters::Base

  config_name "urlrating"
  
  config :message, :validate => :string, :default => ""
  config :target, :validate => :string, :default => "rating"
  config :server, :validate => :string, :default => "http://localhost:4126/v1/web/uri/rate.json?uri="

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    if @message
      urls = URI.extract(event["message"])
      if !urls.empty? then
        begin
          url_escaped = CGI.escape(urls[0])
          json = Net::HTTP.get(URI.parse(server + url_escaped))
          result = JSON.parse(json)
          event[target] = result["rating"]["wrs"]["score"]
        rescue => e
          puts e
        end
      end
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::URLRating
