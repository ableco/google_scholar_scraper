require "nokogiri"
require "rest-client"
require "useragents"

module GoogleScholarScraper
  # Wrapper for making the requests to Google Scholar
  class Request
    BASE_URL = "https://scholar.google.com".freeze

    def initialize(path, last_request = nil)
      @path = path
      @previous_user_agent = last_request.user_agent if last_request
    end

    def get
      logger.info("GoogleScholarScraper: Requesting #{path} with user agent #{user_agent}")
      Nokogiri::HTML(
        RestClient::Request.execute(
          url: request_url,
          method: :get,
          verify_ssl: false,
          user_agent: user_agent,
          proxy: GoogleScholarScraper.configuration.proxy_url
        )
      )
    end

    def user_agent
      @user_agent ||= generate_user_agent
    end

    private

    attr_reader :path, :previous_user_agent

    def generate_user_agent
      tmp_user_agent = UserAgents.rand
      tmp_user_agent = generate_user_agent if tmp_user_agent == previous_user_agent
      tmp_user_agent
    end

    def request_url
      "#{BASE_URL}#{path}"
    end

    def logger
      GoogleScholarScraper.configuration.logger
    end
  end
end
