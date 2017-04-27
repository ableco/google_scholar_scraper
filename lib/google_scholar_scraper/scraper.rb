require_relative "request"
require_relative "parser"
require_relative "configuration"

module GoogleScholarScraper
  class Scraper
    def initialize
      @last_request = nil
    end

    def find_articles(google_scholar_id: nil)
      raise ArgumentError, "A 'google_scholar_id' param is required" if google_scholar_id.nil?
      request = @last_request = new_request(google_scholar_id)
      Parser.new(request.execute).parse
    end

    private

    def new_request(google_scholar_id)
      Request.new(user_profile_path(google_scholar_id), @last_request)
    end

    def user_profile_path(google_scholar_id)
      "/citations?user=#{google_scholar_id}&cstart=0&pagesize=100"
    end
  end
end
