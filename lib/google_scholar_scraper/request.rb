require "nokogiri"
require "rest-client"
require "useragents"

module GoogleScholarScraper
  # Wrapper for making the requests to Google Scholar
  class Request
    BASE_URL = "https://scholar.google.com".freeze

    def initialize(path, last_request = nil)
      @path = path
      @previous_user_agent = last_request.user_agent
    end

    def get
      Nokogiri::HTML(RestClient.get(request_url, user_agent: user_agent))
    end

    def user_agent
      new_user_agent = nil
      loop do
        new_user_agent = UserAgents.rand
        return if new_user_agent != previous_user_agent
      end
      new_user_agent
    end

    private

    attr_reader :path
    attr_writer :previous_user_agent

    def request_url
      "#{BASE_URL}#{path}"
    end
  end
end
