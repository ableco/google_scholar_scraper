require "rest-client"
require "json"

module GoogleScholarScraper
  # This will fetch new valid proxies to make the requests
  class ProxyLookup
    GETPROXY_BASE_URL = "https://api.getproxylist.com/proxy".freeze
    LAST_TESTED = 600

    def self.new_tested_proxy
      proxy_obj = JSON.parse(RestClient.get(request_url))
      "https://#{proxy_obj['ip']}:#{proxy_obj['port']}"
    end

    def self.request_url
      "#{GETPROXY_BASE_URL}?#{request_options}"
    end

    def self.request_options
      "allowsHttps=1&lastTested=#{LAST_TESTED}&apiKey=#{GoogleScholarScraper.configuration.get_proxy_api_key}"
    end
  end
end
