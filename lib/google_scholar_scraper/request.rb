require "nokogiri"
require "rest-client"
require "useragents"
require_relative "proxy_lookup"

module GoogleScholarScraper
  # Wrapper for making the requests to Google Scholar
  class Request
    BASE_URL = "https://scholar.google.com".freeze
    ERROR_EXCEPTIONS = [
      RestClient::Forbidden, RestClient::ServerBrokeConnection, Net::HTTPServerException,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError,
      Errno::EINVAL, Errno::ECONNREFUSED, Errno::ECONNRESET, EOFError
    ].freeze

    def initialize(path, last_request = nil)
      @path = path
      @previous_user_agent = last_request.user_agent if last_request
    end

    def execute
      Nokogiri::HTML(execute_with_retries)
    end

    def execute_with_retries
      begin
        response = google_scholar_request
      rescue *ERROR_EXCEPTIONS => err
        @retries ||= 0

        if @retries < max_retries_limit || net_http_error?(err)
          @retries += 1
          retry
        else
          raise err
        end
      end
      response
    end

    def user_agent
      @user_agent ||= generate_user_agent
    end

    private

    attr_reader :path, :previous_user_agent

    def max_retries_limit
      GoogleScholarScraper.configuration.max_retries_limit
    end

    def google_scholar_request
      proxy_url = ProxyLookup.new_tested_proxy
      logger.info("GoogleScholarScraper: Requesting #{path} with user agent #{user_agent} and proxy #{proxy_url}")
      RestClient::Request.execute(
        url: request_url,
        method: :get,
        verify_ssl: false,
        user_agent: user_agent,
        proxy: proxy_url
      )
    end

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

    def net_http_error?(err)
      err.response.is_a?(Net::HTTPForbidden) ||
        err.response.is_a?(Net::HTTPFatalError)
    end
  end
end
