# Logstash URL Rating Plugin

This is a plugin for [Logstash](https://github.com/elastic/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Requirements

This plugin needs Trend Micro's URL rating engine.

## Building and Installation

First go to the root of the repository and run `gem build` command.

```sh
cd logstash-filter-urlrating
gem build ./logstash-filter-urlrating.gemspec
```

Run `plugin install` command to install the generated gem file to the appropriate location.

```sh
/opt/logstash/bin/plugin install logstash-filter-urlrating-0.1.2.gem
```

## Logstash Configuration

This filter plugin takes the `target` and the `server` variables in the configuration file.

```ruby
filter {
  urlrating {
    target => "rating"
    server => "http://local:4126/v1/web/uri/rate.json?uri="
  }
}
```

The default values of those are described above. You may specified the URL to the URL rating service whenever installed on a different server.

## Testing

You can pass any log which contains a URL-like string to the filter via the standard input.

```sh
cat /var/log/squid/access.log | /opt/logstash/bin/logstash -e 'input { stdin{} } filter { urlrating {} } output {stdout { codec => rubydebug }}'
```

You will find the field like `"rating": 81` from the output.
