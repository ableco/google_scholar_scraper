module GoogleScholarScraper
  # Configuration class for Google Scholar
  class Configuration
    # Sets the retry limit requesting to Google Scholar
    # Defaults to `5`
    # @return [Number]
    attr_accessor :max_retries_limit

    # Sets the API key for getproxylist.com
    # Defaults to `nil`. This will cause an exception.
    attr_accessor :get_proxy_api_key

    # Sets the logger to be used when making requests.
    # @return [Logger]
    attr_accessor :logger

    def initialize
      @max_retries_limit = 5
      @get_proxy_api_key = nil
      @logger = Logger.new(STDOUT)
    end
  end

  # Google Scholar Scraper's current config
  # @return [Google::Scholar::Scraper::Configuration]
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set Google Scholar Scraper's configuration
  # @param config [Google::Scholar::Scraper::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify Google Scholar Scraper's current configuration
  # @yieldparam [Google::Scholar::Scraper::Configuration]
  # ```
  # GoogleScholar::Scraper.configure do |config|
  #   config.proxy_url = "https://google.com"
  #   config.logger = Logger.new(STDOUT)
  # end
  # ```
  def self.configure
    yield configuration
  end
end
