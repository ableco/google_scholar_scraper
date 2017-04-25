require_relative "request"
require_relative "parser"
require_relative "configuration"

module GoogleScholarScraper
  class Scraper
    def initialize
      @last_request = nil
      set_rest_client_proxy
    end

    def find_articles(google_scholar_id: nil)
      raise ArgumentError, "A 'google_scholar_id' param is required" if google_scholar_id.nil?
      request = @last_request = new_request
      GoogleScholar::Scraper::Parser.new(request.get).parse
    end

    private

    def new_request
      GoogleScholar::Scraper::Request.new(user_profile_path(google_scholar_id), @last_request)
    end

    def user_profile_path(google_scholar_id)
      "/citations?user=#{google_scholar_id}&cstart=0&pagesize=100"
    end

    def set_rest_client_proxy
      RestClient.proxy = GoogleScholar::Scraper.configuration.proxy_url
    end
  end
end
