module GoogleScholarScraper
  # Configuration class for Google Scholar
  class Configuration
    # The proxy url to use for the requests to Google Scholar.
    # Defaults to `nil`, which causes the requests to be run in
    # simple mode.
    # @return [String]
    attr_accessor :proxy_url

    # Sets the logging utility to be used for log requests
    # @return [Logger]
    attr_accessor :logger

    def initialize
      @proxy_url = nil
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
